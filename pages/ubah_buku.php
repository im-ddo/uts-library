<?php
// proteksi agar file tidak dapat diakses langsung
if (!defined('MY_APP')) {
    die('Akses langsung tidak diperbolehkan!');
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    echo "ID buku tidak boleh kosong.";
    exit;
}

$id = (int)$_GET['id'];

// Ambil data buku dari database
$sql = "SELECT * FROM buku WHERE id_buku = ?";
$stmt = $mysqli->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    echo "Data buku tidak ditemukan.";
    exit;
}

$buku = $result->fetch_assoc();
$stmt->close();

$pesan = '';
$pesan_error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $judul = $_POST['judul_buku'] ?? '';
    $penulis = $_POST['penulis'] ?? '';
    $penerbit = $_POST['penerbit'] ?? '';
    $tahun_terbit = $_POST['tahun_terbit'] ?? '';
    $stok = $_POST['stok'] ?? '';
    $kategori = isset($_POST['kategori']) ? $_POST['kategori'] : [];

    // Proses upload cover (opsional)
    $cover_name = $buku['cover_buku']; // pakai cover lama kalau tidak diganti
    if (!empty($_FILES['cover']['name'])) {
        $target_dir = "uploads/";
        if (!is_dir($target_dir)) mkdir($target_dir, 0777, true);
        $file_name = time() . "_" . basename($_FILES['cover']['name']);
        $target_file = $target_dir . $file_name;

        if (move_uploaded_file($_FILES['cover']['tmp_name'], $target_file)) {
            $cover_name = $file_name;
        }
    }

    $sql_update = "UPDATE buku 
                   SET judul = ?, penulis = ?, penerbit = ?, tahun_terbit = ?, stok = ?, cover_buku = ? 
                   WHERE id_buku = ?";
    if ($stmt = $mysqli->prepare($sql_update)) {
        $stmt->bind_param("ssssssi", $judul, $penulis, $penerbit, $tahun_terbit, $stok, $cover_name, $id);

        if ($stmt->execute()) {
            $stmt->close();

            // Hapus kategori lama
            $mysqli->query("DELETE FROM buku_kategori WHERE id_buku = $id");

            // Tambahkan kategori baru (kalau ada)
            if (!empty($kategori)) {
                $sql_relasi = "INSERT INTO buku_kategori (id_buku, id_kategori) VALUES (?, ?)";
                $stmt_relasi = $mysqli->prepare($sql_relasi);
                foreach ($kategori as $id_kat) {
                    $stmt_relasi->bind_param("ii", $id, $id_kat);
                    $stmt_relasi->execute();
                }
                $stmt_relasi->close();
            }

            $pesan = "Data buku berhasil diperbarui.";
            // Refresh data buku setelah update
            $sql = "SELECT * FROM buku WHERE id_buku = ?";
            $stmt = $mysqli->prepare($sql);
            $stmt->bind_param("i", $id);
            $stmt->execute();
            $buku = $stmt->get_result()->fetch_assoc();
            $stmt->close();
        } else {
            $pesan_error = "Gagal memperbarui data buku: " . $mysqli->error;
        }
    }
}
?>

<div class="container-fluid px-4">
    <h1 class="mt-4">Ubah Buku</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Ubah Buku</li>
    </ol>

    <?php if (!empty($pesan)) : ?>
        <div class="alert alert-success" role="alert"><?php echo $pesan; ?></div>
    <?php endif; ?>

    <?php if (!empty($pesan_error)) : ?>
        <div class="alert alert-danger" role="alert"><?php echo $pesan_error; ?></div>
    <?php endif; ?>

    <div class="card mb-4">
        <div class="card-body">
            <form method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="judul_buku" class="form-label">Judul Buku</label>
                    <input type="text" name="judul_buku" class="form-control" id="judul_buku"
                        value="<?php echo htmlspecialchars($buku['judul']); ?>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pilih Kategori</label><br>
                    <?php
                    // Ambil semua kategori
                    $sql_kategori = "SELECT * FROM kategori ORDER BY nama_kategori ASC";
                    $result_kategori = $mysqli->query($sql_kategori);

                    // Ambil kategori buku yang sudah dipilih
                    $kategori_buku = [];
                    $sql_relasi = "SELECT id_kategori FROM buku_kategori WHERE id_buku = ?";
                    if ($stmt_relasi = $mysqli->prepare($sql_relasi)) {
                        $stmt_relasi->bind_param("i", $id);
                        $stmt_relasi->execute();
                        $result_relasi = $stmt_relasi->get_result();
                        while ($row = $result_relasi->fetch_assoc()) {
                            $kategori_buku[] = $row['id_kategori'];
                        }
                        $stmt_relasi->close();
                    }

                    while ($kat = $result_kategori->fetch_assoc()):
                    ?>
                        <label class="me-3">
                            <input type="checkbox" name="kategori[]" value="<?php echo $kat['id_kategori']; ?>"
                                <?php echo in_array($kat['id_kategori'], $kategori_buku) ? 'checked' : ''; ?>>
                            <?php echo htmlspecialchars($kat['nama_kategori']); ?>
                        </label>
                    <?php endwhile; ?>
                </div>

                <div class="mb-3">
                    <label for="penulis" class="form-label">Penulis</label>
                    <input type="text" name="penulis" class="form-control" id="penulis"
                        value="<?php echo htmlspecialchars($buku['penulis']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="penerbit" class="form-label">Penerbit</label>
                    <input type="text" name="penerbit" class="form-control" id="penerbit"
                        value="<?php echo htmlspecialchars($buku['penerbit']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="tahun_terbit" class="form-label">Tahun Terbit</label>
                    <input type="number" name="tahun_terbit" class="form-control" id="tahun_terbit"
                        value="<?php echo htmlspecialchars($buku['tahun_terbit']); ?>" required>
                </div>
                <div class="mb-3">
                    <label for="stok" class="form-label">Stok</label>
                    <input type="number" name="stok" class="form-control" id="stok"
                        value="<?php echo htmlspecialchars($buku['stok']); ?>" required>
                </div>

                <div class="mb-4">
                    <label for="cover" class="form-label">Upload Cover</label>
                    <input type="file" name="cover" class="form-control" id="cover">
                    <?php if (!empty($buku['cover_buku'])) : ?>
                        <small class="text-muted">Cover saat ini:</small><br>
                        <img src="uploads/<?php echo $buku['cover_buku']; ?>" alt="Cover Buku"
                             style="max-width: 120px; border-radius: 8px;">
                    <?php endif; ?>
                </div>

                <button type="submit" class="btn btn-primary">Simpan</button>
                <a href="index.php?hal=daftar_buku" class="btn btn-danger">Kembali</a>
            </form>
        </div>
    </div>
</div>

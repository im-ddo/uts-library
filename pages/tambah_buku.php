<?php
// proteksi agar file tidak dapat diakses langsung
if (!defined('MY_APP')) {
    die('Akses langsung tidak diperbolehkan!');
}

// Pesan feedback
$pesan = '';
$pesan_error = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Ambil data dari form
    $judul = $_POST['judul_buku'] ?? '';
    $penulis = $_POST['penulis'] ?? '';
    $penerbit = $_POST['penerbit'] ?? '';
    $tahun_terbit = $_POST['tahun_terbit'] ?? '';
    $stok = $_POST['stok'] ?? '';
    $kategori = isset($_POST['kategori']) ? $_POST['kategori'] : []; // array kategori

    // Upload cover (boleh kosong)
    $cover_name = null;
    if (!empty($_FILES['cover']['name'])) {
        $target_dir = "uploads/"; // pastikan foldernya ada
        if (!is_dir($target_dir)) mkdir($target_dir, 0777, true);
        $file_name = time() . "_" . basename($_FILES['cover']['name']);
        $target_file = $target_dir . $file_name;

        if (move_uploaded_file($_FILES['cover']['tmp_name'], $target_file)) {
            $cover_name = $file_name;
        }
    }

    // Simpan buku ke tabel 'buku'
    $sql = "INSERT INTO buku (judul, penulis, penerbit, tahun_terbit, stok, cover_buku)
            VALUES (?, ?, ?, ?, ?, ?)";
    if ($stmt = $mysqli->prepare($sql)) {
        $stmt->bind_param("ssssss", $judul, $penulis, $penerbit, $tahun_terbit, $stok, $cover_name);

        if ($stmt->execute()) {
            $id_buku = $stmt->insert_id; // ambil id buku yang baru
            $stmt->close();

            // Simpan relasi kategori (jika ada)
            if (!empty($kategori)) {
                $sql_relasi = "INSERT INTO buku_kategori (id_buku, id_kategori) VALUES (?, ?)";
                $stmt_relasi = $mysqli->prepare($sql_relasi);
                foreach ($kategori as $id_kat) {
                    $stmt_relasi->bind_param("ii", $id_buku, $id_kat);
                    $stmt_relasi->execute();
                }
                $stmt_relasi->close();
            }

            $pesan = "Data buku berhasil disimpan.";
        } else {
            $pesan_error = "Gagal menyimpan data buku: " . $mysqli->error;
        }
    }
}
?>

<div class="container-fluid px-4">
    <h1 class="mt-4">Tambah Buku</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Tambah Buku</li>
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
                    <input type="text" name="judul_buku" class="form-control" id="judul_buku" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Pilih Kategori</label><br>
                    <?php
                    $sql_kategori = "SELECT * FROM kategori ORDER BY nama_kategori ASC";
                    $result_kategori = $mysqli->query($sql_kategori);
                    while ($kat = $result_kategori->fetch_assoc()) :
                    ?>
                        <label class="me-3">
                            <input type="checkbox" name="kategori[]" value="<?php echo $kat['id_kategori']; ?>">
                            <?php echo htmlspecialchars($kat['nama_kategori']); ?>
                        </label>
                    <?php endwhile; ?>
                </div>

                <div class="mb-3">
                    <label for="penulis" class="form-label">Penulis</label>
                    <input type="text" name="penulis" class="form-control" id="penulis" required>
                </div>
                <div class="mb-3">
                    <label for="penerbit" class="form-label">Penerbit</label>
                    <input type="text" name="penerbit" class="form-control" id="penerbit" required>
                </div>
                <div class="mb-3">
                    <label for="tahun_terbit" class="form-label">Tahun Terbit</label>
                    <input type="number" name="tahun_terbit" class="form-control" id="tahun_terbit" required>
                </div>
                <div class="mb-3">
                    <label for="stok" class="form-label">Stok</label>
                    <input type="number" name="stok" class="form-control" id="stok" required>
                </div>

                <div class="mb-4">
                    <label for="cover" class="form-label">Upload Cover</label>
                    <input type="file" name="cover" class="form-control" id="cover">
                </div>

                <button type="submit" class="btn btn-primary">Simpan</button>
                <a href="index.php?hal=daftar_buku" class="btn btn-danger">Kembali</a>
            </form>
        </div>
    </div>
</div>

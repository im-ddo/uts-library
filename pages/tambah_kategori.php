<?php
// proteksi agar file tidak dapat diakses langsung
if(!defined('MY_APP')) {
    die('Akses langsung tidak diperbolehkan!');
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // jika ada metode POST jalankan kode ini
    $nama_kategori = $_POST['nama_kategori'];

    // Query
    $sql = "INSERT INTO kategori (nama_kategori) VALUES (?)";
    $stmt = $mysqli->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("s", $nama_kategori);
        if ($stmt->execute()) {
            $pesan = "Data kategori berhasil disimpan";
        } else {
            $pesan_error = "Terjadi kesalahan saat menyimpan data";
        }
        $stmt->close();
    }

    $mysqli->close();
}
?>

<div class="container-fluid px-4">
    <h1 class="mt-4">Kategori</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Tambah Kategori</li>
    </ol>
    
    <div class="card mb-4">
        <div class="card-body">
            <form method="post">
            <div class="mb-3">
                <label for="nama_kategori" class="form-label">Nama Kategori</label>
                <input type="text" name="nama_kategori" class="form-control" id="nama_kategori" required>
            </div>

            <button type="submit" class="btn btn-primary">Simpan</button>
            <a href="index.php?hal=daftar_kategori" class="btn btn-danger">Batal</a>
        </form>  
        </div>
    </div>
</div>

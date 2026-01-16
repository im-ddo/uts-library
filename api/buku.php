<?php

require "../includes/config.php";
// Asumsi: $mysqli (koneksi database) tersedia dari config.php

function response($status, $msg, $data = null) {
    echo json_encode([
        "status" => $status,
        "msg" => $msg,
        "data" => $data
    ]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== "GET") {
    response("error", "Gunakan method GET.");
}

$query = $mysqli->query("
    SELECT id_anggota, nama_lengkap, alamat, foto_profil 
    FROM anggota 
    ORDER BY id_anggota DESC
");

$daftar = [];
while ($row = $query->fetch_assoc()) {
    $daftar[] = [
        "id_anggota"   => $row['id_anggota'],
        "nama_lengkap" => $row['nama_lengkap'],
        "alamat"       => $row['alamat'],
        "foto_profil"  => $row['foto_profil'] 
            ? "http://192.168.1.18/uts_pdcs/uploads/" . $row['foto_profil']
            : null
    ];
}

response("success", "Berhasil mengambil data anggota", $daftar);

?>

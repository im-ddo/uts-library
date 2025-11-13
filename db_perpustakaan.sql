-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 13, 2025 at 04:41 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpustakaan`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int NOT NULL,
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(128) NOT NULL,
  `nama_lengkap` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `email`, `username`, `password`, `nama_lengkap`) VALUES
(1, 'admin@gmail.com', 'dodo', 'dodo25', 'dodo'),
(2, 'admin@gmail.com', 'dodo', '36e0ddc464cb648de56aebfe032ddc7b', 'dodo');

-- --------------------------------------------------------

--
-- Table structure for table `anggota`
--

CREATE TABLE `anggota` (
  `id_anggota` int NOT NULL,
  `nama_lengkap` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(128) NOT NULL,
  `alamat` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `no_telepon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `foto_profil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `anggota`
--

INSERT INTO `anggota` (`id_anggota`, `nama_lengkap`, `email`, `password`, `alamat`, `no_telepon`, `foto_profil`) VALUES
(1, 'Andi', 'andi12@gmail.com', '20b684428b08074479458564e221e2ba', 'JL.Alam Serang', '081255553333', NULL),
(2, 'Andi Sanjaya', 'andi12@gmail.com', '1d69ded7713f92f0f41ddfc0cdbcdb80', 'JL.Alam Serang', '081255553333', '1763048192_Ataraxia Café Logo Design.png'),
(3, 'Andi Sanjaya Winata', 'andi12@gmail.com', '92452785ccbee08615e21e20c5d481e8', 'JL.Alam Serang', '081255553333', '1763048355_fot.png'),
(4, 'Andi Sanjaya Winata', 'andi12@gmail.com', '638e83edca2dd7aa84bf140c80b3545a', 'JL.Alam Serang', '081255553333', '1763048503_fot.png'),
(5, 'Sena', 'senaa2@gmail.com', 'ce7ce9108ae218e4ee612b0b36e3ed1d', 'JL.Alam Serang', '081255553333', '1763048699_fot.png'),
(6, 'Sena Alu', 'senaa2@gmail.com', 'a8c9c13bba986f37048123eb1f405394', 'JL.Alam Serang', '081255553333', '1763048941_fot.png'),
(7, 'Sena Alu', 'senaa2@gmail.com', 'a8c9c13bba986f37048123eb1f405394', 'JL.Alam Serang', '081255553333', '1763048979_fot.png'),
(8, 'Sena Alu', 'senaa2@gmail.com', '$2y$10$dYpDIgT/eWunaAqfq.yuzuMF8gndjF4nW2JfYfZ9s9ck/LDQnEkEu', 'JL.Alam Serang', '081255553333', '1763048995_fot.png'),
(9, 'Sena Alu', 'senaa2@gmail.com', '698d51a19d8a121ce581499d7b701668', 'JL.Alam Serang', '081255553333', '1763049011_fot.png'),
(10, 'Mia', 'mia12@gmail.com', 'fa934557cda97166cb1263f66fb0da76', 'Jl', '08222999928', '1763051398_fot.png');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int NOT NULL,
  `tanggal_booking` date NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_anggota` int NOT NULL,
  `id_buku` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int NOT NULL,
  `judul` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `penulis` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `penerbit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tahun_terbit` varchar(4) NOT NULL,
  `stok` int NOT NULL,
  `cover_buku` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul`, `penulis`, `penerbit`, `tahun_terbit`, `stok`, `cover_buku`) VALUES
(3, 'Musa Membela Batu', 'Mischel', 'Gramedia', '2000', 4, ''),
(4, 'Aku TIdur', 'Nathan', 'Gramedia', '1998', 6, ''),
(5, 'Selalu Giat Aku', 'Nisa', 'Gramedia', '2000', 6, ''),
(6, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, ''),
(7, 'Aku TIdur Terus', 'Nathan', 'Gramedia', '1998', 6, ''),
(8, 'My Loney', 'Serly', 'Gramedia', '1998', 0, ''),
(9, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, '1763025004_WhatsApp Image 2025-11-13 at 00.22.40.jpeg'),
(10, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, '1763025125_WhatsApp Image 2025-11-13 at 00.22.40.jpeg'),
(11, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, '1763025164_WhatsApp Image 2025-11-13 at 15.04.13.jpeg'),
(12, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, '1763025234_Ataraxia Café Logo Design.png'),
(13, 'Selalu Giat Aku Belajar', 'Nisa Ross', 'Gramedia', '2000', 12, NULL),
(14, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, '1763046785_fot.png'),
(15, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, 'uploads/buku/1763047058_fot.png'),
(16, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, 'uploads/buku/1763047074_Ataraxia Café Logo Design.png'),
(17, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, 'uploads/buku/1763047179_Ataraxia Café Logo Design.png'),
(18, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, 'uploads/buku/1763047199_Ataraxia Café Logo Design.png'),
(19, 'Selalu Giat Aku Belajar Aku', 'Nisa Ross', 'Gramedia', '2000', 12, '1763047335_fot.png'),
(20, 'Selalu Giat Aku Belajar Akuu', 'Nisa Ross', 'Gramedia', '2000', 12, '1763047613_fot.png'),
(21, 'Selalu Giat Aku Belajar Akuu', 'Nisa Ross', 'Gramedia', '2000', 12, '1763047859_Ataraxia Café Logo Design.png'),
(22, 'Aku Salah', 'Nisa Ross', 'Gramedia', '2000', 12, '1763048741_Ataraxia Café Logo Design.png'),
(23, 'Aku Salah', 'Nisa Ross', 'Gramedia', '2000', 12, '1763051340_Ataraxia Café Logo Design.png');

-- --------------------------------------------------------

--
-- Table structure for table `buku_kategori`
--

CREATE TABLE `buku_kategori` (
  `id_buku` int NOT NULL,
  `id_kategori` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku_kategori`
--

INSERT INTO `buku_kategori` (`id_buku`, `id_kategori`) VALUES
(11, 15),
(12, 16),
(13, 14),
(13, 15),
(14, 14),
(15, 14),
(16, 16),
(17, 16),
(18, 16),
(19, 16),
(19, 14),
(19, 15),
(20, 14),
(21, 16),
(22, 15),
(23, 16);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int NOT NULL,
  `nama_kategori` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`) VALUES
(14, 'Fiksi'),
(15, 'Non Fiksi'),
(16, 'Edukasi'),
(17, 'Rakyat'),
(18, 'Sejarah');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_anggota` int NOT NULL,
  `id_buku` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `booking_anggota_fk` (`id_anggota`),
  ADD KEY `booking_buku_fk` (`id_buku`);

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `buku_kategori`
--
ALTER TABLE `buku_kategori`
  ADD KEY `buku_kategori_kategori_fk` (`id_kategori`),
  ADD KEY `buku_kategori_buku_fk` (`id_buku`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `peminjaman_anggota_fk` (`id_anggota`),
  ADD KEY `peminjaman_buku_fk` (`id_buku`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `anggota`
--
ALTER TABLE `anggota`
  MODIFY `id_anggota` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_anggota_fk` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `booking_buku_fk` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `buku_kategori`
--
ALTER TABLE `buku_kategori`
  ADD CONSTRAINT `buku_kategori_buku_fk` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `buku_kategori_kategori_fk` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_anggota_fk` FOREIGN KEY (`id_anggota`) REFERENCES `anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `peminjaman_buku_fk` FOREIGN KEY (`id_buku`) REFERENCES `buku` (`id_buku`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 21, 2023 at 02:40 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualanbarang`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kode_barang` varchar(50) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kode_barang`, `nama_barang`, `harga`) VALUES
('b001', 'Lemari', 13000000),
('b002', 'Kulkas', 23000000),
('b003', 'tv', 24000000);

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `INSERTA` AFTER INSERT ON `barang` FOR EACH ROW INSERT INTO detail_penjualan VALUES(NULL,NEW.kode_barang,NULL)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATEB` AFTER UPDATE ON `barang` FOR EACH ROW UPDATE detail_penjualan SET kode_barang = NEW.kode_barang WHERE kode_barang = NEW.kode_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `costumer`
--

CREATE TABLE `costumer` (
  `id_costumer` varchar(50) NOT NULL,
  `nama_costumer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `costumer`
--

INSERT INTO `costumer` (`id_costumer`, `nama_costumer`) VALUES
('e001', 'Ryan'),
('e002', 'Mozes'),
('e003', 'Rara');

--
-- Triggers `costumer`
--
DELIMITER $$
CREATE TRIGGER `INSERT` AFTER INSERT ON `costumer` FOR EACH ROW INSERT INTO penjualan_barang VALUES(null,null,NEW.id_costumer)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATE` AFTER UPDATE ON `costumer` FOR EACH ROW UPDATE penjualan_barang SET id_costumer = NEW.id_costumer WHERE no_jual='j004'
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `no_jual` varchar(50) NOT NULL,
  `kode_barang` varchar(50) NOT NULL,
  `qty_penjualan` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`no_jual`, `kode_barang`, `qty_penjualan`) VALUES
('j001', 'b001', 1),
('j002', 'b001', 1),
('j004', 'b003', NULL);

--
-- Triggers `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `INSERTE` AFTER INSERT ON `detail_penjualan` FOR EACH ROW INSERT INTO penjualan_barang VALUES(NEW.no_jual,null,null)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATEC` AFTER UPDATE ON `detail_penjualan` FOR EACH ROW UPDATE detail_penjualan SET kode_barang = NEW.kode_barang,
no_jual=NEW.no_jual WHERE kode_barang='b003'
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan_barang`
--

CREATE TABLE `penjualan_barang` (
  `no_jual` varchar(50) NOT NULL,
  `tgl_jual` date DEFAULT NULL,
  `id_costumer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penjualan_barang`
--

INSERT INTO `penjualan_barang` (`no_jual`, `tgl_jual`, `id_costumer`) VALUES
('j001', '2022-03-02', 'e001'),
('j002', '2022-12-02', 'e002'),
('j004', NULL, 'e003');

--
-- Triggers `penjualan_barang`
--
DELIMITER $$
CREATE TRIGGER `INSERTb` AFTER INSERT ON `penjualan_barang` FOR EACH ROW INSERT INTO detail_penjualan VALUES(NEW.no_jual,null,null)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `UPDATEA` AFTER UPDATE ON `penjualan_barang` FOR EACH ROW UPDATE detail_penjualan SET no_jual = NEW.no_jual WHERE kode_barang='b003'
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kode_barang`);

--
-- Indexes for table `costumer`
--
ALTER TABLE `costumer`
  ADD PRIMARY KEY (`id_costumer`) USING BTREE;

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`no_jual`,`kode_barang`) USING BTREE,
  ADD KEY `kode_barang` (`kode_barang`,`no_jual`) USING BTREE;

--
-- Indexes for table `penjualan_barang`
--
ALTER TABLE `penjualan_barang`
  ADD PRIMARY KEY (`no_jual`),
  ADD KEY `id_costumer` (`id_costumer`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `detail_penjualan_ibfk_1` FOREIGN KEY (`no_jual`) REFERENCES `penjualan_barang` (`no_jual`),
  ADD CONSTRAINT `detail_penjualan_ibfk_2` FOREIGN KEY (`kode_barang`) REFERENCES `barang` (`kode_barang`);

--
-- Constraints for table `penjualan_barang`
--
ALTER TABLE `penjualan_barang`
  ADD CONSTRAINT `penjualan_barang_ibfk_1` FOREIGN KEY (`id_costumer`) REFERENCES `costumer` (`id_costumer`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

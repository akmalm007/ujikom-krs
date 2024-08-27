-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 27, 2024 at 05:19 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_krs`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_keterangan_baru` (IN `p_npm` INT, IN `p_kode_mk` VARCHAR(255))  BEGIN
    -- Update the 'keterangan' column to 'baru' for the given npm and kode_mk
    UPDATE mata_kuliah
    SET keterangan = 'baru'
    WHERE kode_mk = p_kode_mk
    AND EXISTS (
        SELECT 1
        FROM mahasiswa_matkul mmk
        WHERE mmk.npm = p_npm
        AND mmk.kode_mk = p_kode_mk
    );
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_sks` (`p_npm` INT, `p_semester` INT) RETURNS INT(11) BEGIN
    DECLARE total_sks INT;

    SELECT 
        SUM(mk.sks)
    INTO 
        total_sks
    FROM 
        mahasiswa_matkul mmk
    JOIN 
        mata_kuliah mk ON mmk.kode_mk = mk.kode_mk
    JOIN
        mahasiswa m ON mmk.npm = m.npm
    WHERE 
        mmk.npm = p_npm
        AND m.semester = p_semester;

    RETURN total_sks;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `npm` int(10) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `program_studi` varchar(255) DEFAULT NULL,
  `semester` int(10) DEFAULT NULL,
  `tahun_angkatan` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`npm`, `nama`, `program_studi`, `semester`, `tahun_angkatan`) VALUES
(201600001, 'Jos', 'Red Bull Academy', 9, '2016'),
(202000001, 'Lewsi Hamilton', 'Teknik Informatika', 2, '2020'),
(202100002, 'Perez', 'Teknk Desain Grafis', 2, '2021'),
(202200001, 'Oscar Piastri', 'Renault Driver Academy', 2, '2022'),
(202300001, 'Jane Smith', 'Sistem Informasi', 2, '2023'),
(202400002, 'Reed', 'memasak', 10, '2024'),
(421100001, 'Vettela', 'adsasd', 1231, '4211'),
(2007411050, 'Akmal Maulana', 'Teknik Informatika', 8, '2020'),
(2007411051, 'Gilang Adhi', 'Teknik Informatika', 8, '2020'),
(2007411052, 'Max Verstappen', 'Teknik Informatika', 8, '2020');

--
-- Triggers `mahasiswa`
--
DELIMITER $$
CREATE TRIGGER `generate_npm` BEFORE INSERT ON `mahasiswa` FOR EACH ROW BEGIN
    DECLARE running_number INT;
    DECLARE formatted_npm VARCHAR(15);

    -- Get the highest existing running number for the specified tahun_angkatan
    SELECT COALESCE(MAX(CAST(SUBSTRING(npm, 6, 5) AS UNSIGNED)), 0) + 1
    INTO running_number
    FROM mahasiswa
    WHERE SUBSTRING(npm, 1, 4) = NEW.tahun_angkatan;

    -- Concatenate tahun_angkatan with the new running number, padded to 5 digits
    SET formatted_npm = CONCAT(NEW.tahun_angkatan, LPAD(running_number, 5, '0'));

    -- Set the NEW.npm to the generated formatted_npm
    SET NEW.npm = formatted_npm;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa_matkul`
--

CREATE TABLE `mahasiswa_matkul` (
  `npm` int(11) NOT NULL,
  `kode_mk` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mahasiswa_matkul`
--

INSERT INTO `mahasiswa_matkul` (`npm`, `kode_mk`) VALUES
(2007411050, '1001'),
(2007411050, '1002'),
(2007411050, '1005');

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `kode_mk` varchar(255) NOT NULL,
  `mata_ajar` varchar(255) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mata_kuliah`
--

INSERT INTO `mata_kuliah` (`kode_mk`, `mata_ajar`, `sks`, `keterangan`) VALUES
('1001', 'Metodologi Penelitian', 2, 'baru'),
('1002', 'Kapita Selekta 2', 2, 'baru'),
('1003', 'English for Internasional Communication', 3, NULL),
('1004', 'Kapita Selekta', 3, NULL),
('1005', 'Pendidikan Moral Pancasila', 3, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_mahasiswa_matkul`
-- (See below for the actual view)
--
CREATE TABLE `view_mahasiswa_matkul` (
`npm` int(10)
,`nama_mhsw` varchar(255)
,`kode_mk` varchar(255)
,`mata_ajar` varchar(255)
,`sks` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_mahasiswa_matkul`
--
DROP TABLE IF EXISTS `view_mahasiswa_matkul`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_mahasiswa_matkul`  AS SELECT `m`.`npm` AS `npm`, `m`.`nama` AS `nama_mhsw`, `mk`.`kode_mk` AS `kode_mk`, `mk`.`mata_ajar` AS `mata_ajar`, `mk`.`sks` AS `sks` FROM ((`mahasiswa_matkul` `mmk` join `mahasiswa` `m` on(`mmk`.`npm` = `m`.`npm`)) join `mata_kuliah` `mk` on(`mmk`.`kode_mk` = `mk`.`kode_mk`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`npm`),
  ADD KEY `idx_mahasiswa` (`npm`,`nama`,`program_studi`);

--
-- Indexes for table `mahasiswa_matkul`
--
ALTER TABLE `mahasiswa_matkul`
  ADD PRIMARY KEY (`npm`,`kode_mk`),
  ADD KEY `kode_mk` (`kode_mk`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`kode_mk`),
  ADD KEY `idx_matkul` (`kode_mk`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mahasiswa_matkul`
--
ALTER TABLE `mahasiswa_matkul`
  ADD CONSTRAINT `mahasiswa_matkul_ibfk_1` FOREIGN KEY (`npm`) REFERENCES `mahasiswa` (`npm`),
  ADD CONSTRAINT `mahasiswa_matkul_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `mata_kuliah` (`kode_mk`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

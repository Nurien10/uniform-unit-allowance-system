-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 29, 2026 at 05:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uuuams`
--

-- --------------------------------------------------------

--
-- Table structure for table `allowance_payment`
--

CREATE TABLE `allowance_payment` (
  `id` int(11) NOT NULL,
  `memberName` varchar(100) NOT NULL,
  `month` varchar(2) NOT NULL,
  `year` varchar(4) NOT NULL,
  `status` varchar(20) NOT NULL,
  `programHours` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paymentUrl` text NOT NULL,
  `billCode` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `allowance_payment`
--

INSERT INTO `allowance_payment` (`id`, `memberName`, `month`, `year`, `status`, `programHours`, `amount`, `paymentUrl`, `billCode`, `created_at`) VALUES
(21, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', '07', '2025', 'Paid', 19, 152.00, 'https://dev.toyyibpay.com/6qpor0br', '6qpor0br', '2025-07-01 15:57:03'),
(22, 'NUR SYAMIRA BINTI LAHAKING', '07', '2025', 'Paid', 16, 128.00, 'https://dev.toyyibpay.com/nv4zjgnx', 'nv4zjgnx', '2025-07-01 15:57:21'),
(23, 'AZIZUL HAKIM BIN NORMAN', '07', '2025', 'Paid', 21, 168.00, 'https://dev.toyyibpay.com/mghb5nxc', 'mghb5nxc', '2025-07-02 06:54:19'),
(24, 'NURIEN NABILA BINTI NURASYID', '07', '2025', 'Paid', 14, 112.00, 'https://dev.toyyibpay.com/v0hkcnbo', 'v0hkcnbo', '2025-07-02 07:12:00'),
(25, 'AHMAD ', '07', '2025', 'Pending', 23, 184.00, 'https://dev.toyyibpay.com/3v0jin78', '3v0jin78', '2025-07-07 15:35:06'),
(26, 'AHMAD ', '07', '2025', 'Paid', 23, 184.00, 'https://dev.toyyibpay.com/r5exo73r', 'r5exo73r', '2025-07-07 15:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `programName` varchar(100) NOT NULL,
  `dateTime` varchar(50) NOT NULL,
  `programHours` int(11) NOT NULL,
  `status` varchar(20) NOT NULL,
  `reasonProof` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `attendanceID` int(11) NOT NULL,
  `memberName` varchar(100) NOT NULL,
  `proofStatus` varchar(255) NOT NULL,
  `submissionDateTime` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`programName`, `dateTime`, `programHours`, `status`, `reasonProof`, `message`, `attendanceID`, `memberName`, `proofStatus`, `submissionDateTime`) VALUES
('PHYSICAL TRAINNING ', '2025-07-04T08:00', 3, 'Present', 'No Proof', '', 28, 'AZIZUL HAKIM BIN NORMAN', 'Not Submitted', '2025-07-01T23:45'),
('SOLAT HAJAT PERDANA ', '2025-07-04T19:00', 3, 'Present', 'No Proof', '', 29, 'AZIZUL HAKIM BIN NORMAN', 'Not Submitted', '2025-07-01T23:45'),
('BACAAN YASIN ', '2025-07-05T20:00', 2, 'Absent', 'mc.png', '', 30, 'AZIZUL HAKIM BIN NORMAN', 'Approved', '2025-07-01T23:46'),
('MESYUARAT AGM TAHUNAN ', '2025-07-05T09:00', 6, 'Present', 'No Proof', '', 31, 'AZIZUL HAKIM BIN NORMAN', 'Not Submitted', '2025-07-01T23:47'),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11T09:00', 4, 'Present', 'No Proof', '', 32, 'AZIZUL HAKIM BIN NORMAN', 'Not Submitted', '2025-07-01T23:47'),
('UJIAN KAWAD KAKI ', '2025-07-12T08:00', 5, 'Present', 'No Proof', '', 33, 'AZIZUL HAKIM BIN NORMAN', 'Not Submitted', '2025-07-01T23:48'),
('SOLAT HAJAT PERDANA ', '2025-07-04T19:00', 3, 'Absent', 'mc.png', '', 35, 'NUR SYAMIRA BINTI LAHAKING', 'Approved', '2025-07-01T23:48'),
('BACAAN YASIN ', '2025-07-05T20:00', 2, 'Present', 'No Proof', '', 36, 'NUR SYAMIRA BINTI LAHAKING', 'Not Submitted', '2025-07-01T23:49'),
('MESYUARAT AGM TAHUNAN ', '2025-07-05T09:00', 6, 'Present', 'No Proof', '', 37, 'NUR SYAMIRA BINTI LAHAKING', 'Not Submitted', '2025-07-01T23:49'),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11T09:00', 4, 'Absent', 'mc.png', '', 38, 'NUR SYAMIRA BINTI LAHAKING', 'Approved', '2025-07-01T23:49'),
('UJIAN KAWAD KAKI ', '2025-07-12T08:00', 5, 'Present', 'No Proof', '', 39, 'NUR SYAMIRA BINTI LAHAKING', 'Not Submitted', '2025-07-01T23:49'),
('PHYSICAL TRAINNING ', '2025-07-04T08:00', 3, 'Present', 'No Proof', '', 40, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Not Submitted', '2025-07-01T23:50'),
('SOLAT HAJAT PERDANA ', '2025-07-04T19:00', 3, 'Present', 'No Proof', '', 41, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Not Submitted', '2025-07-01T23:50'),
('BACAAN YASIN ', '2025-07-05T20:00', 2, 'Present', 'No Proof', '', 42, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Not Submitted', '2025-07-01T23:50'),
('MESYUARAT AGM TAHUNAN ', '2025-07-05T09:00', 6, 'Present', 'No Proof', '', 43, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Not Submitted', '2025-07-01T23:50'),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11T09:00', 4, 'Absent', 'mc.png', '', 44, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Approved', '2025-07-01T23:50'),
('UJIAN KAWAD KAKI ', '2025-07-12T08:00', 5, 'Present', 'No Proof', '', 45, 'NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', 'Not Submitted', '2025-07-01T23:51'),
('PHYSICAL TRAINNING ', '2025-07-04T08:00', 3, 'Present', 'No Proof', '', 52, 'NURIEN NABILA BINTI NURASYID', 'Not Submitted', '2025-07-02T14:47'),
('PHYSICAL TRAINNING ', '2025-07-04T08:00', 3, 'Present', 'No Proof', '', 53, 'NUR SYAMIRA BINTI LAHAKING', 'Not Submitted', '2025-07-02T14:49'),
('SOLAT HAJAT PERDANA ', '2025-07-04T19:00', 3, 'Present', 'No Proof', '', 54, 'NURIEN NABILA BINTI NURASYID', 'Not Submitted', '2025-07-02T14:50'),
('BACAAN YASIN ', '2025-07-05T20:00', 2, 'Present', 'No Proof', '', 55, 'NURIEN NABILA BINTI NURASYID', 'Not Submitted', '2025-07-02T14:58'),
('MESYUARAT AGM TAHUNAN ', '2025-07-05T09:00', 6, 'Present', 'No Proof', '', 56, 'NURIEN NABILA BINTI NURASYID', 'Not Submitted', '2025-07-02T14:58'),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11T09:00', 4, 'Absent', 'mc.png', '', 57, 'NURIEN NABILA BINTI NURASYID', 'Approved', '2025-07-02T15:08'),
('PHYSICAL TRAINNING ', '2025-07-04T08:00', 3, 'Present', 'No Proof', '', 58, 'AHMAD ', 'Not Submitted', '2025-07-07T23:32'),
('BACAAN YASIN ', '2025-07-05T20:00', 2, 'Present', 'No Proof', '', 59, 'AHMAD ', 'Not Submitted', '2025-07-07T23:32'),
('SOLAT HAJAT PERDANA ', '2025-07-04T19:00', 3, 'Present', 'No Proof', '', 60, 'AHMAD ', 'Not Submitted', '2025-07-07T23:33'),
('MESYUARAT AGM TAHUNAN ', '2025-07-05T09:00', 6, 'Present', 'No Proof', '', 61, 'AHMAD ', 'Not Submitted', '2025-07-07T23:33'),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11T09:00', 4, 'Present', 'No Proof', '', 62, 'AHMAD ', 'Not Submitted', '2025-07-07T23:33'),
('UJIAN KAWAD KAKI ', '2025-07-12T08:00', 5, 'Present', 'No Proof', '', 63, 'AHMAD ', 'Not Submitted', '2025-07-07T23:33');

-- --------------------------------------------------------

--
-- Table structure for table `external_officer`
--

CREATE TABLE `external_officer` (
  `Name` varchar(127) NOT NULL,
  `Phone_Number` varchar(127) NOT NULL,
  `Date_of_Birth` varchar(127) NOT NULL,
  `IC` varchar(127) NOT NULL,
  `Gender` varchar(127) NOT NULL,
  `Address` varchar(127) NOT NULL,
  `Email` varchar(127) NOT NULL,
  `Password` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `external_officer`
--

INSERT INTO `external_officer` (`Name`, `Phone_Number`, `Date_of_Birth`, `IC`, `Gender`, `Address`, `Email`, `Password`) VALUES
('AHMAD FIRDAUS BIN FAISAL', '011-1122334', '1979-07-05', '790705-11-2345', 'Male', 'SHAH ALAM, SELANGOR', 'ahmadfirdaus79@gmail.com', '59679d1d68497f1d97f445e90e83d536b67a9a2b4752049ee4e17e3d0bed1100'),
('RASHID BIN YOSUFF', '019-2571888', '1974-01-13', '741301-10-6543', 'Male', 'KAJANG,SELANGOR', 'rashidsoff13@gmail.com', '7595e270692b9f836018af299b97c0596968a7d254cb22295429bae9957558c1');

-- --------------------------------------------------------

--
-- Table structure for table `highcouncil`
--

CREATE TABLE `highcouncil` (
  `Password` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `high_council`
--

CREATE TABLE `high_council` (
  `Name` varchar(127) NOT NULL,
  `Uniform` enum('SUKSIS','LAUT','DARAT') NOT NULL DEFAULT 'SUKSIS',
  `Squad` varchar(127) NOT NULL,
  `Position` varchar(127) NOT NULL,
  `Email` varchar(127) NOT NULL,
  `Password` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `high_council`
--

INSERT INTO `high_council` (`Name`, `Uniform`, `Squad`, `Position`, `Email`, `Password`) VALUES
('AINA SOFEA BINTI SAIFUL', 'SUKSIS', 'SQ17', 'President', 'aina.sofea@gmail.com', '7595e270692b9f836018af299b97c0596968a7d254cb22295429bae9957558c1'),
('ALIANI BINTI AZMI', 'SUKSIS', 'SQ16', 'Secretary', 'alianiazmi@gmail.com', '40fee0b89c3bffd5de7bce2f04d8230f03b44f3f188716901c4ce3974792ad55');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `Name` varchar(127) NOT NULL,
  `Phone Number` varchar(127) NOT NULL,
  `Date of Birth` varchar(127) NOT NULL,
  `IC` varchar(127) NOT NULL,
  `Gender` varchar(127) NOT NULL,
  `Uniform` enum('SUKSIS','LAUT','DARAT') NOT NULL DEFAULT 'SUKSIS',
  `Squad` varchar(127) NOT NULL,
  `Address` text NOT NULL,
  `Bank Account` varchar(127) NOT NULL,
  `Email` varchar(127) NOT NULL,
  `Password` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`Name`, `Phone Number`, `Date of Birth`, `IC`, `Gender`, `Uniform`, `Squad`, `Address`, `Bank Account`, `Email`, `Password`) VALUES
('aa', '011-6785432', '2004-03-15', '040315-10-1976', 'Male', 'SUKSIS', 'SQ16', 'KAMPUNG SEKARANG IGAN', '7890654321', 'aa@gmail.com', 'd829ac600f84b41ae408f10154e8bfa41a319dda82256d780bcb5a9b52dd4d8f'),
('AHMAD ', '013-3689204', '2003-11-13', '031113-10-0043', 'Male', 'SUKSIS', 'SQ16', 'SELANGOR', '7906598424', 'dznov2003@gmail.com', '92a21be04ee3f6c45910aae731f086f2f672473ecbd8a2b54eaa3bf8d777227a'),
('ANG LEE LING', '014-6784324', '2002-03-24', '020324-13-0986', 'Female', 'SUKSIS', 'SQ16', 'KUCHING, SARAWAK', '7654356789', 'anglee23@gmail.com', '108426ba0823eee5a9ebd4d1f2e494e8462cb610b7f3d4c2fa79d3ef1885056a'),
('AZIZUL HAKIM BIN NORMAN', '011-16066068', '2002-12-29', '021229-13-1029', 'Male', 'SUKSIS', 'SQ16', 'KAMPUNG SEKARANG IGAN', '7071015432', 'hakimazizul158@gmail.com', '6bda489fb505702306ac20d264e9773981782364823a59df42f655b392825126'),
('MUHAMMAD FARIS HAZIQ BIN HAKIM', '019-2644531', '2002-07-12', '020712-14-2987', 'Male', 'SUKSIS', 'SQ16', 'KUDAT, SABAH', '7864321793', 'farishaziq12@gmail.com', 'fdd92eb0eb9a0898f37cc056c7d5066a7f5b256b9935a5c1c0526f355922e3c3'),
('NUR AIN BINTI AIDIL', '017-8760976', '2003-03-10', '030310-10-1654', 'Female', 'SUKSIS', 'SQ16', 'RAWANG, SELANGOR', '7985469321', 'nurulain10@gmail.com', '2b88e3e5bfa44859ec6fac47a580d9336dd49e4afb70c1875924b32631260c0a'),
('NUR AQILAH BINTI MOHD ISKANDAR SHAHRIL', '016-4032063', '2003-06-20', '030620-13-0648', 'Female', 'SUKSIS', 'SQ17', 'KUCHING, SARAWAK', '7643180742', 'nraqlh14@gmail.com', 'b6e2eb12ba0fc1f45a6ac0e75c4a2825863d2566a818c17025ed95b966a3e100'),
('NUR SYAMIRA BINTI LAHAKING', '0128189576', '2002-10-02', '021002-12-0897', 'Female', 'SUKSIS', 'SQ16', 'KUNDANSANG SABAH', '7086075713', 'nursyamira02@gmail.com', 'c93cf42f50a339c0735820d66af09399c699df4ab9637ee7f375b23d73f2a623'),
('NURIEN NABILA BINTI NURASYID', '011-61040799', '2003-06-10', '030610-10-1974', 'Female', 'SUKSIS', 'SQ16', 'BANDAR TASIK PUTERI,RAWANG', '7076036705', 'nurienbella03@gmail.com', '7595e270692b9f836018af299b97c0596968a7d254cb22295429bae9957558c1');

-- --------------------------------------------------------

--
-- Table structure for table `programhigh_council`
--

CREATE TABLE `programhigh_council` (
  `program_name` varchar(255) NOT NULL,
  `date_time` datetime NOT NULL,
  `venue` varchar(255) NOT NULL,
  `trainer` varchar(255) NOT NULL,
  `program_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programhigh_council`
--

INSERT INTO `programhigh_council` (`program_name`, `date_time`, `venue`, `trainer`, `program_hours`) VALUES
('BACAAN YASIN ', '2025-07-05 20:00:00', 'PISM UMT', 'AMIRUL FAIZ', 2),
('MAJLIS ANGKAT SUMPAH ', '2025-07-11 09:00:00', 'AUDITORIUM KOMPLEKS KULIAH ', 'AMIRUL FAIZ', 4),
('MESYUARAT AGM TAHUNAN ', '2025-07-05 09:00:00', 'DP 1 KOMPLEKS KULIAH ', 'AMIRUL FAIZ', 6),
('PHYSICAL TRAINNING ', '2025-07-04 08:00:00', 'KOMPLEKS KULIAH UMT', 'AMIRUL FAIZ', 3),
('PROGRAM SUKMO', '2025-02-20 07:30:00', 'TAPAK CONVO UMT', 'AMIRUL FAIZ', 0),
('SOLAT HAJAT PERDANA ', '2025-07-04 19:00:00', 'PISM UMT ', 'AMIRUL FAIZ', 3),
('UJIAN KAWAD KAKI ', '2025-07-12 08:00:00', 'PGA', 'AMIRUL FAIZ', 5);

-- --------------------------------------------------------

--
-- Table structure for table `trainers`
--

CREATE TABLE `trainers` (
  `Name` varchar(127) NOT NULL,
  `Phone Number` varchar(127) NOT NULL,
  `Date of Birth` varchar(127) NOT NULL,
  `IC` varchar(127) NOT NULL,
  `Gender` varchar(127) NOT NULL,
  `Address` varchar(127) NOT NULL,
  `Email` varchar(127) NOT NULL,
  `Password` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trainers`
--

INSERT INTO `trainers` (`Name`, `Phone Number`, `Date of Birth`, `IC`, `Gender`, `Address`, `Email`, `Password`) VALUES
('AMIRUL FAIZ BIN RASHIDD', '012-3456789', '1985-03-15', '850315-14-5678', 'Male', 'KUDAT,SABAH', 'amirulfaiz85@gmail.com', '7595e270692b9f836018af299b97c0596968a7d254cb22295429bae9957558c1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allowance_payment`
--
ALTER TABLE `allowance_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendanceID`);

--
-- Indexes for table `external_officer`
--
ALTER TABLE `external_officer`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `high_council`
--
ALTER TABLE `high_council`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `programhigh_council`
--
ALTER TABLE `programhigh_council`
  ADD PRIMARY KEY (`program_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allowance_payment`
--
ALTER TABLE `allowance_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendanceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

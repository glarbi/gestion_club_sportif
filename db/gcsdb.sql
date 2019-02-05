-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2019 at 10:17 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gcsdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `assurance`
--

CREATE TABLE `assurance` (
  `ID` int(11) NOT NULL,
  `debut` date DEFAULT NULL,
  `fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assurance`
--

INSERT INTO `assurance` (`ID`, `debut`, `fin`) VALUES
(1, '2018-10-01', '2019-07-01'),
(11, '2018-10-01', '2019-07-01'),
(12, '2018-10-01', '2019-07-01'),
(13, '2018-10-01', '2019-07-01');

-- --------------------------------------------------------

--
-- Table structure for table `athlete`
--

CREATE TABLE `athlete` (
  `ID` int(11) NOT NULL,
  `NOM` varchar(30) NOT NULL,
  `PRENOM` varchar(30) NOT NULL,
  `DATE_NAIS` date DEFAULT NULL,
  `LIEU_NAIS` varchar(30) NOT NULL,
  `PRENOM_PERE` varchar(30) NOT NULL,
  `PROFESSION_PERE` varchar(30) NOT NULL,
  `NOM_MERE` varchar(30) NOT NULL,
  `PRENOM_MERE` varchar(30) NOT NULL,
  `PROFESSION_MERE` varchar(30) NOT NULL,
  `ADRESSE` varchar(1024) NOT NULL,
  `NUM_TEL` varchar(30) NOT NULL,
  `DATE_INSCRIPTION` date DEFAULT NULL,
  `IMG_PATH` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `athlete`
--

INSERT INTO `athlete` (`ID`, `NOM`, `PRENOM`, `DATE_NAIS`, `LIEU_NAIS`, `PRENOM_PERE`, `PROFESSION_PERE`, `NOM_MERE`, `PRENOM_MERE`, `PROFESSION_MERE`, `ADRESSE`, `NUM_TEL`, `DATE_INSCRIPTION`, `IMG_PATH`) VALUES
(11, 'Guezouli', 'Mohamed', '2008-03-24', 'France', 'Larbi', 'Enseignant', 'Sidi Atmane', 'Faiza', 'N?ant', 'Batna', '0560240308', '2018-10-01', NULL),
(12, 'Chenouf', 'Abdallah', '2008-03-24', 'Batna', 'Hocine', 'Commerant', '_', '_', '_', 'Batna', '_', '2018-10-01', NULL),
(13, 'Techir', 'Mohamed Youcef', '2011-04-10', 'Batna', 'Hassane', 'Mdecin', 'Boughrara', 'Ahlem', 'Nant', '8, bat 7, cit 729 lgts, Parc  forage, Batna', '0772481810', '2019-02-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `entraineur`
--

CREATE TABLE `entraineur` (
  `ID` int(11) NOT NULL,
  `NOM` varchar(30) NOT NULL,
  `PRENOM` varchar(30) NOT NULL,
  `DATE_NAIS` date DEFAULT NULL,
  `LIEU_NAIS` varchar(30) NOT NULL,
  `ADRESSE` varchar(1024) NOT NULL,
  `NUM_TEL` varchar(30) NOT NULL,
  `DATE_INSCRIPTION` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entraineur`
--

INSERT INTO `entraineur` (`ID`, `NOM`, `PRENOM`, `DATE_NAIS`, `LIEU_NAIS`, `ADRESSE`, `NUM_TEL`, `DATE_INSCRIPTION`) VALUES
(1, 'Maalem', 'Abdelmalek', '1958-02-20', 'Batna', 'Parc a Forage', '0776314514/0672444003', '2018-10-01');

-- --------------------------------------------------------

--
-- Table structure for table `paiement`
--

CREATE TABLE `paiement` (
  `ID` int(11) NOT NULL,
  `MOIS` date NOT NULL,
  `MONTANT` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paiement`
--

INSERT INTO `paiement` (`ID`, `MOIS`, `MONTANT`) VALUES
(11, '2018-10-01', '0.00'),
(11, '2018-11-01', '0.00'),
(11, '2018-12-01', '0.00'),
(11, '2019-01-01', '0.00'),
(11, '2019-02-01', '0.00'),
(11, '2019-03-01', '0.00'),
(11, '2019-04-01', '0.00'),
(11, '2019-05-01', '0.00'),
(11, '2019-06-01', '0.00'),
(11, '2019-07-01', '0.00'),
(12, '2018-10-01', '0.00'),
(12, '2018-11-01', '0.00'),
(12, '2018-12-01', '0.00'),
(12, '2019-01-01', '0.00'),
(12, '2019-02-01', '0.00'),
(12, '2019-03-01', '0.00'),
(12, '2019-04-01', '0.00'),
(12, '2019-05-01', '0.00'),
(12, '2019-06-01', '0.00'),
(12, '2019-07-01', '0.00'),
(13, '2018-10-01', '0.00'),
(13, '2018-11-01', '0.00'),
(13, '2018-12-01', '0.00'),
(13, '2019-01-01', '0.00'),
(13, '2019-02-01', '5000.00'),
(13, '2019-03-01', '5000.00'),
(13, '2019-04-01', '-1.00'),
(13, '2019-05-01', '-1.00'),
(13, '2019-06-01', '-1.00'),
(13, '2019-07-01', '-1.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assurance`
--
ALTER TABLE `assurance`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `athlete`
--
ALTER TABLE `athlete`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `entraineur`
--
ALTER TABLE `entraineur`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `paiement`
--
ALTER TABLE `paiement`
  ADD PRIMARY KEY (`ID`,`MOIS`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

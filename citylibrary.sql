-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 11, 2020 at 02:37 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `citylibrary`
--
CREATE DATABASE IF NOT EXISTS `citylibrary` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `citylibrary`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `Id` varchar(64) NOT NULL,
  `Password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Id`, `Password`) VALUES
('master', 'master123');

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `PId` int(64) UNSIGNED NOT NULL,
  `BookId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`PId`, `BookId`) VALUES
(1, 2),
(3, 2),
(5, 3),
(8, 1),
(11, 10);

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `BookId` int(10) UNSIGNED NOT NULL,
  `ISBN` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`BookId`, `ISBN`) VALUES
(1, '9781234567897'),
(2, '9781234567879'),
(3, '9781234563279');

-- --------------------------------------------------------

--
-- Table structure for table `borrows`
--

DROP TABLE IF EXISTS `borrows`;
CREATE TABLE `borrows` (
  `BorNumber` int(64) UNSIGNED NOT NULL,
  `DocId` int(64) UNSIGNED NOT NULL,
  `CopyNo` int(64) UNSIGNED NOT NULL,
  `BId` int(64) UNSIGNED NOT NULL,
  `ReaderId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `borrows`
--

INSERT INTO `borrows` (`BorNumber`, `DocId`, `CopyNo`, `BId`, `ReaderId`) VALUES
(5, 2, 1, 1, 3);

--
-- Triggers `borrows`
--
DROP TRIGGER IF EXISTS `NoOfCopiesBorrows_R`;
DELIMITER $$
CREATE TRIGGER `NoOfCopiesBorrows_R` BEFORE INSERT ON `borrows` FOR EACH ROW UPDATE Copy SET NoOfCopies = NoOfCopies - 1
WHERE DocId = NEW.DocId
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `NoOfCopiesReturn_R`;
DELIMITER $$
CREATE TRIGGER `NoOfCopiesReturn_R` AFTER DELETE ON `borrows` FOR EACH ROW UPDATE Copy SET NoOfCopies = NoOfCopies + 1
WHERE DocId = OLD.DocId
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bor_transaction`
--

DROP TABLE IF EXISTS `bor_transaction`;
CREATE TABLE `bor_transaction` (
  `BorNumber` int(64) UNSIGNED NOT NULL,
  `BorDateTime` datetime DEFAULT NULL,
  `RetDateTime` datetime DEFAULT NULL,
  `Fine` int(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bor_transaction`
--

INSERT INTO `bor_transaction` (`BorNumber`, `BorDateTime`, `RetDateTime`, `Fine`) VALUES
(1, '2020-12-11 08:13:23', '2020-12-31 08:13:23', 0),
(2, '2020-12-11 08:14:02', '2020-12-31 08:14:02', 0),
(3, '2020-12-11 08:14:02', '2020-12-31 08:14:02', 0),
(4, '2020-12-11 08:14:02', '2020-12-31 08:14:02', 0),
(5, '2020-12-11 08:34:23', '2020-12-31 08:34:23', 0);

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `BId` int(64) UNSIGNED NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Location` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`BId`, `Name`, `Location`) VALUES
(1, 'LibraryA', 'Vailsberg'),
(2, 'LibraryB', 'Clinton'),
(3, 'LibraryC', 'Van Buren');

-- --------------------------------------------------------

--
-- Table structure for table `copy`
--

DROP TABLE IF EXISTS `copy`;
CREATE TABLE `copy` (
  `DocId` int(64) UNSIGNED NOT NULL,
  `CopyNo` int(64) UNSIGNED NOT NULL,
  `BId` int(64) UNSIGNED NOT NULL,
  `Position` varchar(6) NOT NULL,
  `NoOFCopies` int(6) DEFAULT 0
) ;

--
-- Dumping data for table `copy`
--

INSERT INTO `copy` (`DocId`, `CopyNo`, `BId`, `Position`, `NoOFCopies`) VALUES
(2, 1, 1, '001C10', 0),
(3, 1, 1, '015Z23', 2),
(3, 2, 3, '012Z05', 2),
(4, 1, 3, '022Q03', 1),
(5, 2, 2, '011C01', 2),
(5, 3, 2, '003M09', 2),
(6, 1, 1, '006J12', 1),
(7, 2, 1, '007J23', 1),
(8, 1, 3, '008J25', 2),
(8, 4, 1, 'AB1Q21', 2),
(9, 2, 3, '008J26', 2),
(9, 5, 1, 'AB1Q21', 2),
(10, 1, 1, '002B05', 2),
(10, 2, 2, '012A25', 2),
(11, 3, 3, '008J01', 1),
(12, 1, 2, '010J03', 0),
(14, 6, 1, 'AB1Q21', 1),
(15, 7, 2, 'AB1Q22', 0),
(16, 8, 3, 'AB2811', 0),
(17, 9, 1, 'AB1Q20', 0);

-- --------------------------------------------------------

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
CREATE TABLE `document` (
  `DocId` int(64) UNSIGNED NOT NULL,
  `Title` varchar(100) NOT NULL,
  `PDate` date NOT NULL,
  `PublisherId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `document`
--

INSERT INTO `document` (`DocId`, `Title`, `PDate`, `PublisherId`) VALUES
(1, 'BookB', '1997-10-11', 2),
(2, 'BookC', '2001-06-12', 1),
(3, 'BookD', '2005-04-01', 1),
(4, 'JournalA', '2004-12-15', 3),
(5, 'JournalA', '1969-04-12', 4),
(6, 'JournalB', '2002-08-05', 5),
(7, 'JournalC', '1996-12-06', 3),
(8, 'JournalD', '2019-12-01', 6),
(9, 'JournalD', '2019-06-01', 6),
(10, 'BookE', '2018-01-11', 2),
(11, 'Conference1', '2018-01-11', 7),
(12, 'Conference2', '2020-08-11', 7),
(13, 'Conference3', '2020-09-11', 7),
(14, 'Harry Potter', '2011-01-13', 10),
(15, 'Friends', '2020-12-01', 11),
(16, 'DBMS DESIGN', '2020-07-18', 12),
(17, 'DBMS DESIGN 2', '2019-06-04', 13);

-- --------------------------------------------------------

--
-- Table structure for table `gedit`
--

DROP TABLE IF EXISTS `gedit`;
CREATE TABLE `gedit` (
  `DocId` int(64) UNSIGNED NOT NULL,
  `IssueNo` int(10) UNSIGNED NOT NULL,
  `GuestEditorId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `gedit`
--

INSERT INTO `gedit` (`DocId`, `IssueNo`, `GuestEditorId`) VALUES
(2, 2, 2),
(3, 2, 7),
(4, 8, 12),
(5, 4, 9);

-- --------------------------------------------------------

--
-- Table structure for table `journal_issue`
--

DROP TABLE IF EXISTS `journal_issue`;
CREATE TABLE `journal_issue` (
  `DocId` int(64) UNSIGNED NOT NULL,
  `IssueNo` int(10) UNSIGNED NOT NULL,
  `Scope` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `journal_issue`
--

INSERT INTO `journal_issue` (`DocId`, `IssueNo`, `Scope`) VALUES
(2, 2, 'Slice of Life'),
(2, 4, 'Science'),
(3, 3, 'Economics'),
(4, 8, 'Business'),
(5, 7, 'Sports'),
(6, 9, 'Music');

-- --------------------------------------------------------

--
-- Table structure for table `journal_volumes`
--

DROP TABLE IF EXISTS `journal_volumes`;
CREATE TABLE `journal_volumes` (
  `DocId` int(64) UNSIGNED NOT NULL,
  `VolumeNo` int(10) UNSIGNED NOT NULL,
  `ChiefEditorId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `journal_volumes`
--

INSERT INTO `journal_volumes` (`DocId`, `VolumeNo`, `ChiefEditorId`) VALUES
(2, 1, 6),
(3, 2, 6),
(4, 1, 7),
(5, 3, 16),
(6, 4, 15),
(7, 5, 15);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `PId` int(64) UNSIGNED NOT NULL,
  `PName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`PId`, `PName`) VALUES
(1, 'Author1'),
(2, 'GEditor1'),
(3, 'Author2'),
(4, 'Chair1'),
(5, 'Author3'),
(6, 'Editor1'),
(7, 'Editor2'),
(8, 'Author4'),
(9, 'Chair2'),
(10, 'GEditor2'),
(11, 'Author5'),
(12, 'GEditor3'),
(13, 'GEditor4'),
(14, 'Chair3'),
(15, 'Editor3'),
(16, 'Editor4');

-- --------------------------------------------------------

--
-- Table structure for table `proceedings`
--

DROP TABLE IF EXISTS `proceedings`;
CREATE TABLE `proceedings` (
  `ProceedingsId` int(64) UNSIGNED NOT NULL,
  `Date` date NOT NULL,
  `Location` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `proceedings`
--

INSERT INTO `proceedings` (`ProceedingsId`, `Date`, `Location`) VALUES
(11, '2003-10-19', 'NEWARK'),
(12, '2012-12-10', 'NEW YORK CITY'),
(13, '2016-06-13', 'JERSEY CITY');

-- --------------------------------------------------------

--
-- Table structure for table `proceedings_chairs`
--

DROP TABLE IF EXISTS `proceedings_chairs`;
CREATE TABLE `proceedings_chairs` (
  `ChairId` int(64) UNSIGNED NOT NULL,
  `ProceedingsId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `proceedings_chairs`
--

INSERT INTO `proceedings_chairs` (`ChairId`, `ProceedingsId`) VALUES
(4, 11),
(8, 12),
(1, 13);

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
CREATE TABLE `publisher` (
  `PublisherId` int(10) UNSIGNED NOT NULL,
  `PubName` varchar(100) NOT NULL,
  `Address` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`PublisherId`, `PubName`, `Address`) VALUES
(1, 'BOOKPUB1', '141KevinSt,Newark'),
(2, 'BOOKPUB2', '33JumperSt,Harrison'),
(3, 'JOURNPUB1', '44Mlk Blvd,Newark'),
(4, 'JOURNPUB2', '5WashintonSt,Newark'),
(5, 'JOURNPUB3', '50HayesSt,Union'),
(6, 'JOURNPUB4', '15PrinceSt,Elizbeth'),
(7, 'CONFERPUB1', '1HanfordSt,Dayton'),
(8, 'JK Rowling', 'Indianapolis, USA'),
(9, 'JK Rowling', 'Indianapolis, USA'),
(10, 'JK Rowling', 'Indianapolis, USA'),
(11, 'JK Rowling', 'Lorenze high tow'),
(12, 'Elmaris, Navathe', 'Pearson'),
(13, 'Elmaris, Navathe ', 'kaleirst');

-- --------------------------------------------------------

--
-- Table structure for table `reader`
--

DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader` (
  `ReaderId` int(10) UNSIGNED NOT NULL,
  `Type` varchar(20) DEFAULT NULL,
  `ReaderName` varchar(50) DEFAULT NULL,
  `PhoneNo` varchar(16) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reader`
--

INSERT INTO `reader` (`ReaderId`, `Type`, `ReaderName`, `PhoneNo`, `Address`) VALUES
(1, 'STUDENT', 'READER#1', '8625764763', '141SummitSt,Newark'),
(2, 'STUDENT', 'READER#2', '6107036642', '121Harissonave.,Harrison'),
(3, 'STAFF', 'READER#3', '2014679390', '234SpringfieldAve,Irington'),
(4, 'SENIOR CITIZEN', 'READER#4', '2019896893', '2OaklandSt.Irington'),
(5, 'STAFF', 'READER#5', '8622376448', '35NClintonSt,East Orange'),
(6, 'STUDENT', 'READER#6', '6096800093', '6MapleSt,Kearny'),
(7, 'reader', 'Rahul', '9664102923', 'NJIT, UNIVERSITY'),
(8, 'reader', 'Rahul', '9664102923', 'NJIT, UNIVERSITY'),
(9, 'student', 'Aarjavi', '3145829321', 'NJIT Newark'),
(10, 'senior', 'Prem', '3145829323', 'DBMS palace'),
(11, 'senior', 'Prerana', '3145872177', 'next to DBMS palace '),
(12, 'staff', 'Pranavi', '9664102922', 'Secaucus, NJ');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation` (
  `ResNumber` int(64) UNSIGNED NOT NULL,
  `ResDateTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`ResNumber`, `ResDateTime`) VALUES
(1, '2020-12-11 08:34:59');

-- --------------------------------------------------------

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
CREATE TABLE `reserves` (
  `ReaderId` int(64) UNSIGNED NOT NULL,
  `ResNumber` int(64) UNSIGNED NOT NULL,
  `DocId` int(64) UNSIGNED NOT NULL,
  `CopyNo` int(64) UNSIGNED NOT NULL,
  `BId` int(64) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reserves`
--

INSERT INTO `reserves` (`ReaderId`, `ResNumber`, `DocId`, `CopyNo`, `BId`) VALUES
(3, 1, 12, 1, 2);

--
-- Triggers `reserves`
--
DROP TRIGGER IF EXISTS `NoOfCopiesReserves_R`;
DELIMITER $$
CREATE TRIGGER `NoOfCopiesReserves_R` BEFORE INSERT ON `reserves` FOR EACH ROW UPDATE Copy SET NoOfCopies = NoOfCopies - 1
WHERE DocId = NEW.DocId
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `NoOfCopiesReturnReserve_R`;
DELIMITER $$
CREATE TRIGGER `NoOfCopiesReturnReserve_R` AFTER DELETE ON `reserves` FOR EACH ROW UPDATE Copy SET NoOfCopies = NoOfCopies + 1
WHERE DocId = OLD.DocId
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`PId`,`BookId`),
  ADD KEY `BookId` (`BookId`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BookId`);

--
-- Indexes for table `borrows`
--
ALTER TABLE `borrows`
  ADD PRIMARY KEY (`DocId`,`CopyNo`,`BId`,`BorNumber`,`ReaderId`),
  ADD KEY `BorNumber` (`BorNumber`),
  ADD KEY `ReaderId` (`ReaderId`);

--
-- Indexes for table `bor_transaction`
--
ALTER TABLE `bor_transaction`
  ADD PRIMARY KEY (`BorNumber`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`BId`);

--
-- Indexes for table `copy`
--
ALTER TABLE `copy`
  ADD PRIMARY KEY (`DocId`,`CopyNo`,`BId`),
  ADD KEY `BId` (`BId`);

--
-- Indexes for table `document`
--
ALTER TABLE `document`
  ADD PRIMARY KEY (`DocId`),
  ADD KEY `document_ibfk_1` (`PublisherId`);

--
-- Indexes for table `gedit`
--
ALTER TABLE `gedit`
  ADD PRIMARY KEY (`DocId`,`IssueNo`,`GuestEditorId`),
  ADD KEY `IssueNo` (`IssueNo`),
  ADD KEY `GuestEditorId` (`GuestEditorId`);

--
-- Indexes for table `journal_issue`
--
ALTER TABLE `journal_issue`
  ADD PRIMARY KEY (`DocId`,`IssueNo`),
  ADD UNIQUE KEY `IssueNo` (`IssueNo`);

--
-- Indexes for table `journal_volumes`
--
ALTER TABLE `journal_volumes`
  ADD PRIMARY KEY (`DocId`),
  ADD KEY `ChiefEditorId` (`ChiefEditorId`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`PId`);

--
-- Indexes for table `proceedings`
--
ALTER TABLE `proceedings`
  ADD PRIMARY KEY (`ProceedingsId`);

--
-- Indexes for table `proceedings_chairs`
--
ALTER TABLE `proceedings_chairs`
  ADD PRIMARY KEY (`ProceedingsId`,`ChairId`),
  ADD KEY `ChairId` (`ChairId`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`PublisherId`);

--
-- Indexes for table `reader`
--
ALTER TABLE `reader`
  ADD PRIMARY KEY (`ReaderId`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`ResNumber`);

--
-- Indexes for table `reserves`
--
ALTER TABLE `reserves`
  ADD PRIMARY KEY (`DocId`,`CopyNo`,`BId`,`ResNumber`,`ReaderId`),
  ADD KEY `ResNumber` (`ResNumber`),
  ADD KEY `ReaderId` (`ReaderId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bor_transaction`
--
ALTER TABLE `bor_transaction`
  MODIFY `BorNumber` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `BId` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `document`
--
ALTER TABLE `document`
  MODIFY `DocId` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `PId` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `PublisherId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reader`
--
ALTER TABLE `reader`
  MODIFY `ReaderId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `ResNumber` int(64) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authors`
--
ALTER TABLE `authors`
  ADD CONSTRAINT `authors_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `person` (`PId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`BookId`) REFERENCES `document` (`DocId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `borrows`
--
ALTER TABLE `borrows`
  ADD CONSTRAINT `borrows_ibfk_1` FOREIGN KEY (`DocId`,`CopyNo`,`BId`) REFERENCES `copy` (`DocId`, `CopyNo`, `BId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `borrows_ibfk_2` FOREIGN KEY (`BorNumber`) REFERENCES `bor_transaction` (`BorNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `borrows_ibfk_3` FOREIGN KEY (`ReaderId`) REFERENCES `reader` (`ReaderId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `copy`
--
ALTER TABLE `copy`
  ADD CONSTRAINT `copy_ibfk_2` FOREIGN KEY (`BId`) REFERENCES `branch` (`BId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `document`
--
ALTER TABLE `document`
  ADD CONSTRAINT `document_ibfk_1` FOREIGN KEY (`PublisherId`) REFERENCES `publisher` (`PublisherId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gedit`
--
ALTER TABLE `gedit`
  ADD CONSTRAINT `gedit_ibfk_1` FOREIGN KEY (`DocId`) REFERENCES `document` (`DocId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gedit_ibfk_2` FOREIGN KEY (`IssueNo`) REFERENCES `journal_issue` (`IssueNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `gedit_ibfk_3` FOREIGN KEY (`GuestEditorId`) REFERENCES `person` (`PId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `journal_issue`
--
ALTER TABLE `journal_issue`
  ADD CONSTRAINT `journal_issue_ibfk_1` FOREIGN KEY (`DocId`) REFERENCES `journal_volumes` (`DocId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `journal_issue_ibfk_2` FOREIGN KEY (`DocId`) REFERENCES `document` (`DocId`),
  ADD CONSTRAINT `journal_issue_ibfk_3` FOREIGN KEY (`DocId`) REFERENCES `document` (`DocId`);

--
-- Constraints for table `journal_volumes`
--
ALTER TABLE `journal_volumes`
  ADD CONSTRAINT `journal_volumes_ibfk_1` FOREIGN KEY (`ChiefEditorId`) REFERENCES `person` (`PId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `journal_volumes_ibfk_2` FOREIGN KEY (`DocId`) REFERENCES `document` (`DocId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proceedings`
--
ALTER TABLE `proceedings`
  ADD CONSTRAINT `proceedings_ibfk_1` FOREIGN KEY (`ProceedingsId`) REFERENCES `document` (`DocId`);

--
-- Constraints for table `proceedings_chairs`
--
ALTER TABLE `proceedings_chairs`
  ADD CONSTRAINT `proceedings_chairs_ibfk_1` FOREIGN KEY (`ProceedingsId`) REFERENCES `proceedings` (`ProceedingsId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `proceedings_chairs_ibfk_2` FOREIGN KEY (`ChairId`) REFERENCES `person` (`PId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reserves`
--
ALTER TABLE `reserves`
  ADD CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`DocId`,`CopyNo`,`BId`) REFERENCES `copy` (`DocId`, `CopyNo`, `BId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`ResNumber`) REFERENCES `reservation` (`ResNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reserves_ibfk_3` FOREIGN KEY (`ReaderId`) REFERENCES `reader` (`ReaderId`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
DROP EVENT `CALC_FINE2`$$
CREATE DEFINER=`root`@`localhost` EVENT `CALC_FINE2` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 01:43:17' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE BOR_TRANSACTION SET Fine = Fine + 20  WHERE BorNumber = '2' AND CURRENT_TIMESTAMP() > '2020-12-31 01:43:17'$$

DROP EVENT `CALC_FINE3`$$
CREATE DEFINER=`root`@`localhost` EVENT `CALC_FINE3` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 01:43:17' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE BOR_TRANSACTION SET Fine = Fine + 20  WHERE BorNumber = '3' AND CURRENT_TIMESTAMP() > '2020-12-31 01:43:17'$$

DROP EVENT `REMOVE_RESERVATION`$$
CREATE DEFINER=`root`@`localhost` EVENT `REMOVE_RESERVATION` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 18:00:00' ON COMPLETION PRESERVE ENABLE DO DELETE FROM RESERVATION$$

DROP EVENT `CALC_FINE1`$$
CREATE DEFINER=`root`@`localhost` EVENT `CALC_FINE1` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 08:13:23' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE BOR_TRANSACTION SET Fine = Fine + 20  WHERE BorNumber = '1' AND CURRENT_TIMESTAMP() > '2020-12-31 08:13:23'$$

DROP EVENT `CALC_FINE4`$$
CREATE DEFINER=`root`@`localhost` EVENT `CALC_FINE4` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 08:14:02' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE BOR_TRANSACTION SET Fine = Fine + 20  WHERE BorNumber = '4' AND CURRENT_TIMESTAMP() > '2020-12-31 08:14:02'$$

DROP EVENT `CALC_FINE5`$$
CREATE DEFINER=`root`@`localhost` EVENT `CALC_FINE5` ON SCHEDULE EVERY 1 DAY STARTS '2020-12-11 08:34:24' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE BOR_TRANSACTION SET Fine = Fine + 20  WHERE BorNumber = '5' AND CURRENT_TIMESTAMP() > '2020-12-31 08:34:23'$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

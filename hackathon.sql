-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 22, 2017 at 01:30 PM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hackathon`
--

-- --------------------------------------------------------

--
-- Table structure for table `trandata`
--

CREATE TABLE IF NOT EXISTS `trandata` (
`token` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `address` varchar(50) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1017 ;

--
-- Dumping data for table `trandata`
--

INSERT INTO `trandata` (`token`, `first_name`, `last_name`, `amount`, `address`, `telephone`, `email`) VALUES
(1000, 'ruwandika', 'wijesiri', 330000, 'Colombo11', 'ruwandika@gmail.com', '+8978943'),
(1001, 'chamila', 'wijesiri', 330000, 'Colombo11', 'ruwandika@gmail.com', '+8978943'),
(1012, 'ruwandika', 'wijesiri', 330000, 'Colombo11', 'ruwandika@gmail.com', '+8978943'),
(1016, 'malki', 'perera', 530000, 'Nugegoda', 'ruwandika@gmail.com', '+8978943');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trandata`
--
ALTER TABLE `trandata`
 ADD PRIMARY KEY (`token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trandata`
--
ALTER TABLE `trandata`
MODIFY `token` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1017;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

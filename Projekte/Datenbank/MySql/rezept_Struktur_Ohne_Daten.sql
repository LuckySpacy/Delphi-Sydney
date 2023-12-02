-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 02. Apr 2021 um 16:59
-- Server-Version: 10.4.14-MariaDB
-- PHP-Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `rezept`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rezept`
--

CREATE TABLE `rezept` (
  `RZ_ID` int(11) NOT NULL,
  `RZ_NAME` varchar(255) NOT NULL,
  `RZ_BESCHREIBUNG` blob NOT NULL,
  `RZ_NOTIZ` blob NOT NULL,
  `RZ_RL_ID` int(11) NOT NULL,
  `RZ_UPDATE` varchar(1) NOT NULL,
  `RZ_DELETE` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rezeptzutaten`
--

CREATE TABLE `rezeptzutaten` (
  `RT_ID` int(11) NOT NULL,
  `RT_MENGE` double NOT NULL,
  `RT_NAME` varchar(255) NOT NULL,
  `RT_RZ_ID` int(11) NOT NULL,
  `RT_ZL_ID` int(11) NOT NULL,
  `RT_ZT_ID` int(11) NOT NULL,
  `RT_EINHEIT` varchar(20) NOT NULL,
  `RT_UPDATE` varchar(1) NOT NULL,
  `RT_DELETE` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rzzt`
--

CREATE TABLE `rzzt` (
  `RL_ID` int(11) NOT NULL,
  `RL_RZ_ID` int(11) NOT NULL,
  `RL_ZL_ID` int(11) NOT NULL,
  `RL_DELETE` varchar(1) NOT NULL,
  `RL_UPDATE` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zutaten`
--

CREATE TABLE `zutaten` (
  `ZT_ID` int(11) NOT NULL,
  `ZT_NAME` varchar(255) NOT NULL,
  `ZT_UPDATE` varchar(1) NOT NULL,
  `ZT_DELETE` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zutatenlistenname`
--

CREATE TABLE `zutatenlistenname` (
  `ZL_ID` int(11) NOT NULL,
  `ZL_NAME` varchar(255) NOT NULL,
  `ZL_UPDATE` varchar(1) NOT NULL,
  `ZL_DELETE` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `rezept`
--
ALTER TABLE `rezept`
  ADD PRIMARY KEY (`RZ_ID`);

--
-- Indizes für die Tabelle `rezeptzutaten`
--
ALTER TABLE `rezeptzutaten`
  ADD PRIMARY KEY (`RT_ID`);

--
-- Indizes für die Tabelle `rzzt`
--
ALTER TABLE `rzzt`
  ADD PRIMARY KEY (`RL_ID`);

--
-- Indizes für die Tabelle `zutatenlistenname`
--
ALTER TABLE `zutatenlistenname`
  ADD PRIMARY KEY (`ZL_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

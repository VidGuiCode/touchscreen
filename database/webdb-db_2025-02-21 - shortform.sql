-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Erstellungszeit: 21. Feb 2025 um 21:33
-- Server-Version: 8.2.0
-- PHP-Version: 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `webdb`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `measurement`
--

CREATE TABLE `measurement` (
  `pk_measurement` int NOT NULL,
  `recordDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `soilMoisture` float DEFAULT NULL,
  `airHumidity` float DEFAULT NULL,
  `airTemperature` float DEFAULT NULL,
  `ambientBrightness` float DEFAULT NULL,
  `lampBrightness` int DEFAULT '0',
  `fk_node_isRecorded` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `measurement`
--

INSERT INTO `measurement` (`pk_measurement`, `recordDateTime`, `soilMoisture`, `airHumidity`, `airTemperature`, `ambientBrightness`, `lampBrightness`, `fk_node_isRecorded`) VALUES
(1, '2023-07-14 10:00:00', 65, 60, 28.5, 260, 100, 1),
(2, '2024-02-21 15:20:00', 55, 65, 18, 866, 0, 3),
(5020, '2023-09-14 10:00:00', 65, 60, 28.5, 260, 100, 7),
(5021, '2025-02-03 10:55:37', 52, NULL, 25, NULL, 100, 2),
(5022, '2025-02-03 10:55:39', 3, NULL, 25, NULL, 100, 2),
(5023, '2025-02-05 12:12:46', 50, NULL, 25, NULL, 100, 5),
(5024, '2025-02-05 12:30:46', 70, 50, 28, 100, 100, 2),
(5025, '2025-02-06 11:30:46', 70, 50, 28, 100, 100, 3),
(5026, '2025-02-06 11:33:46', 100, 100, 100, 100, 0, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `node`
--

CREATE TABLE `node` (
  `pk_node` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `macAddress` varchar(17) NOT NULL,
  `fk_plantVariety_contains` int DEFAULT NULL,
  `plantingDate` date DEFAULT NULL,
  `fk_operator_belongs` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `node`
--

INSERT INTO `node` (`pk_node`, `name`, `macAddress`, `fk_plantVariety_contains`, `plantingDate`, `fk_operator_belongs`) VALUES
(1, 'Kitchen Corner', 'AA:BB:CC:DD:EE:FF', 1, '2024-06-15', 3),
(2, 'Angie', '11:22:33:44:55:66', 2, '2023-02-20', 2),
(3, 'Tommy the Tomato', 'E1:22:33:B3:55:11', 5, '2024-03-28', 3),
(4, NULL, 'AA:11:BB:22:CC:33', NULL, NULL, 4),
(5, NULL, 'AA:22:BB:FF:CC:33', NULL, NULL, 1),
(6, 'New', 'AA:BB:CC:DD:EE:F5', 3, '2024-12-16', 3),
(7, 'Test for gui', 'AA:BB:CC:DD:EE:F2', 7, '2024-09-15', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `operator`
--

CREATE TABLE `operator` (
  `pk_user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','User') NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `language_preference` enum('EN','DE') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `operator`
--

INSERT INTO `operator` (`pk_user_id`, `first_name`, `last_name`, `email`, `password`, `role`, `last_login`, `last_update`, `created_at`, `language_preference`, `is_active`, `email_verified`) VALUES
(1, 'admin', '', 'admin@example.com', '$2y$10$H9pnGQ2LbH0odJO7hT.tleb/NkmhDXIKdr/xLOZgURtRtzfxancGC', 'Admin', NULL, NULL, '2025-01-10 12:21:46', 'EN', 1, 1),
(2, 'John', 'Doe', 'john.doe@example.com', '$2y$10$N.HNCZIyOMQRHXrbNr0mIuVQiMZvmzwEaIJg2MSyPGi/b4SW5z4CC', 'User', NULL, '2025-01-20 09:46:58', '2025-01-10 12:25:13', 'EN', 1, 0),
(3, 'Jane', 'Smith', 'jane.smith@example.com', '$2y$10$N.HNCZIyOMQRHXrbNr0mIuVQiMZvmzwEaIJg2MSyPGi/b4SW5z4CC', 'User', NULL, NULL, '2025-01-10 12:25:13', 'EN', 1, 0),
(4, 'Hans', 'Mueller', 'hans.mueller@example.com', '$2y$10$N.HNCZIyOMQRHXrbNr0mIuVQiMZvmzwEaIJg2MSyPGi/b4SW5z4CC', 'User', NULL, NULL, '2025-01-10 12:25:46', 'DE', 1, 0),
(5, 'Guilherme', 'Videira Marques', 'vidgu017@gmail.com', '$2y$10$0XtN88iHBm5acLgmlTdEMO1jdj0RjM0.XMSerCnaBJtzCfl2Cn3ba', 'Admin', NULL, '2025-02-04 11:30:42', '2025-01-11 00:16:56', 'EN', 1, 0),
(7, 'Guilherme', 'Marques', 'vidgu017@gmail.lu', '$2y$10$bTCs69LXQmiCVwqtB0t2AO2R.Wr0z4.h9XW9NrJmTxFFu9dz2c1Wi', 'User', NULL, NULL, '2025-01-11 00:22:17', 'EN', 1, 0),
(8, 'Test2', 'JooJooo', 'donse@gmail.com', '$2y$10$2ZaQHeexMEWWYDw6h.V4veTmXbAHuVzOZXAaRqAYIvBzmPIeKJ0pC', 'User', NULL, NULL, '2025-01-13 09:02:50', 'EN', 1, 0),
(9, 'Gui', 'Mar', 'vidgu017@school.lu', '$2y$10$M4hCXh8pdtWNmLIqEkUzP.8rArWOkrHGrh/Clv5EvLScBkOCRLE3u', 'User', NULL, NULL, '2025-01-14 23:34:27', 'EN', 1, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `operator_extensions`
--

CREATE TABLE `operator_extensions` (
  `pkfk_user_id` int NOT NULL,
  `verification_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `verification_expiration` datetime DEFAULT NULL,
  `recovery_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `recovery_expiration` datetime DEFAULT NULL,
  `dashboard_view` enum('list','grid') NOT NULL DEFAULT 'list',
  `theme` enum('light','dark') NOT NULL DEFAULT 'light',
  `session_id` varchar(255) DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `operator_extensions`
--

INSERT INTO `operator_extensions` (`pkfk_user_id`, `verification_token`, `verification_expiration`, `recovery_token`, `recovery_expiration`, `dashboard_view`, `theme`, `session_id`, `last_activity`, `ip_address`, `user_agent`) VALUES
(1, NULL, NULL, NULL, NULL, 'list', 'light', '8597qafptftrvlajibnrh5kd32', '2025-02-07 16:26:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'),
(2, NULL, NULL, NULL, NULL, 'list', 'light', 'vm5sgdoo28a2abemj0vhbk5pi8', '2025-02-05 17:22:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36'),
(3, NULL, NULL, NULL, NULL, 'list', 'dark', '8du839lljgjfis5qpbvadf43kn', '2025-02-07 15:33:47', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'),
(5, NULL, NULL, NULL, NULL, 'grid', 'dark', '8005q3vl3l6anrt5lft1lptvpf', '2025-02-11 15:51:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36'),
(8, NULL, NULL, NULL, NULL, 'list', 'light', 'jldo3280affav11i8e0nperir1', '2025-01-13 09:14:16', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `plantvariety`
--

CREATE TABLE `plantvariety` (
  `pk_plantVariety` int NOT NULL,
  `commonName` varchar(100) NOT NULL,
  `botanicalName` varchar(100) DEFAULT NULL,
  `ambientBrightnessThreshold` int NOT NULL DEFAULT '50',
  `soilMoistureThreshold` int NOT NULL DEFAULT '40',
  `airTemperatureOptimal` int NOT NULL DEFAULT '23',
  `airHumidityOptimal` int NOT NULL DEFAULT '60',
  `created_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `plantvariety`
--

INSERT INTO `plantvariety` (`pk_plantVariety`, `commonName`, `botanicalName`, `ambientBrightnessThreshold`, `soilMoistureThreshold`, `airTemperatureOptimal`, `airHumidityOptimal`, `created_by`) VALUES
(1, 'Monstera', 'Monstera deliciosa', 180, 60, 24, 60, 3),
(2, 'Fiddle Leaf Fig', 'Ficus lyrata', 100, 70, 28, 50, NULL),
(3, 'Snake Plant', 'Sansevieria trifasciata', 60, 50, 20, 40, NULL),
(4, 'Cactus', 'Cactaceae', 450, 20, 25, 30, NULL),
(5, 'Tomato', 'Solanum lycopersicum', 1000, 60, 22, 50, NULL),
(6, 'Apple', 'Malus domestica', 1000, 60, 23, 60, NULL),
(7, 'Señorita banana', 'Musa acuminata', 50000, 60, 23, 60, NULL),
(8, 'Pineapple', 'Ananas comosus', 15000, 50, 23, 60, NULL),
(9, 'Tom', 'Tomi', 2000, 10, 23, 60, 3),
(10, 'Oskar', 'Oskarios', 20000, 100, 23, 60, 5),
(11, 'Applee', 'Apola', 100, 20, 28, 20, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `task`
--

CREATE TABLE `task` (
  `pk_task` int NOT NULL,
  `scheduledDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `taskType` enum('pump','light') NOT NULL,
  `setPoint` int NOT NULL,
  `completionFlag` tinyint(1) NOT NULL DEFAULT '0',
  `fk_node_isAssigned` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Daten für Tabelle `task`
--

INSERT INTO `task` (`pk_task`, `scheduledDateTime`, `taskType`, `setPoint`, `completionFlag`, `fk_node_isAssigned`) VALUES
(1, '2023-06-01 08:00:00', 'light', 100, 1, 1),
(2, '2023-06-01 09:00:00', 'pump', 50, 1, 3),
(3, '2023-06-02 10:00:00', 'light', 75, 1, 3),
(4, '2024-06-07 08:45:00', 'pump', 55, 1, 2),
(5, '2024-07-15 08:00:00', 'pump', 100, 1, 1),
(6, '2024-07-15 09:00:00', 'light', 75, 1, 2),
(7, '2024-07-15 10:00:00', 'pump', 50, 1, 1),
(8, '2024-12-12 23:39:12', 'pump', 100, 0, 1),
(9, '2024-12-12 23:42:12', 'light', 100, 1, 1),
(10, '2024-12-12 23:46:33', 'light', 100, 1, 1),
(11, '2024-12-12 23:47:19', 'light', 0, 1, 1),
(12, '2024-12-12 23:47:34', 'light', 100, 1, 1),
(13, '2024-12-13 00:05:12', 'light', 100, 1, 1),
(14, '2024-12-13 00:05:38', 'light', 0, 1, 1),
(15, '2024-12-13 00:10:06', 'light', 0, 1, 1),
(16, '2024-12-13 00:11:23', 'light', 0, 1, 1),
(17, '2024-12-13 00:16:00', 'light', 0, 0, 2),
(18, '2024-12-13 08:04:19', 'light', 0, 0, 2),
(19, '2024-12-13 08:04:25', 'pump', 100, 0, 2),
(20, '2024-12-13 08:04:42', 'pump', 100, 0, 2),
(21, '2024-12-13 10:48:23', 'light', 100, 0, 3),
(22, '2024-12-13 11:37:25', 'light', 100, 1, 1),
(23, '2024-12-13 11:38:41', 'pump', 100, 0, 1),
(24, '2024-12-13 11:44:12', 'light', 100, 1, 1),
(25, '2024-12-13 11:44:13', 'light', 100, 0, 2),
(26, '2024-12-13 12:11:44', 'light', 100, 0, 2),
(27, '2024-12-13 15:30:24', 'pump', 100, 0, 1),
(28, '2024-12-13 15:51:25', 'pump', 100, 0, 1),
(29, '2024-12-13 15:53:23', 'pump', 100, 0, 3),
(30, '2024-12-16 09:41:27', 'pump', 150, 0, 6),
(31, '2025-01-20 10:31:44', 'pump', 200, 0, 2),
(32, '2025-01-20 10:32:17', 'light', 100, 0, 2),
(34, '2025-01-29 18:15:42', 'pump', 100, 0, 2),
(35, '2025-02-03 09:16:44', 'pump', 150, 0, 7),
(36, '2025-02-03 10:18:51', 'pump', 150, 0, 2),
(37, '2025-02-05 00:56:20', 'pump', 500, 0, 2),
(39, '2025-02-06 16:02:40', 'pump', 250, 0, 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `measurement`
--
ALTER TABLE `measurement`
  ADD PRIMARY KEY (`pk_measurement`),
  ADD KEY `fk_measurement_node` (`fk_node_isRecorded`);

--
-- Indizes für die Tabelle `node`
--
ALTER TABLE `node`
  ADD PRIMARY KEY (`pk_node`),
  ADD UNIQUE KEY `macAddress` (`macAddress`),
  ADD KEY `fk_node_operator` (`fk_operator_belongs`),
  ADD KEY `fk_node_plantvariety` (`fk_plantVariety_contains`);

--
-- Indizes für die Tabelle `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`pk_user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indizes für die Tabelle `operator_extensions`
--
ALTER TABLE `operator_extensions`
  ADD PRIMARY KEY (`pkfk_user_id`),
  ADD KEY `idx_user_session` (`pkfk_user_id`,`session_id`);

--
-- Indizes für die Tabelle `plantvariety`
--
ALTER TABLE `plantvariety`
  ADD PRIMARY KEY (`pk_plantVariety`),
  ADD KEY `commonName` (`commonName`),
  ADD KEY `botanicalName` (`botanicalName`),
  ADD KEY `fk_created_by` (`created_by`);

--
-- Indizes für die Tabelle `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`pk_task`),
  ADD KEY `fk_task_node` (`fk_node_isAssigned`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `measurement`
--
ALTER TABLE `measurement`
  MODIFY `pk_measurement` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5027;

--
-- AUTO_INCREMENT für Tabelle `node`
--
ALTER TABLE `node`
  MODIFY `pk_node` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `operator`
--
ALTER TABLE `operator`
  MODIFY `pk_user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `plantvariety`
--
ALTER TABLE `plantvariety`
  MODIFY `pk_plantVariety` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT für Tabelle `task`
--
ALTER TABLE `task`
  MODIFY `pk_task` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `measurement`
--
ALTER TABLE `measurement`
  ADD CONSTRAINT `fk_measurement_node` FOREIGN KEY (`fk_node_isRecorded`) REFERENCES `node` (`pk_node`);

--
-- Constraints der Tabelle `node`
--
ALTER TABLE `node`
  ADD CONSTRAINT `fk_node_operator` FOREIGN KEY (`fk_operator_belongs`) REFERENCES `operator` (`pk_user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_node_plantvariety` FOREIGN KEY (`fk_plantVariety_contains`) REFERENCES `plantvariety` (`pk_plantVariety`);

--
-- Constraints der Tabelle `operator_extensions`
--
ALTER TABLE `operator_extensions`
  ADD CONSTRAINT `operator_extensions_ibfk_1` FOREIGN KEY (`pkfk_user_id`) REFERENCES `operator` (`pk_user_id`);

--
-- Constraints der Tabelle `plantvariety`
--
ALTER TABLE `plantvariety`
  ADD CONSTRAINT `fk_created_by` FOREIGN KEY (`created_by`) REFERENCES `operator` (`pk_user_id`) ON DELETE SET NULL;

--
-- Constraints der Tabelle `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `fk_task_node` FOREIGN KEY (`fk_node_isAssigned`) REFERENCES `node` (`pk_node`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

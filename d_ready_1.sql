-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table yasumi_api.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `subject_type` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `causer_type` varchar(255) DEFAULT NULL,
  `causer_id` bigint(20) unsigned DEFAULT NULL,
  `properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`properties`)),
  `batch_uuid` char(36) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject` (`subject_type`,`subject_id`),
  KEY `causer` (`causer_type`,`causer_id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.activity_log: ~205 rows (approximately)
INSERT INTO `activity_log` (`id`, `log_name`, `description`, `subject_type`, `event`, `subject_id`, `causer_type`, `causer_id`, `properties`, `batch_uuid`, `created_at`, `updated_at`) VALUES
	(1, 'Service', 'created', 'App\\Models\\User', 'created', 1, NULL, NULL, '{"attributes":{"name":"Admin","username":"Admin","password":"$2y$12$cEaf0sGFNsBnvo9kuvjDTOQsXD3h3yDPWEOZliJFwtS7pj9UEoTYy","role":"Admin","portal":"CMS","is_active":1}}', NULL, '2024-01-16 17:22:03', '2024-01-16 17:22:03'),
	(2, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 1, 'App\\Models\\User', 1, '{"attributes":{"name":"MARKETING EXP","is_active":1}}', NULL, '2024-01-16 17:28:02', '2024-01-16 17:28:02'),
	(3, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 2, 'App\\Models\\User', 1, '{"attributes":{"name":"OFFICE SUPPLIES & EQUIP.","is_active":1}}', NULL, '2024-01-16 17:28:08', '2024-01-16 17:28:08'),
	(4, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 3, 'App\\Models\\User', 1, '{"attributes":{"name":"SPA SUPPLIES","is_active":1}}', NULL, '2024-01-16 17:28:12', '2024-01-16 17:28:12'),
	(5, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 4, 'App\\Models\\User', 1, '{"attributes":{"name":"SPA TOOLS AND DECOR","is_active":1}}', NULL, '2024-01-16 17:28:15', '2024-01-16 17:28:15'),
	(6, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 5, 'App\\Models\\User', 1, '{"attributes":{"name":"SPA FURNITURES & EQUIP.","is_active":1}}', NULL, '2024-01-16 17:28:18', '2024-01-16 17:28:18'),
	(7, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 6, 'App\\Models\\User', 1, '{"attributes":{"name":"KITCHEN UTILITY","is_active":1}}', NULL, '2024-01-16 17:28:22', '2024-01-16 17:28:22'),
	(8, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 7, 'App\\Models\\User', 1, '{"attributes":{"name":"TOILET & CLEANING SUPPLIES","is_active":1}}', NULL, '2024-01-16 17:28:26', '2024-01-16 17:28:26'),
	(9, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 8, 'App\\Models\\User', 1, '{"attributes":{"name":"RENT","is_active":1}}', NULL, '2024-01-16 17:28:29', '2024-01-16 17:28:29'),
	(10, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 9, 'App\\Models\\User', 1, '{"attributes":{"name":"MAINTENANCE AND REPAIR","is_active":1}}', NULL, '2024-01-16 17:28:32', '2024-01-16 17:28:32'),
	(11, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 10, 'App\\Models\\User', 1, '{"attributes":{"name":"SALARIES AND WAGES","is_active":1}}', NULL, '2024-01-16 17:28:38', '2024-01-16 17:28:38'),
	(12, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 11, 'App\\Models\\User', 1, '{"attributes":{"name":"UTILITY-LIGHT","is_active":1}}', NULL, '2024-01-16 17:28:42', '2024-01-16 17:28:42'),
	(13, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 12, 'App\\Models\\User', 1, '{"attributes":{"name":"UTILITY-WATER","is_active":1}}', NULL, '2024-01-16 17:28:45', '2024-01-16 17:28:45'),
	(14, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 13, 'App\\Models\\User', 1, '{"attributes":{"name":"TELECOMMUNICATIONS","is_active":1}}', NULL, '2024-01-16 17:28:49', '2024-01-16 17:28:49'),
	(15, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 14, 'App\\Models\\User', 1, '{"attributes":{"name":"TRAININGS & SEMINAR","is_active":1}}', NULL, '2024-01-16 17:28:52', '2024-01-16 17:28:52'),
	(16, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 15, 'App\\Models\\User', 1, '{"attributes":{"name":"LEGAL EXP","is_active":1}}', NULL, '2024-01-16 17:28:55', '2024-01-16 17:28:55'),
	(17, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 16, 'App\\Models\\User', 1, '{"attributes":{"name":"RETAINERS FEE","is_active":1}}', NULL, '2024-01-16 17:28:58', '2024-01-16 17:28:58'),
	(18, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 17, 'App\\Models\\User', 1, '{"attributes":{"name":"DEBTS","is_active":1}}', NULL, '2024-01-16 17:29:02', '2024-01-16 17:29:02'),
	(19, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 18, 'App\\Models\\User', 1, '{"attributes":{"name":"EMPLOYEES PERKS","is_active":1}}', NULL, '2024-01-16 17:29:05', '2024-01-16 17:29:05'),
	(20, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 19, 'App\\Models\\User', 1, '{"attributes":{"name":"UNIFORM","is_active":1}}', NULL, '2024-01-16 17:29:09', '2024-01-16 17:29:09'),
	(21, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 20, 'App\\Models\\User', 1, '{"attributes":{"name":"PURIFIED WATER","is_active":1}}', NULL, '2024-01-16 17:29:14', '2024-01-16 17:29:14'),
	(22, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 21, 'App\\Models\\User', 1, '{"attributes":{"name":"LAUNDRY","is_active":1}}', NULL, '2024-01-16 17:29:17', '2024-01-16 17:29:17'),
	(23, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 22, 'App\\Models\\User', 1, '{"attributes":{"name":"PERSONAL DRAWING","is_active":1}}', NULL, '2024-01-16 17:29:21', '2024-01-16 17:29:21'),
	(24, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 23, 'App\\Models\\User', 1, '{"attributes":{"name":"MEAL EXP","is_active":1}}', NULL, '2024-01-16 17:29:24', '2024-01-16 17:29:24'),
	(25, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 24, 'App\\Models\\User', 1, '{"attributes":{"name":"FREIGHT","is_active":1}}', NULL, '2024-01-16 17:29:28', '2024-01-16 17:29:28'),
	(26, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 25, 'App\\Models\\User', 1, '{"attributes":{"name":"TRAVEL EXP","is_active":1}}', NULL, '2024-01-16 17:29:31', '2024-01-16 17:29:31'),
	(27, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 26, 'App\\Models\\User', 1, '{"attributes":{"name":"TAXES & LICENSES","is_active":1}}', NULL, '2024-01-16 17:29:36', '2024-01-16 17:29:36'),
	(28, 'Expense Category', 'created', 'App\\Models\\ExpenseCategory', 'created', 27, 'App\\Models\\User', 1, '{"attributes":{"name":"CASH ADVANCES","is_active":1}}', NULL, '2024-01-16 17:29:39', '2024-01-16 17:29:39'),
	(29, 'Branch', 'created', 'App\\Models\\Branch', 'created', 1, 'App\\Models\\User', 1, '{"attributes":{"name":"MAIN BRANCH","address":"MATINA","is_active":1}}', NULL, '2024-01-16 17:30:03', '2024-01-16 17:30:03'),
	(30, 'Service', 'created', 'App\\Models\\User', 'created', 2, 'App\\Models\\User', 1, '{"attributes":{"name":"Owner","username":"owner@gmail.com","password":"$2y$12$ufiiyXW7eK7AEif7KUqUA.K9amnLt7Br3kARBUqMmjP\\/7Eo5nZigK","role":"Owner","portal":"Branch","is_active":1}}', NULL, '2024-01-16 17:30:20', '2024-01-16 17:30:20'),
	(31, 'Service', 'created', 'App\\Models\\User', 'created', 3, 'App\\Models\\User', 1, '{"attributes":{"name":"User","username":"user","password":"$2y$12$I1OnPjOI0TdPE233VohrkeQ2ikoi4fCfDTUtw7FR.Kgyup\\/x0oUha","role":"Branch Admin","portal":"Branch","is_active":1}}', NULL, '2024-01-16 17:30:29', '2024-01-16 17:30:29'),
	(32, 'Room', 'created', 'App\\Models\\Room', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"AQUA BED 1","is_active":1}}', NULL, '2024-01-16 17:32:18', '2024-01-16 17:32:18'),
	(33, 'Room', 'created', 'App\\Models\\Room', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"name":"AQUA BED 2","is_active":1}}', NULL, '2024-01-16 17:32:20', '2024-01-16 17:32:20'),
	(34, 'Room', 'created', 'App\\Models\\Room', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"name":"AQUA BED 3","is_active":1}}', NULL, '2024-01-16 17:32:23', '2024-01-16 17:32:23'),
	(35, 'Room', 'created', 'App\\Models\\Room', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"name":"BED 4","is_active":1}}', NULL, '2024-01-16 17:32:28', '2024-01-16 17:32:28'),
	(36, 'Room', 'created', 'App\\Models\\Room', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"name":"BED 5","is_active":1}}', NULL, '2024-01-16 17:32:30', '2024-01-16 17:32:30'),
	(37, 'Room', 'created', 'App\\Models\\Room', 'created', 6, 'App\\Models\\User', 2, '{"attributes":{"name":"BED 6","is_active":1}}', NULL, '2024-01-16 17:32:33', '2024-01-16 17:32:33'),
	(38, 'Room', 'created', 'App\\Models\\Room', 'created', 7, 'App\\Models\\User', 2, '{"attributes":{"name":"BED              7","is_active":1}}', NULL, '2024-01-16 17:32:36', '2024-01-16 17:32:36'),
	(39, 'Room', 'created', 'App\\Models\\Room', 'created', 8, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE CHAIR 1","is_active":1}}', NULL, '2024-01-16 17:33:00', '2024-01-16 17:33:00'),
	(40, 'Room', 'created', 'App\\Models\\Room', 'created', 9, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE CHAIR 2","is_active":1}}', NULL, '2024-01-16 17:33:02', '2024-01-16 17:33:02'),
	(41, 'Room', 'created', 'App\\Models\\Room', 'created', 10, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE CHAIR 3","is_active":1}}', NULL, '2024-01-16 17:33:07', '2024-01-16 17:33:07'),
	(42, 'Item', 'created', 'App\\Models\\Item', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"FOOT SOAK","unit":"20ml","stock":0}}', NULL, '2024-01-16 17:33:56', '2024-01-16 17:33:56'),
	(43, 'Item', 'created', 'App\\Models\\Item', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"name":"SHAMPOO","unit":"60ml","stock":0}}', NULL, '2024-01-16 17:34:20', '2024-01-16 17:34:20'),
	(44, 'Item', 'created', 'App\\Models\\Item', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"name":"HAIR TREATMENT","unit":"40ml","stock":0}}', NULL, '2024-01-16 17:34:28', '2024-01-16 17:34:28'),
	(45, 'Item', 'created', 'App\\Models\\Item', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"name":"EYE STEAM MASK","unit":"PC","stock":0}}', NULL, '2024-01-16 17:34:50', '2024-01-16 17:34:50'),
	(46, 'Item', 'updated', 'App\\Models\\Item', 'updated', 4, 'App\\Models\\User', 2, '{"attributes":{"unit":"1PC"},"old":{"unit":"PC"}}', NULL, '2024-01-16 17:35:06', '2024-01-16 17:35:06'),
	(47, 'Item', 'created', 'App\\Models\\Item', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"name":"ICE COLD GEL","unit":"1ml","stock":0}}', NULL, '2024-01-16 17:35:15', '2024-01-16 17:35:15'),
	(48, 'Item', 'created', 'App\\Models\\Item', 'created', 6, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE OIL (40ml)","unit":"40ml","stock":0}}', NULL, '2024-01-16 17:36:41', '2024-01-16 17:36:41'),
	(49, 'Item', 'created', 'App\\Models\\Item', 'created', 7, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE OIL (60ml)","unit":"60ml","stock":0}}', NULL, '2024-01-16 17:36:50', '2024-01-16 17:36:50'),
	(50, 'Item', 'created', 'App\\Models\\Item', 'created', 8, 'App\\Models\\User', 2, '{"attributes":{"name":"PEPPERMINT OIL","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:36:59', '2024-01-16 17:36:59'),
	(51, 'Item', 'created', 'App\\Models\\Item', 'created', 9, 'App\\Models\\User', 2, '{"attributes":{"name":"LAVANDER OIL","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:37:09', '2024-01-16 17:37:09'),
	(52, 'Item', 'created', 'App\\Models\\Item', 'created', 10, 'App\\Models\\User', 2, '{"attributes":{"name":"SWEET ORANGE OIL","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:37:15', '2024-01-16 17:37:15'),
	(53, 'Item', 'created', 'App\\Models\\Item', 'created', 11, 'App\\Models\\User', 2, '{"attributes":{"name":"EUCALYPTUS OIL","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:37:22', '2024-01-16 17:37:22'),
	(54, 'Item', 'created', 'App\\Models\\Item', 'created', 12, 'App\\Models\\User', 2, '{"attributes":{"name":"CITRONELLA OIL","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:37:28', '2024-01-16 17:37:28'),
	(55, 'Item', 'created', 'App\\Models\\Item', 'created', 13, 'App\\Models\\User', 2, '{"attributes":{"name":"FOOT LOTION","unit":"10ml","stock":0}}', NULL, '2024-01-16 17:37:38', '2024-01-16 17:37:38'),
	(56, 'Service', 'created', 'App\\Models\\Service', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"AQUA HEAD SPA","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:38:45', '2024-01-16 17:38:45'),
	(57, 'Item', 'created', 'App\\Models\\Item', 'created', 14, 'App\\Models\\User', 2, '{"attributes":{"name":"PILLOW SHEET","unit":"1PC","stock":0}}', NULL, '2024-01-16 17:38:53', '2024-01-16 17:38:53'),
	(58, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"service.name":"AQUA HEAD SPA","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:39:05', '2024-01-16 17:39:05'),
	(59, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"service.name":"AQUA HEAD SPA","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:39:11', '2024-01-16 17:39:11'),
	(60, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"service.name":"AQUA HEAD SPA","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:39:15', '2024-01-16 17:39:15'),
	(61, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"service.name":"AQUA HEAD SPA","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:39:22', '2024-01-16 17:39:22'),
	(62, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"service.name":"AQUA HEAD SPA","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:39:28', '2024-01-16 17:39:28'),
	(63, 'Service', 'created', 'App\\Models\\Service', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"name":"VIP AQUA HEAD SPA","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:39:41', '2024-01-16 17:39:41'),
	(64, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 6, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:39:50', '2024-01-16 17:39:50'),
	(65, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 7, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:39:52', '2024-01-16 17:39:52'),
	(66, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 8, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:39:57', '2024-01-16 17:39:57'),
	(67, 'Item', 'created', 'App\\Models\\Item', 'created', 15, 'App\\Models\\User', 2, '{"attributes":{"name":"ALOE GEL","unit":"1PC","stock":0}}', NULL, '2024-01-16 17:40:16', '2024-01-16 17:40:16'),
	(68, 'Item', 'created', 'App\\Models\\Item', 'created', 16, 'App\\Models\\User', 2, '{"attributes":{"name":"FACE SERUM","unit":"1PC","stock":0}}', NULL, '2024-01-16 17:40:24', '2024-01-16 17:40:24'),
	(69, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 9, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"ALOE GEL","qty":1}}', NULL, '2024-01-16 17:40:36', '2024-01-16 17:40:36'),
	(70, 'Item', 'created', 'App\\Models\\Item', 'created', 17, 'App\\Models\\User', 2, '{"attributes":{"name":"FACIAL MASK","unit":"1PC","stock":0}}', NULL, '2024-01-16 17:40:56', '2024-01-16 17:40:56'),
	(71, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 10, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"FACIAL MASK","qty":1}}', NULL, '2024-01-16 17:41:07', '2024-01-16 17:41:07'),
	(72, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 11, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"FACE SERUM","qty":1}}', NULL, '2024-01-16 17:41:12', '2024-01-16 17:41:12'),
	(73, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 12, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:41:17', '2024-01-16 17:41:17'),
	(74, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 13, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VIP AQUA HEAD SPA","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:41:22', '2024-01-16 17:41:22'),
	(75, 'Service', 'created', 'App\\Models\\Service', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"name":"VVIP AQUA HEAD SPA","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:41:40', '2024-01-16 17:41:40'),
	(76, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 14, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:41:46', '2024-01-16 17:41:46'),
	(77, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 15, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:41:49', '2024-01-16 17:41:49'),
	(78, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 16, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:41:53', '2024-01-16 17:41:53'),
	(79, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 17, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:42:01', '2024-01-16 17:42:01'),
	(80, 'Item', 'created', 'App\\Models\\Item', 'created', 18, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE OIL (50ml)","unit":"50ml","stock":0}}', NULL, '2024-01-16 17:42:34', '2024-01-16 17:42:34'),
	(81, 'Item', 'created', 'App\\Models\\Item', 'created', 19, 'App\\Models\\User', 2, '{"attributes":{"name":"MASSAGE OIL (25ml)","unit":"25ml","stock":0}}', NULL, '2024-01-16 17:42:42', '2024-01-16 17:42:42'),
	(82, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 18, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:43:04', '2024-01-16 17:43:04'),
	(83, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 19, 'App\\Models\\User', 2, '{"attributes":{"service.name":"VVIP AQUA HEAD SPA","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:43:11', '2024-01-16 17:43:11'),
	(84, 'Service', 'created', 'App\\Models\\Service', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"name":"SUPREME DUO","amount":0,"duo":1,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:43:28', '2024-01-16 17:43:28'),
	(85, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 20, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:43:35', '2024-01-16 17:43:35'),
	(86, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 21, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:43:41', '2024-01-16 17:43:41'),
	(87, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 22, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:43:47', '2024-01-16 17:43:47'),
	(88, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 23, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:43:53', '2024-01-16 17:43:53'),
	(89, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 24, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"MASSAGE OIL (25ml)","qty":1}}', NULL, '2024-01-16 17:43:58', '2024-01-16 17:43:58'),
	(90, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 25, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SUPREME DUO","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:44:04', '2024-01-16 17:44:04'),
	(91, 'Service', 'created', 'App\\Models\\Service', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"name":"THAI MASSAGE","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:44:22', '2024-01-16 17:44:22'),
	(92, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 26, 'App\\Models\\User', 2, '{"attributes":{"service.name":"THAI MASSAGE","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:44:32', '2024-01-16 17:44:32'),
	(93, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 27, 'App\\Models\\User', 2, '{"attributes":{"service.name":"THAI MASSAGE","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:44:50', '2024-01-16 17:44:50'),
	(94, 'Service', 'created', 'App\\Models\\Service', 'created', 6, 'App\\Models\\User', 2, '{"attributes":{"name":"SWEDISH","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:45:01', '2024-01-16 17:45:01'),
	(95, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 28, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SWEDISH","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:45:06', '2024-01-16 17:45:06'),
	(96, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 29, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SWEDISH","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:45:16', '2024-01-16 17:45:16'),
	(97, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 30, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SWEDISH","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:45:22', '2024-01-16 17:45:22'),
	(98, 'Service', 'created', 'App\\Models\\Service', 'created', 7, 'App\\Models\\User', 2, '{"attributes":{"name":"FOOT MASSAGE","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:45:39', '2024-01-16 17:45:39'),
	(99, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 31, 'App\\Models\\User', 2, '{"attributes":{"service.name":"FOOT MASSAGE","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:45:55', '2024-01-16 17:45:55'),
	(100, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 32, 'App\\Models\\User', 2, '{"attributes":{"service.name":"FOOT MASSAGE","service.unit":null,"item.name":"FOOT LOTION","qty":1}}', NULL, '2024-01-16 17:46:09', '2024-01-16 17:46:09'),
	(101, 'Service', 'created', 'App\\Models\\Service', 'created', 8, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 1 (HEAD SPA + SWEDISH)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:46:31', '2024-01-16 17:46:31'),
	(102, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 33, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:46:39', '2024-01-16 17:46:39'),
	(103, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 34, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:46:42', '2024-01-16 17:46:42'),
	(104, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 35, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:46:48', '2024-01-16 17:46:48'),
	(105, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 36, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:46:54', '2024-01-16 17:46:54'),
	(106, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 37, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:46:57', '2024-01-16 17:46:57'),
	(107, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 38, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"MASSAGE OIL (40ml)","qty":1}}', NULL, '2024-01-16 17:47:02', '2024-01-16 17:47:02'),
	(108, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 39, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 1 (HEAD SPA + SWEDISH)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:47:07', '2024-01-16 17:47:07'),
	(109, 'Service', 'created', 'App\\Models\\Service', 'created', 9, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 2 (HEAD SPA + THAI)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:47:25', '2024-01-16 17:47:25'),
	(110, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 40, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:47:33', '2024-01-16 17:47:33'),
	(111, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 41, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:47:36', '2024-01-16 17:47:36'),
	(112, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 42, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:47:39', '2024-01-16 17:47:39'),
	(113, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 43, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:47:44', '2024-01-16 17:47:44'),
	(114, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 44, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:47:47', '2024-01-16 17:47:47'),
	(115, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 45, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 2 (HEAD SPA + THAI)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:47:52', '2024-01-16 17:47:52'),
	(116, 'Service', 'created', 'App\\Models\\Service', 'created', 10, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 3 (HEAD SPA + FOOT)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:48:09', '2024-01-16 17:48:09'),
	(117, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 46, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:48:16', '2024-01-16 17:48:16'),
	(118, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 47, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:48:18', '2024-01-16 17:48:18'),
	(119, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 48, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:48:22', '2024-01-16 17:48:22'),
	(120, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 49, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:48:27', '2024-01-16 17:48:27'),
	(121, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 50, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:48:31', '2024-01-16 17:48:31'),
	(122, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 51, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 3 (HEAD SPA + FOOT)","service.unit":null,"item.name":"FOOT LOTION","qty":1}}', NULL, '2024-01-16 17:48:42', '2024-01-16 17:48:42'),
	(123, 'Service', 'created', 'App\\Models\\Service', 'created', 11, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 4 (HEAD SPA + BACK)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:48:55', '2024-01-16 17:48:55'),
	(124, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 52, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:49:01', '2024-01-16 17:49:01'),
	(125, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 53, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"SHAMPOO","qty":1}}', NULL, '2024-01-16 17:49:04', '2024-01-16 17:49:04'),
	(126, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 54, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"HAIR TREATMENT","qty":1}}', NULL, '2024-01-16 17:49:14', '2024-01-16 17:49:14'),
	(127, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 55, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"EYE STEAM MASK","qty":1}}', NULL, '2024-01-16 17:49:18', '2024-01-16 17:49:18'),
	(128, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 56, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"ICE COLD GEL","qty":1}}', NULL, '2024-01-16 17:49:25', '2024-01-16 17:49:25'),
	(129, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 57, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"MASSAGE OIL (40ml)","qty":1}}', NULL, '2024-01-16 17:49:29', '2024-01-16 17:49:29'),
	(130, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 58, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 4 (HEAD SPA + BACK)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:49:34', '2024-01-16 17:49:34'),
	(131, 'Service', 'created', 'App\\Models\\Service', 'created', 12, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 5 (SWEDISH + FOOT)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:49:51', '2024-01-16 17:49:51'),
	(132, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 59, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 5 (SWEDISH + FOOT)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:50:03', '2024-01-16 17:50:03'),
	(133, 'Item', 'updated', 'App\\Models\\Item', 'updated', 5, 'App\\Models\\User', 2, '{"attributes":{"name":"ICE COLD GEL (1ml)"},"old":{"name":"ICE COLD GEL"}}', NULL, '2024-01-16 17:51:00', '2024-01-16 17:51:00'),
	(134, 'Item', 'created', 'App\\Models\\Item', 'created', 20, 'App\\Models\\User', 2, '{"attributes":{"name":"ICE COLD GEL (5ml)","unit":"5ml","stock":0}}', NULL, '2024-01-16 17:51:12', '2024-01-16 17:51:12'),
	(135, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 60, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 5 (SWEDISH + FOOT)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:51:21', '2024-01-16 17:51:21'),
	(136, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 61, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 5 (SWEDISH + FOOT)","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:51:27', '2024-01-16 17:51:27'),
	(137, 'Item', 'updated', 'App\\Models\\Item', 'updated', 13, 'App\\Models\\User', 2, '{"attributes":{"name":"FOOT LOTION (10ml)"},"old":{"name":"FOOT LOTION"}}', NULL, '2024-01-16 17:51:55', '2024-01-16 17:51:55'),
	(138, 'Item', 'created', 'App\\Models\\Item', 'created', 21, 'App\\Models\\User', 2, '{"attributes":{"name":"FOOT LOTION (20ml)","unit":"20ml","stock":0}}', NULL, '2024-01-16 17:52:01', '2024-01-16 17:52:01'),
	(139, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 62, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 5 (SWEDISH + FOOT)","service.unit":null,"item.name":"FOOT LOTION (20ml)","qty":1}}', NULL, '2024-01-16 17:52:09', '2024-01-16 17:52:09'),
	(140, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 63, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 5 (SWEDISH + FOOT)","service.unit":null,"item.name":"FOOT LOTION (20ml)","qty":1}}', NULL, '2024-01-16 17:52:22', '2024-01-16 17:52:22'),
	(141, 'Service', 'created', 'App\\Models\\Service', 'created', 13, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 6 (THAI + FOOT)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:52:41', '2024-01-16 17:52:41'),
	(142, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 64, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 6 (THAI + FOOT)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:52:46', '2024-01-16 17:52:46'),
	(143, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 65, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 6 (THAI + FOOT)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:52:52', '2024-01-16 17:52:52'),
	(144, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 66, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 6 (THAI + FOOT)","service.unit":null,"item.name":"FOOT LOTION (20ml)","qty":1}}', NULL, '2024-01-16 17:53:00', '2024-01-16 17:53:00'),
	(145, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 67, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 6 (THAI + FOOT)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:53:08', '2024-01-16 17:53:08'),
	(146, 'Service', 'created', 'App\\Models\\Service', 'created', 14, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 7 (BACK + FOOT)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:53:23', '2024-01-16 17:53:23'),
	(147, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 68, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 7 (BACK + FOOT)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:53:32', '2024-01-16 17:53:32'),
	(148, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 69, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 7 (BACK + FOOT)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:53:38', '2024-01-16 17:53:38'),
	(149, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 70, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 7 (BACK + FOOT)","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:53:43', '2024-01-16 17:53:43'),
	(150, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 71, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 7 (BACK + FOOT)","service.unit":null,"item.name":"FOOT LOTION (20ml)","qty":1}}', NULL, '2024-01-16 17:53:49', '2024-01-16 17:53:49'),
	(151, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 72, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 7 (BACK + FOOT)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:53:53', '2024-01-16 17:53:53'),
	(152, 'Service', 'created', 'App\\Models\\Service', 'created', 15, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 8 (THAI + BACK)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:54:06', '2024-01-16 17:54:06'),
	(153, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 73, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 8 (THAI + BACK)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:54:13', '2024-01-16 17:54:13'),
	(154, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 74, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 8 (THAI + BACK)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:54:18', '2024-01-16 17:54:18'),
	(155, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 75, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 8 (THAI + BACK)","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:54:22', '2024-01-16 17:54:22'),
	(156, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 76, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 8 (THAI + BACK)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:54:28', '2024-01-16 17:54:28'),
	(157, 'Service', 'created', 'App\\Models\\Service', 'created', 16, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 9 (SWEDISH +BACK)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:54:43', '2024-01-16 17:54:43'),
	(158, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 77, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 9 (SWEDISH +BACK)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:54:50', '2024-01-16 17:54:50'),
	(159, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 78, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 9 (SWEDISH +BACK)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:54:54', '2024-01-16 17:54:54'),
	(160, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 79, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 9 (SWEDISH +BACK)","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:54:58', '2024-01-16 17:54:58'),
	(161, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 80, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 9 (SWEDISH +BACK)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:55:01', '2024-01-16 17:55:01'),
	(162, 'Service', 'created', 'App\\Models\\Service', 'created', 17, 'App\\Models\\User', 2, '{"attributes":{"name":"COMBO 10 (SWEDISH + THAI)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:55:11', '2024-01-16 17:55:11'),
	(163, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 81, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 10 (SWEDISH + THAI)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:55:17', '2024-01-16 17:55:17'),
	(164, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 82, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 10 (SWEDISH + THAI)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:55:22', '2024-01-16 17:55:22'),
	(165, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 83, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 10 (SWEDISH + THAI)","service.unit":null,"item.name":"MASSAGE OIL (50ml)","qty":1}}', NULL, '2024-01-16 17:55:28', '2024-01-16 17:55:28'),
	(166, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 84, 'App\\Models\\User', 2, '{"attributes":{"service.name":"COMBO 10 (SWEDISH + THAI)","service.unit":null,"item.name":"PILLOW SHEET","qty":1}}', NULL, '2024-01-16 17:55:32', '2024-01-16 17:55:32'),
	(167, 'Service', 'created', 'App\\Models\\Service', 'created', 18, 'App\\Models\\User', 2, '{"attributes":{"name":"PEPPERMINT OIL","amount":0,"duo":0,"add_on":1,"is_active":1}}', NULL, '2024-01-16 17:55:45', '2024-01-16 17:55:45'),
	(168, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 85, 'App\\Models\\User', 2, '{"attributes":{"service.name":"PEPPERMINT OIL","service.unit":null,"item.name":"PEPPERMINT OIL","qty":1}}', NULL, '2024-01-16 17:56:03', '2024-01-16 17:56:03'),
	(169, 'Service', 'created', 'App\\Models\\Service', 'created', 19, 'App\\Models\\User', 2, '{"attributes":{"name":"LAVANDER OIL","amount":0,"duo":0,"add_on":1,"is_active":1}}', NULL, '2024-01-16 17:56:14', '2024-01-16 17:56:14'),
	(170, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 86, 'App\\Models\\User', 2, '{"attributes":{"service.name":"LAVANDER OIL","service.unit":null,"item.name":"LAVANDER OIL","qty":1}}', NULL, '2024-01-16 17:56:22', '2024-01-16 17:56:22'),
	(171, 'Service', 'created', 'App\\Models\\Service', 'created', 20, 'App\\Models\\User', 2, '{"attributes":{"name":"SWEET ORANGE OIL","amount":0,"duo":0,"add_on":1,"is_active":1}}', NULL, '2024-01-16 17:56:31', '2024-01-16 17:56:31'),
	(172, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 87, 'App\\Models\\User', 2, '{"attributes":{"service.name":"SWEET ORANGE OIL","service.unit":null,"item.name":"SWEET ORANGE OIL","qty":1}}', NULL, '2024-01-16 17:56:38', '2024-01-16 17:56:38'),
	(173, 'Service', 'created', 'App\\Models\\Service', 'created', 21, 'App\\Models\\User', 2, '{"attributes":{"name":"EUCALYPTUS OIL","amount":0,"duo":0,"add_on":1,"is_active":1}}', NULL, '2024-01-16 17:56:46', '2024-01-16 17:56:46'),
	(174, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 88, 'App\\Models\\User', 2, '{"attributes":{"service.name":"EUCALYPTUS OIL","service.unit":null,"item.name":"EUCALYPTUS OIL","qty":1}}', NULL, '2024-01-16 17:56:57', '2024-01-16 17:56:57'),
	(175, 'Service', 'created', 'App\\Models\\Service', 'created', 22, 'App\\Models\\User', 2, '{"attributes":{"name":"CITRONELLA OIL","amount":0,"duo":0,"add_on":1,"is_active":1}}', NULL, '2024-01-16 17:57:04', '2024-01-16 17:57:04'),
	(176, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 89, 'App\\Models\\User', 2, '{"attributes":{"service.name":"CITRONELLA OIL","service.unit":null,"item.name":"CITRONELLA OIL","qty":1}}', NULL, '2024-01-16 17:57:12', '2024-01-16 17:57:12'),
	(177, 'Service', 'created', 'App\\Models\\Service', 'created', 23, 'App\\Models\\User', 2, '{"attributes":{"name":"EXPRESS MASSAGE (Foot)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:58:16', '2024-01-16 17:58:16'),
	(178, 'Service', 'created', 'App\\Models\\Service', 'created', 24, 'App\\Models\\User', 2, '{"attributes":{"name":"EXPRESS MASSAGE (Head)","amount":0,"duo":0,"add_on":0,"is_active":1}}', NULL, '2024-01-16 17:58:26', '2024-01-16 17:58:26'),
	(179, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 90, 'App\\Models\\User', 2, '{"attributes":{"service.name":"EXPRESS MASSAGE (Foot)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:58:33', '2024-01-16 17:58:33'),
	(180, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 91, 'App\\Models\\User', 2, '{"attributes":{"service.name":"EXPRESS MASSAGE (Foot)","service.unit":null,"item.name":"FOOT LOTION (10ml)","qty":1}}', NULL, '2024-01-16 17:58:44', '2024-01-16 17:58:44'),
	(181, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 92, 'App\\Models\\User', 2, '{"attributes":{"service.name":"EXPRESS MASSAGE (Head)","service.unit":null,"item.name":"FOOT SOAK","qty":1}}', NULL, '2024-01-16 17:58:50', '2024-01-16 17:58:50'),
	(182, 'Item Consumption', 'created', 'App\\Models\\ItemConsumption', 'created', 93, 'App\\Models\\User', 2, '{"attributes":{"service.name":"EXPRESS MASSAGE (Head)","service.unit":null,"item.name":"ICE COLD GEL (5ml)","qty":1}}', NULL, '2024-01-16 17:58:58', '2024-01-16 17:58:58'),
	(183, 'Therapist', 'created', 'App\\Models\\Therapist', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"TP1","commission":10,"is_active":1}}', NULL, '2024-01-16 18:05:30', '2024-01-16 18:05:30'),
	(184, 'Therapist', 'created', 'App\\Models\\Therapist', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"name":"TP2","commission":20,"is_active":1}}', NULL, '2024-01-16 18:05:34', '2024-01-16 18:05:34'),
	(185, 'Therapist', 'created', 'App\\Models\\Therapist', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"name":"TP3","commission":30,"is_active":1}}', NULL, '2024-01-16 18:05:39', '2024-01-16 18:05:39'),
	(186, 'Therapist', 'created', 'App\\Models\\Therapist', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"name":"TP4","commission":40,"is_active":1}}', NULL, '2024-01-16 18:05:44', '2024-01-16 18:05:44'),
	(187, 'Therapist', 'created', 'App\\Models\\Therapist', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"name":"TP5","commission":5,"is_active":1}}', NULL, '2024-01-16 18:05:48', '2024-01-16 18:05:48'),
	(188, 'Therapist', 'updated', 'App\\Models\\Therapist', 'updated', 5, 'App\\Models\\User', 2, '{"attributes":{"commission":50},"old":{"commission":5}}', NULL, '2024-01-16 18:05:54', '2024-01-16 18:05:54'),
	(189, 'Employee', 'created', 'App\\Models\\Employee', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"EMP1","rate":500,"is_active":1}}', NULL, '2024-01-16 18:06:02', '2024-01-16 18:06:02'),
	(190, 'Employee', 'created', 'App\\Models\\Employee', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"name":"EMP2","rate":550,"is_active":1}}', NULL, '2024-01-16 18:06:06', '2024-01-16 18:06:06'),
	(191, 'Customer', 'created', 'App\\Models\\Customer', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"name":"RDC","email":"RDC@GMAIL.COM","contact_no":"09190080591"}}', NULL, '2024-01-16 18:07:01', '2024-01-16 18:07:01'),
	(192, 'Service', 'updated', 'App\\Models\\Service', 'updated', 1, 'App\\Models\\User', 2, '{"attributes":{"amount":500},"old":{"amount":0}}', NULL, '2024-01-16 18:07:19', '2024-01-16 18:07:19'),
	(193, 'Service', 'updated', 'App\\Models\\Service', 'updated', 2, 'App\\Models\\User', 2, '{"attributes":{"amount":1000},"old":{"amount":0}}', NULL, '2024-01-16 18:07:23', '2024-01-16 18:07:23'),
	(194, 'Service', 'updated', 'App\\Models\\Service', 'updated', 4, 'App\\Models\\User', 2, '{"attributes":{"amount":750},"old":{"amount":0}}', NULL, '2024-01-16 18:07:34', '2024-01-16 18:07:34'),
	(195, 'Expense', 'created', 'App\\Models\\Expense', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"date":"2024-01-17","particulars":"TEST","payee":"TEST","amount":100,"expense_category":"MARKETING EXP","petty_cash":0,"cancelled":0}}', NULL, '2024-01-17 05:25:15', '2024-01-17 05:25:15'),
	(196, 'Expense', 'created', 'App\\Models\\Expense', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"date":"2024-01-17","particulars":"TEST 1","payee":"TEST 1","amount":123,"expense_category":"MARKETING EXP","petty_cash":0,"cancelled":0}}', NULL, '2024-01-17 05:25:24', '2024-01-17 05:25:24'),
	(197, 'Booking', 'created', 'App\\Models\\Booking', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"customer.name":"RDC","date":"2024-01-17","time":"03:30","room.name":"AQUA BED 2","total_amount":0,"dp":0,"dp_payment_method":null,"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:33:17', '2024-01-17 05:33:17'),
	(198, 'Booking', 'created', 'App\\Models\\Booking', 'created', 2, 'App\\Models\\User', 2, '{"attributes":{"customer.name":"RDC","date":"2024-01-17","time":"05:30","room.name":"AQUA BED 1","total_amount":0,"dp":0,"dp_payment_method":null,"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:34:35', '2024-01-17 05:34:35'),
	(199, 'Booking', 'created', 'App\\Models\\Booking', 'created', 3, 'App\\Models\\User', 2, '{"attributes":{"customer.name":"RDC","date":"2024-01-17","time":"04:30","room.name":"AQUA BED 3","total_amount":0,"dp":0,"dp_payment_method":null,"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:36:04', '2024-01-17 05:36:04'),
	(200, 'Booking', 'created', 'App\\Models\\Booking', 'created', 4, 'App\\Models\\User', 2, '{"attributes":{"customer.name":"RDC","date":"2024-01-17","time":"03:30","room.name":"BED 4","total_amount":0,"dp":0,"dp_payment_method":null,"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:36:30', '2024-01-17 05:36:30'),
	(201, 'Booking', 'created', 'App\\Models\\Booking', 'created', 5, 'App\\Models\\User', 2, '{"attributes":{"customer.name":"RDC","date":"2024-01-17","time":"03:30","room.name":"AQUA BED 1","total_amount":0,"dp":0,"dp_payment_method":null,"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:38:01', '2024-01-17 05:38:01'),
	(202, 'Sales', 'created', 'App\\Models\\Sale', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"branch_id":1,"booking_id":5,"service_id":1,"service":"AQUA HEAD SPA","amount":500,"add_on":0,"duo":0,"therapists":"[3]"}}', NULL, '2024-01-17 05:38:01', '2024-01-17 05:38:01'),
	(203, 'Booking', 'updated', 'App\\Models\\Booking', 'updated', 5, 'App\\Models\\User', 2, '{"attributes":{"total_amount":500,"fp":0,"status":"Pending"},"old":{"total_amount":0,"fp":null,"status":null}}', NULL, '2024-01-17 05:38:01', '2024-01-17 05:38:01'),
	(204, 'Booking', 'updated', 'App\\Models\\Booking', 'updated', 5, 'App\\Models\\User', 2, '{"attributes":{"fp":500,"fp_payment_method":"Cash","status":"Completed"},"old":{"fp":0,"fp_payment_method":null,"status":"Pending"}}', NULL, '2024-01-17 05:38:09', '2024-01-17 05:38:09'),
	(205, 'Commission', 'created', 'App\\Models\\Commission', 'created', 1, 'App\\Models\\User', 2, '{"attributes":{"therapist.name":"TP3","service":"AQUA HEAD SPA","amount":500,"commission":150}}', NULL, '2024-01-17 05:38:09', '2024-01-17 05:38:09');

-- Dumping structure for table yasumi_api.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` varchar(255) NOT NULL,
  `branch_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `room_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_no` varchar(255) NOT NULL,
  `total_amount` double NOT NULL,
  `dp` double NOT NULL DEFAULT 0,
  `dp_payment_method` varchar(255) DEFAULT NULL,
  `fp` double NOT NULL DEFAULT 0,
  `fp_payment_method` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.bookings: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.branches
CREATE TABLE IF NOT EXISTS `branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `address` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.branches: ~1 rows (approximately)
INSERT INTO `branches` (`id`, `name`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'MAIN BRANCH', 'MATINA', 1, '2024-01-16 17:30:03', '2024-01-16 17:30:03');

-- Dumping structure for table yasumi_api.branch_accesses
CREATE TABLE IF NOT EXISTS `branch_accesses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.branch_accesses: ~2 rows (approximately)
INSERT INTO `branch_accesses` (`id`, `user_id`, `branch_id`, `created_at`, `updated_at`) VALUES
	(1, 2, 1, '2024-01-16 17:30:20', '2024-01-16 17:30:20'),
	(2, 3, 1, '2024-01-16 17:30:29', '2024-01-16 17:30:29');

-- Dumping structure for table yasumi_api.commissions
CREATE TABLE IF NOT EXISTS `commissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `sale_id` bigint(20) NOT NULL,
  `therapist_id` bigint(20) NOT NULL,
  `service` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `commission` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.commissions: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_no` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.customers: ~1 rows (approximately)
INSERT INTO `customers` (`id`, `branch_id`, `email`, `name`, `contact_no`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 'RDC@GMAIL.COM', 'RDC', '09190080591', NULL, '2024-01-16 18:07:01', '2024-01-16 18:07:01');

-- Dumping structure for table yasumi_api.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `absent` double NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.employees: ~2 rows (approximately)
INSERT INTO `employees` (`id`, `branch_id`, `name`, `rate`, `absent`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 1, 'EMP1', 500, 0, 1, '2024-01-16 18:06:02', '2024-01-16 18:06:02'),
	(2, 1, 'EMP2', 550, 0, 1, '2024-01-16 18:06:06', '2024-01-16 18:06:06');

-- Dumping structure for table yasumi_api.expenses
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `particulars` varchar(255) NOT NULL,
  `payee` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense_category` varchar(255) NOT NULL,
  `petty_cash` tinyint(1) NOT NULL DEFAULT 0,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.expenses: ~2 rows (approximately)
INSERT INTO `expenses` (`id`, `branch_id`, `date`, `particulars`, `payee`, `amount`, `expense_category`, `petty_cash`, `cancelled`, `created_at`, `updated_at`) VALUES
	(1, 1, '2024-01-17', 'TEST', 'TEST', 100, 'MARKETING EXP', 0, 0, '2024-01-17 05:25:15', '2024-01-17 05:25:15'),
	(2, 1, '2024-01-17', 'TEST 1', 'TEST 1', 123, 'MARKETING EXP', 0, 0, '2024-01-17 05:25:23', '2024-01-17 05:25:23');

-- Dumping structure for table yasumi_api.expense_categories
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.expense_categories: ~27 rows (approximately)
INSERT INTO `expense_categories` (`id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'MARKETING EXP', 1, '2024-01-16 17:28:02', '2024-01-16 17:28:02'),
	(2, 'OFFICE SUPPLIES & EQUIP.', 1, '2024-01-16 17:28:08', '2024-01-16 17:28:08'),
	(3, 'SPA SUPPLIES', 1, '2024-01-16 17:28:12', '2024-01-16 17:28:12'),
	(4, 'SPA TOOLS AND DECOR', 1, '2024-01-16 17:28:15', '2024-01-16 17:28:15'),
	(5, 'SPA FURNITURES & EQUIP.', 1, '2024-01-16 17:28:18', '2024-01-16 17:28:18'),
	(6, 'KITCHEN UTILITY', 1, '2024-01-16 17:28:22', '2024-01-16 17:28:22'),
	(7, 'TOILET & CLEANING SUPPLIES', 1, '2024-01-16 17:28:25', '2024-01-16 17:28:25'),
	(8, 'RENT', 1, '2024-01-16 17:28:29', '2024-01-16 17:28:29'),
	(9, 'MAINTENANCE AND REPAIR', 1, '2024-01-16 17:28:32', '2024-01-16 17:28:32'),
	(10, 'SALARIES AND WAGES', 1, '2024-01-16 17:28:38', '2024-01-16 17:28:38'),
	(11, 'UTILITY-LIGHT', 1, '2024-01-16 17:28:42', '2024-01-16 17:28:42'),
	(12, 'UTILITY-WATER', 1, '2024-01-16 17:28:45', '2024-01-16 17:28:45'),
	(13, 'TELECOMMUNICATIONS', 1, '2024-01-16 17:28:49', '2024-01-16 17:28:49'),
	(14, 'TRAININGS & SEMINAR', 1, '2024-01-16 17:28:52', '2024-01-16 17:28:52'),
	(15, 'LEGAL EXP', 1, '2024-01-16 17:28:55', '2024-01-16 17:28:55'),
	(16, 'RETAINERS FEE', 1, '2024-01-16 17:28:58', '2024-01-16 17:28:58'),
	(17, 'DEBTS', 1, '2024-01-16 17:29:02', '2024-01-16 17:29:02'),
	(18, 'EMPLOYEES PERKS', 1, '2024-01-16 17:29:05', '2024-01-16 17:29:05'),
	(19, 'UNIFORM', 1, '2024-01-16 17:29:09', '2024-01-16 17:29:09'),
	(20, 'PURIFIED WATER', 1, '2024-01-16 17:29:14', '2024-01-16 17:29:14'),
	(21, 'LAUNDRY', 1, '2024-01-16 17:29:17', '2024-01-16 17:29:17'),
	(22, 'PERSONAL DRAWING', 1, '2024-01-16 17:29:21', '2024-01-16 17:29:21'),
	(23, 'MEAL EXP', 1, '2024-01-16 17:29:24', '2024-01-16 17:29:24'),
	(24, 'FREIGHT', 1, '2024-01-16 17:29:27', '2024-01-16 17:29:27'),
	(25, 'TRAVEL EXP', 1, '2024-01-16 17:29:31', '2024-01-16 17:29:31'),
	(26, 'TAXES & LICENSES', 1, '2024-01-16 17:29:36', '2024-01-16 17:29:36'),
	(27, 'CASH ADVANCES', 1, '2024-01-16 17:29:39', '2024-01-16 17:29:39');

-- Dumping structure for table yasumi_api.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `stock` bigint(20) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.items: ~21 rows (approximately)
INSERT INTO `items` (`id`, `branch_id`, `name`, `unit`, `stock`, `created_at`, `updated_at`) VALUES
	(1, 1, 'FOOT SOAK', '20ml', 0, '2024-01-16 17:33:56', '2024-01-16 17:33:56'),
	(2, 1, 'SHAMPOO', '60ml', 0, '2024-01-16 17:34:20', '2024-01-16 17:34:20'),
	(3, 1, 'HAIR TREATMENT', '40ml', 0, '2024-01-16 17:34:28', '2024-01-16 17:34:28'),
	(4, 1, 'EYE STEAM MASK', '1PC', 0, '2024-01-16 17:34:50', '2024-01-16 17:35:06'),
	(5, 1, 'ICE COLD GEL (1ml)', '1ml', 0, '2024-01-16 17:35:15', '2024-01-16 17:50:59'),
	(6, 1, 'MASSAGE OIL (40ml)', '40ml', 0, '2024-01-16 17:36:41', '2024-01-16 17:36:41'),
	(7, 1, 'MASSAGE OIL (60ml)', '60ml', 0, '2024-01-16 17:36:50', '2024-01-16 17:36:50'),
	(8, 1, 'PEPPERMINT OIL', '50ml', 0, '2024-01-16 17:36:59', '2024-01-16 17:36:59'),
	(9, 1, 'LAVANDER OIL', '50ml', 0, '2024-01-16 17:37:09', '2024-01-16 17:37:09'),
	(10, 1, 'SWEET ORANGE OIL', '50ml', 0, '2024-01-16 17:37:15', '2024-01-16 17:37:15'),
	(11, 1, 'EUCALYPTUS OIL', '50ml', 0, '2024-01-16 17:37:22', '2024-01-16 17:37:22'),
	(12, 1, 'CITRONELLA OIL', '50ml', 0, '2024-01-16 17:37:28', '2024-01-16 17:37:28'),
	(13, 1, 'FOOT LOTION (10ml)', '10ml', 0, '2024-01-16 17:37:38', '2024-01-16 17:51:55'),
	(14, 1, 'PILLOW SHEET', '1PC', 0, '2024-01-16 17:38:53', '2024-01-16 17:38:53'),
	(15, 1, 'ALOE GEL', '1PC', 0, '2024-01-16 17:40:15', '2024-01-16 17:40:15'),
	(16, 1, 'FACE SERUM', '1PC', 0, '2024-01-16 17:40:24', '2024-01-16 17:40:24'),
	(17, 1, 'FACIAL MASK', '1PC', 0, '2024-01-16 17:40:56', '2024-01-16 17:40:56'),
	(18, 1, 'MASSAGE OIL (50ml)', '50ml', 0, '2024-01-16 17:42:33', '2024-01-16 17:42:33'),
	(19, 1, 'MASSAGE OIL (25ml)', '25ml', 0, '2024-01-16 17:42:42', '2024-01-16 17:42:42'),
	(20, 1, 'ICE COLD GEL (5ml)', '5ml', 0, '2024-01-16 17:51:12', '2024-01-16 17:51:12'),
	(21, 1, 'FOOT LOTION (20ml)', '20ml', 0, '2024-01-16 17:52:01', '2024-01-16 17:52:01');

-- Dumping structure for table yasumi_api.item_consumptions
CREATE TABLE IF NOT EXISTS `item_consumptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `qty` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.item_consumptions: ~93 rows (approximately)
INSERT INTO `item_consumptions` (`id`, `service_id`, `item_id`, `qty`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, '2024-01-16 17:39:05', '2024-01-16 17:39:05'),
	(2, 1, 2, 1, '2024-01-16 17:39:11', '2024-01-16 17:39:11'),
	(3, 1, 3, 1, '2024-01-16 17:39:15', '2024-01-16 17:39:15'),
	(4, 1, 4, 1, '2024-01-16 17:39:21', '2024-01-16 17:39:21'),
	(5, 1, 5, 1, '2024-01-16 17:39:28', '2024-01-16 17:39:28'),
	(6, 2, 1, 1, '2024-01-16 17:39:50', '2024-01-16 17:39:50'),
	(7, 2, 2, 1, '2024-01-16 17:39:52', '2024-01-16 17:39:52'),
	(8, 2, 3, 1, '2024-01-16 17:39:57', '2024-01-16 17:39:57'),
	(9, 2, 15, 1, '2024-01-16 17:40:36', '2024-01-16 17:40:36'),
	(10, 2, 17, 1, '2024-01-16 17:41:07', '2024-01-16 17:41:07'),
	(11, 2, 16, 1, '2024-01-16 17:41:12', '2024-01-16 17:41:12'),
	(12, 2, 4, 1, '2024-01-16 17:41:17', '2024-01-16 17:41:17'),
	(13, 2, 5, 1, '2024-01-16 17:41:22', '2024-01-16 17:41:22'),
	(14, 3, 1, 1, '2024-01-16 17:41:46', '2024-01-16 17:41:46'),
	(15, 3, 2, 1, '2024-01-16 17:41:49', '2024-01-16 17:41:49'),
	(16, 3, 3, 1, '2024-01-16 17:41:53', '2024-01-16 17:41:53'),
	(17, 3, 4, 1, '2024-01-16 17:42:00', '2024-01-16 17:42:00'),
	(18, 3, 18, 1, '2024-01-16 17:43:03', '2024-01-16 17:43:03'),
	(19, 3, 5, 1, '2024-01-16 17:43:11', '2024-01-16 17:43:11'),
	(20, 4, 1, 1, '2024-01-16 17:43:35', '2024-01-16 17:43:35'),
	(21, 4, 2, 1, '2024-01-16 17:43:41', '2024-01-16 17:43:41'),
	(22, 4, 3, 1, '2024-01-16 17:43:47', '2024-01-16 17:43:47'),
	(23, 4, 4, 1, '2024-01-16 17:43:53', '2024-01-16 17:43:53'),
	(24, 4, 19, 1, '2024-01-16 17:43:58', '2024-01-16 17:43:58'),
	(25, 4, 5, 1, '2024-01-16 17:44:04', '2024-01-16 17:44:04'),
	(26, 5, 1, 1, '2024-01-16 17:44:32', '2024-01-16 17:44:32'),
	(27, 5, 14, 1, '2024-01-16 17:44:50', '2024-01-16 17:44:50'),
	(28, 6, 1, 1, '2024-01-16 17:45:06', '2024-01-16 17:45:06'),
	(29, 6, 18, 1, '2024-01-16 17:45:16', '2024-01-16 17:45:16'),
	(30, 6, 14, 1, '2024-01-16 17:45:22', '2024-01-16 17:45:22'),
	(31, 7, 1, 1, '2024-01-16 17:45:55', '2024-01-16 17:45:55'),
	(32, 7, 13, 1, '2024-01-16 17:46:09', '2024-01-16 17:46:09'),
	(33, 8, 1, 1, '2024-01-16 17:46:39', '2024-01-16 17:46:39'),
	(34, 8, 2, 1, '2024-01-16 17:46:42', '2024-01-16 17:46:42'),
	(35, 8, 3, 1, '2024-01-16 17:46:47', '2024-01-16 17:46:47'),
	(36, 8, 4, 1, '2024-01-16 17:46:54', '2024-01-16 17:46:54'),
	(37, 8, 5, 1, '2024-01-16 17:46:57', '2024-01-16 17:46:57'),
	(38, 8, 6, 1, '2024-01-16 17:47:02', '2024-01-16 17:47:02'),
	(39, 8, 14, 1, '2024-01-16 17:47:07', '2024-01-16 17:47:07'),
	(40, 9, 1, 1, '2024-01-16 17:47:33', '2024-01-16 17:47:33'),
	(41, 9, 2, 1, '2024-01-16 17:47:36', '2024-01-16 17:47:36'),
	(42, 9, 3, 1, '2024-01-16 17:47:39', '2024-01-16 17:47:39'),
	(43, 9, 4, 1, '2024-01-16 17:47:44', '2024-01-16 17:47:44'),
	(44, 9, 5, 1, '2024-01-16 17:47:47', '2024-01-16 17:47:47'),
	(45, 9, 14, 1, '2024-01-16 17:47:52', '2024-01-16 17:47:52'),
	(46, 10, 1, 1, '2024-01-16 17:48:15', '2024-01-16 17:48:15'),
	(47, 10, 2, 1, '2024-01-16 17:48:18', '2024-01-16 17:48:18'),
	(48, 10, 3, 1, '2024-01-16 17:48:21', '2024-01-16 17:48:21'),
	(49, 10, 4, 1, '2024-01-16 17:48:27', '2024-01-16 17:48:27'),
	(50, 10, 5, 1, '2024-01-16 17:48:31', '2024-01-16 17:48:31'),
	(51, 10, 13, 1, '2024-01-16 17:48:42', '2024-01-16 17:48:42'),
	(52, 11, 1, 1, '2024-01-16 17:49:01', '2024-01-16 17:49:01'),
	(53, 11, 2, 1, '2024-01-16 17:49:04', '2024-01-16 17:49:04'),
	(54, 11, 3, 1, '2024-01-16 17:49:14', '2024-01-16 17:49:14'),
	(55, 11, 4, 1, '2024-01-16 17:49:18', '2024-01-16 17:49:18'),
	(56, 11, 5, 1, '2024-01-16 17:49:25', '2024-01-16 17:49:25'),
	(57, 11, 6, 1, '2024-01-16 17:49:29', '2024-01-16 17:49:29'),
	(58, 11, 14, 1, '2024-01-16 17:49:34', '2024-01-16 17:49:34'),
	(59, 12, 1, 1, '2024-01-16 17:50:03', '2024-01-16 17:50:03'),
	(60, 12, 20, 1, '2024-01-16 17:51:20', '2024-01-16 17:51:20'),
	(61, 12, 18, 1, '2024-01-16 17:51:27', '2024-01-16 17:51:27'),
	(62, 12, 21, 1, '2024-01-16 17:52:09', '2024-01-16 17:52:09'),
	(63, 12, 21, 1, '2024-01-16 17:52:22', '2024-01-16 17:52:22'),
	(64, 13, 1, 1, '2024-01-16 17:52:46', '2024-01-16 17:52:46'),
	(65, 13, 20, 1, '2024-01-16 17:52:52', '2024-01-16 17:52:52'),
	(66, 13, 21, 1, '2024-01-16 17:53:00', '2024-01-16 17:53:00'),
	(67, 13, 14, 1, '2024-01-16 17:53:07', '2024-01-16 17:53:07'),
	(68, 14, 1, 1, '2024-01-16 17:53:32', '2024-01-16 17:53:32'),
	(69, 14, 20, 1, '2024-01-16 17:53:37', '2024-01-16 17:53:37'),
	(70, 14, 18, 1, '2024-01-16 17:53:43', '2024-01-16 17:53:43'),
	(71, 14, 21, 1, '2024-01-16 17:53:49', '2024-01-16 17:53:49'),
	(72, 14, 14, 1, '2024-01-16 17:53:53', '2024-01-16 17:53:53'),
	(73, 15, 1, 1, '2024-01-16 17:54:13', '2024-01-16 17:54:13'),
	(74, 15, 20, 1, '2024-01-16 17:54:18', '2024-01-16 17:54:18'),
	(75, 15, 18, 1, '2024-01-16 17:54:22', '2024-01-16 17:54:22'),
	(76, 15, 14, 1, '2024-01-16 17:54:28', '2024-01-16 17:54:28'),
	(77, 16, 1, 1, '2024-01-16 17:54:50', '2024-01-16 17:54:50'),
	(78, 16, 20, 1, '2024-01-16 17:54:54', '2024-01-16 17:54:54'),
	(79, 16, 18, 1, '2024-01-16 17:54:58', '2024-01-16 17:54:58'),
	(80, 16, 14, 1, '2024-01-16 17:55:01', '2024-01-16 17:55:01'),
	(81, 17, 1, 1, '2024-01-16 17:55:17', '2024-01-16 17:55:17'),
	(82, 17, 20, 1, '2024-01-16 17:55:22', '2024-01-16 17:55:22'),
	(83, 17, 18, 1, '2024-01-16 17:55:28', '2024-01-16 17:55:28'),
	(84, 17, 14, 1, '2024-01-16 17:55:32', '2024-01-16 17:55:32'),
	(85, 18, 8, 1, '2024-01-16 17:56:03', '2024-01-16 17:56:03'),
	(86, 19, 9, 1, '2024-01-16 17:56:22', '2024-01-16 17:56:22'),
	(87, 20, 10, 1, '2024-01-16 17:56:38', '2024-01-16 17:56:38'),
	(88, 21, 11, 1, '2024-01-16 17:56:57', '2024-01-16 17:56:57'),
	(89, 22, 12, 1, '2024-01-16 17:57:11', '2024-01-16 17:57:11'),
	(90, 23, 1, 1, '2024-01-16 17:58:33', '2024-01-16 17:58:33'),
	(91, 23, 13, 1, '2024-01-16 17:58:44', '2024-01-16 17:58:44'),
	(92, 24, 1, 1, '2024-01-16 17:58:50', '2024-01-16 17:58:50'),
	(93, 24, 20, 1, '2024-01-16 17:58:58', '2024-01-16 17:58:58');

-- Dumping structure for table yasumi_api.item_stocks
CREATE TABLE IF NOT EXISTS `item_stocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `qty` bigint(20) NOT NULL DEFAULT 0,
  `event` varchar(255) NOT NULL DEFAULT 'Void',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.item_stocks: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.migrations: ~26 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2023_11_18_021458_create_branches_table', 1),
	(6, '2023_11_18_021501_create_branch_accesses_table', 1),
	(7, '2023_11_18_024423_create_expense_categories_table', 1),
	(8, '2023_11_18_071813_create_services_table', 1),
	(9, '2023_11_18_115432_create_activity_log_table', 1),
	(10, '2023_11_18_115433_add_event_column_to_activity_log_table', 1),
	(11, '2023_11_18_115434_add_batch_uuid_column_to_activity_log_table', 1),
	(12, '2023_11_18_124514_create_expenses_table', 1),
	(13, '2023_11_19_132848_create_therapists_table', 1),
	(14, '2023_11_19_141312_create_rooms_table', 1),
	(15, '2023_11_19_144926_create_bookings_table', 1),
	(16, '2023_11_19_145600_create_sales_table', 1),
	(17, '2023_11_22_104759_create_commissions_table', 1),
	(18, '2023_11_30_080934_create_refunds_table', 1),
	(19, '2023_11_30_082211_create_customers_table', 1),
	(20, '2023_11_30_111149_create_vouchers_table', 1),
	(21, '2023_11_30_134118_create_employees_table', 1),
	(22, '2023_11_30_140859_create_pay_periods_table', 1),
	(23, '2023_11_30_140902_create_payrolls_table', 1),
	(24, '2023_12_14_135629_create_items_table', 1),
	(25, '2024_01_11_135710_create_item_stocks_table', 1),
	(26, '2024_01_17_003900_create_item_consumptions_table', 1);

-- Dumping structure for table yasumi_api.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.payrolls
CREATE TABLE IF NOT EXISTS `payrolls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pay_period_id` bigint(20) NOT NULL,
  `employee_type` varchar(255) NOT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `therapist_id` bigint(20) DEFAULT NULL,
  `absent` double NOT NULL DEFAULT 0,
  `net_pay` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.payrolls: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.pay_periods
CREATE TABLE IF NOT EXISTS `pay_periods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.pay_periods: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.personal_access_tokens: ~2 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 1, 'Admin', 'b0414c1bf4a3721cebe68393bb78799c4c7a5287e6a3646143477d608e622fc4', '["*"]', '2024-01-16 17:30:34', NULL, '2024-01-16 17:25:50', '2024-01-16 17:30:34'),
	(4, 'App\\Models\\User', 2, 'Admin', '2b96daa461b246442ad83acd695b9b0001e45d747b5cacafd9ae35406b4f3c3b', '["*"]', '2024-01-17 05:39:55', NULL, '2024-01-16 18:04:48', '2024-01-17 05:39:55');

-- Dumping structure for table yasumi_api.refunds
CREATE TABLE IF NOT EXISTS `refunds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `date` date NOT NULL,
  `service` varchar(255) NOT NULL,
  `pax` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `amount_refund` double NOT NULL,
  `reason` longtext NOT NULL,
  `cancelled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.refunds: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.rooms: ~10 rows (approximately)
INSERT INTO `rooms` (`id`, `branch_id`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 1, 'AQUA BED 1', 1, '2024-01-16 17:32:18', '2024-01-16 17:32:18'),
	(2, 1, 'AQUA BED 2', 1, '2024-01-16 17:32:20', '2024-01-16 17:32:20'),
	(3, 1, 'AQUA BED 3', 1, '2024-01-16 17:32:23', '2024-01-16 17:32:23'),
	(4, 1, 'BED 4', 1, '2024-01-16 17:32:27', '2024-01-16 17:32:27'),
	(5, 1, 'BED 5', 1, '2024-01-16 17:32:30', '2024-01-16 17:32:30'),
	(6, 1, 'BED 6', 1, '2024-01-16 17:32:33', '2024-01-16 17:32:33'),
	(7, 1, 'BED              7', 1, '2024-01-16 17:32:36', '2024-01-16 17:32:36'),
	(8, 1, 'MASSAGE CHAIR 1', 1, '2024-01-16 17:33:00', '2024-01-16 17:33:00'),
	(9, 1, 'MASSAGE CHAIR 2', 1, '2024-01-16 17:33:02', '2024-01-16 17:33:02'),
	(10, 1, 'MASSAGE CHAIR 3', 1, '2024-01-16 17:33:07', '2024-01-16 17:33:07');

-- Dumping structure for table yasumi_api.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `booking_id` bigint(20) NOT NULL,
  `service_id` bigint(20) DEFAULT NULL,
  `service` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `add_on` tinyint(1) NOT NULL DEFAULT 0,
  `duo` tinyint(1) NOT NULL DEFAULT 0,
  `therapists` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.sales: ~0 rows (approximately)

-- Dumping structure for table yasumi_api.services
CREATE TABLE IF NOT EXISTS `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `add_on` tinyint(1) NOT NULL DEFAULT 0,
  `duo` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.services: ~24 rows (approximately)
INSERT INTO `services` (`id`, `branch_id`, `name`, `amount`, `add_on`, `duo`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 1, 'AQUA HEAD SPA', 500, 0, 0, 1, '2024-01-16 17:38:45', '2024-01-16 18:07:18'),
	(2, 1, 'VIP AQUA HEAD SPA', 1000, 0, 0, 1, '2024-01-16 17:39:41', '2024-01-16 18:07:23'),
	(3, 1, 'VVIP AQUA HEAD SPA', 0, 0, 0, 1, '2024-01-16 17:41:40', '2024-01-16 17:41:40'),
	(4, 1, 'SUPREME DUO', 750, 0, 1, 1, '2024-01-16 17:43:28', '2024-01-16 18:07:34'),
	(5, 1, 'THAI MASSAGE', 0, 0, 0, 1, '2024-01-16 17:44:22', '2024-01-16 17:44:22'),
	(6, 1, 'SWEDISH', 0, 0, 0, 1, '2024-01-16 17:45:01', '2024-01-16 17:45:01'),
	(7, 1, 'FOOT MASSAGE', 0, 0, 0, 1, '2024-01-16 17:45:39', '2024-01-16 17:45:39'),
	(8, 1, 'COMBO 1 (HEAD SPA + SWEDISH)', 0, 0, 0, 1, '2024-01-16 17:46:31', '2024-01-16 17:46:31'),
	(9, 1, 'COMBO 2 (HEAD SPA + THAI)', 0, 0, 0, 1, '2024-01-16 17:47:25', '2024-01-16 17:47:25'),
	(10, 1, 'COMBO 3 (HEAD SPA + FOOT)', 0, 0, 0, 1, '2024-01-16 17:48:09', '2024-01-16 17:48:09'),
	(11, 1, 'COMBO 4 (HEAD SPA + BACK)', 0, 0, 0, 1, '2024-01-16 17:48:55', '2024-01-16 17:48:55'),
	(12, 1, 'COMBO 5 (SWEDISH + FOOT)', 0, 0, 0, 1, '2024-01-16 17:49:51', '2024-01-16 17:49:51'),
	(13, 1, 'COMBO 6 (THAI + FOOT)', 0, 0, 0, 1, '2024-01-16 17:52:41', '2024-01-16 17:52:41'),
	(14, 1, 'COMBO 7 (BACK + FOOT)', 0, 0, 0, 1, '2024-01-16 17:53:23', '2024-01-16 17:53:23'),
	(15, 1, 'COMBO 8 (THAI + BACK)', 0, 0, 0, 1, '2024-01-16 17:54:06', '2024-01-16 17:54:06'),
	(16, 1, 'COMBO 9 (SWEDISH +BACK)', 0, 0, 0, 1, '2024-01-16 17:54:43', '2024-01-16 17:54:43'),
	(17, 1, 'COMBO 10 (SWEDISH + THAI)', 0, 0, 0, 1, '2024-01-16 17:55:11', '2024-01-16 17:55:11'),
	(18, 1, 'PEPPERMINT OIL', 0, 1, 0, 1, '2024-01-16 17:55:45', '2024-01-16 17:55:45'),
	(19, 1, 'LAVANDER OIL', 0, 1, 0, 1, '2024-01-16 17:56:14', '2024-01-16 17:56:14'),
	(20, 1, 'SWEET ORANGE OIL', 0, 1, 0, 1, '2024-01-16 17:56:31', '2024-01-16 17:56:31'),
	(21, 1, 'EUCALYPTUS OIL', 0, 1, 0, 1, '2024-01-16 17:56:45', '2024-01-16 17:56:45'),
	(22, 1, 'CITRONELLA OIL', 0, 1, 0, 1, '2024-01-16 17:57:04', '2024-01-16 17:57:04'),
	(23, 1, 'EXPRESS MASSAGE (Foot)', 0, 0, 0, 1, '2024-01-16 17:58:16', '2024-01-16 17:58:16'),
	(24, 1, 'EXPRESS MASSAGE (Head)', 0, 0, 0, 1, '2024-01-16 17:58:26', '2024-01-16 17:58:26');

-- Dumping structure for table yasumi_api.therapists
CREATE TABLE IF NOT EXISTS `therapists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `commission` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.therapists: ~5 rows (approximately)
INSERT INTO `therapists` (`id`, `branch_id`, `name`, `commission`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 1, 'TP1', 10, 1, '2024-01-16 18:05:30', '2024-01-16 18:05:30'),
	(2, 1, 'TP2', 20, 1, '2024-01-16 18:05:33', '2024-01-16 18:05:33'),
	(3, 1, 'TP3', 30, 1, '2024-01-16 18:05:39', '2024-01-16 18:05:39'),
	(4, 1, 'TP4', 40, 1, '2024-01-16 18:05:44', '2024-01-16 18:05:44'),
	(5, 1, 'TP5', 50, 1, '2024-01-16 18:05:48', '2024-01-16 18:05:54');

-- Dumping structure for table yasumi_api.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `portal` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.users: ~3 rows (approximately)
INSERT INTO `users` (`id`, `name`, `username`, `password`, `role`, `portal`, `is_active`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Admin', 'Admin', '$2y$12$cEaf0sGFNsBnvo9kuvjDTOQsXD3h3yDPWEOZliJFwtS7pj9UEoTYy', 'Admin', 'CMS', 1, NULL, '2024-01-16 17:22:02', '2024-01-16 17:22:02'),
	(2, 'Owner', 'owner', '$2y$12$ufiiyXW7eK7AEif7KUqUA.K9amnLt7Br3kARBUqMmjP/7Eo5nZigK', 'Owner', 'Branch', 1, NULL, '2024-01-16 17:30:19', '2024-01-16 17:30:19'),
	(3, 'User', 'user', '$2y$12$I1OnPjOI0TdPE233VohrkeQ2ikoi4fCfDTUtw7FR.Kgyup/x0oUha', 'Branch Admin', 'Branch', 1, NULL, '2024-01-16 17:30:29', '2024-01-16 17:30:29');

-- Dumping structure for table yasumi_api.vouchers
CREATE TABLE IF NOT EXISTS `vouchers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) DEFAULT NULL,
  `booking_id` bigint(20) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `date_used` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table yasumi_api.vouchers: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

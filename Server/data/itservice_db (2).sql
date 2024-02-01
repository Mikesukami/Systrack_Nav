-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2023 at 09:38 PM
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
-- Database: `itservice_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_claim`
--

CREATE TABLE `tbl_claim` (
  `claim_id` int(11) NOT NULL COMMENT 'รหัสเคลม',
  `claim_number` int(11) NOT NULL COMMENT 'หมายเลขเคลมลูกค้า',
  `cus_number` int(11) NOT NULL COMMENT 'รหัสลูกค้า',
  `device_number` varchar(20) NOT NULL COMMENT 'อุปกรณ์',
  `address_number` int(11) NOT NULL COMMENT 'หมายเลขที่อยู่',
  `report_u_id` int(11) NOT NULL COMMENT 'ผู้แจ้งเคลม',
  `worker` varchar(64) NOT NULL COMMENT 'ผู้รับผิดชอบเคลม',
  `claim_detail` varchar(100) NOT NULL COMMENT 'สาเหตุการเคลม',
  `claim_result` varchar(64) NOT NULL COMMENT 'ผลการตรวจเช็ค',
  `claim_date` date NOT NULL COMMENT 'วันที่เริ่มแจ้งเคลม',
  `claim_time` time NOT NULL COMMENT 'เวลาเริ่มแจ้งเคลม',
  `claim_fix` varchar(128) NOT NULL COMMENT 'วิธีการแก้ปัญหา',
  `claim_date_end` varchar(64) NOT NULL COMMENT 'วันสิ้นสุดเคลม',
  `claim_time_end` time NOT NULL COMMENT 'เวลาสิ้นสุดการเคลม',
  `warranty` date NOT NULL COMMENT 'วันสิ้นสุดวันรับประกัน',
  `status` int(11) NOT NULL COMMENT 'สถานะการแจ้งเคลม'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_claim`
--

INSERT INTO `tbl_claim` (`claim_id`, `claim_number`, `cus_number`, `device_number`, `address_number`, `report_u_id`, `worker`, `claim_detail`, `claim_result`, `claim_date`, `claim_time`, `claim_fix`, `claim_date_end`, `claim_time_end`, `warranty`, `status`) VALUES
(1, 3623535, 1015126, '213123123123', 2790466, 0, '1', 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', '2023-10-12', '19:20:07', 'เปลี่ยนเมนบอร์ดใหม่', '2023-10-12', '21:51:06', '2024-01-10', 3),
(2, 3651507, 1015126, '213123123123', 2790466, 99, '', 'เมนบอร์ดมีปัญหา', '', '2023-10-12', '20:58:45', '', '', '00:00:00', '2024-01-10', 1),
(3, 3681447, 1024757, '094203940923', 2724757, 2, '', 'เครื่องช้า', '', '2023-10-13', '09:35:30', '', '', '00:00:00', '2024-01-10', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer`
--

CREATE TABLE `tbl_customer` (
  `cus_id` int(11) NOT NULL,
  `cus_number` int(11) NOT NULL COMMENT 'รหัสลูกค้า',
  `cus_name` varchar(64) NOT NULL COMMENT 'ชื่อลูกค้า',
  `cus_lastname` varchar(64) NOT NULL COMMENT 'นามสกุลลูกค้า',
  `cus_tel` varchar(64) NOT NULL COMMENT 'เบอร์โทรลูกค้า'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_customer`
--

INSERT INTO `tbl_customer` (`cus_id`, `cus_number`, `cus_name`, `cus_lastname`, `cus_tel`) VALUES
(1, 1052708, 'ณัฐวุฒิ', 'คงปาน', '0984531332'),
(2, 1036969, 'ธันวา', 'บูรณานัด', '0921241231'),
(3, 1031460, 'วิศรุต', 'เกิดปานทอง', '0923812312'),
(5, 1015126, 'พิธา', 'ลิ้มเจริญรัตน์', '0942542123'),
(6, 1010691, 'นครินทร์', 'คงปาน', '0949234823'),
(8, 1074610, 'วีรยุทธ', 'แซ่สิ้ม', '0945959388'),
(9, 1015443, 'ภาณุพงค์', 'แก้วนวล', '0947284372'),
(10, 1024757, 'ปฏิภาณ', 'เหล็กหมาด', '0931231231'),
(11, 1019814, 'ชนม์ปิยะ', 'คงมณี', '0874488484');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer_address`
--

CREATE TABLE `tbl_customer_address` (
  `address_id` int(11) NOT NULL COMMENT 'รหัสที่อยู่',
  `cus_number` varchar(11) NOT NULL COMMENT 'หมายเลขลูกค้า',
  `address_number` int(11) NOT NULL COMMENT 'หมายเลขที่อยู่',
  `home_number` varchar(11) NOT NULL COMMENT 'บ้านเลขที่',
  `village` varchar(11) NOT NULL COMMENT 'หมู่ที่',
  `alley` varchar(64) NOT NULL COMMENT 'ซอย',
  `road` varchar(64) NOT NULL COMMENT 'ถนน',
  `zip` varchar(11) NOT NULL COMMENT 'รหัสไปรษณีย์',
  `province` varchar(64) NOT NULL COMMENT 'จังหวัด',
  `district` varchar(64) NOT NULL COMMENT 'อำเภอ',
  `subdistrict` varchar(64) NOT NULL COMMENT 'ตำบล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_customer_address`
--

INSERT INTO `tbl_customer_address` (`address_id`, `cus_number`, `address_number`, `home_number`, `village`, `alley`, `road`, `zip`, `province`, `district`, `subdistrict`) VALUES
(1, '1015126', 2790466, '25/1', '1', '', '', '90310', 'สงขลา', 'นาหม่อม', 'นาหม่อม'),
(2, '1015126', 2772524, '90/1', '2', '3', '', '90000', 'สงขลา', 'เมืองสงขลา', 'บ่อยาง'),
(3, '1015126', 2746394, '251/3', '1', '3', '', '90110', 'สงขลา', 'หาดใหญ่	', 'หาดใหญ่'),
(4, '1010691', 2724641, '299', '1', '', '', '90110', 'สงขลา', 'หาดใหญ่	', 'หาดใหญ่'),
(6, '1074610', 2774610, '90/1', '1', '', '', '90110', 'สงขลา', 'หาดใหญ่	', 'หาดใหญ่'),
(7, '7750614', 2738384, '', '', '', '', '', 'สงขลา', '', ''),
(8, '1015443', 2715443, '25/1', '1', '', '', '90110', 'สงขลา', 'หาดใหญ่	', 'น้ำน้อย'),
(9, '1052708', 2770184, '87/1', '1', '1', '', '90000', 'สงขลา', 'เมืองสงขลา', 'เขารูปช้าง'),
(10, '1031460', 2751260, '55', '', '', '', '90110', 'สงขลา', 'หาดใหญ่	', 'หาดใหญ่'),
(11, '1031460', 2715566, '', '', '', '', '', 'สงขลา', '', ''),
(12, '1024757', 2724757, '25', '', '', '', '90110', 'สงขลา', 'หาดใหญ่	', 'คลองแห	'),
(13, '1019814', 2719814, '87/1', '', '', '', '90310', 'สงขลา', 'นาหม่อม', 'นาหม่อม');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_device`
--

CREATE TABLE `tbl_device` (
  `device_id` int(11) NOT NULL,
  `cus_number` varchar(20) NOT NULL COMMENT 'หมายเลขลูกค้า',
  `device_number` varchar(32) NOT NULL COMMENT 'หมายเลขเครื่อง',
  `device_types` int(11) NOT NULL COMMENT 'ประเภทอุปกรณ์',
  `device_brand` varchar(32) NOT NULL COMMENT 'ยี่ห้อ',
  `device_model` varchar(32) NOT NULL COMMENT 'รุ่น',
  `device_password` varchar(32) NOT NULL COMMENT 'รหัสผ่านเข้าเครื่อง'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_device`
--

INSERT INTO `tbl_device` (`device_id`, `cus_number`, `device_number`, `device_types`, `device_brand`, `device_model`, `device_password`) VALUES
(1, '1015126', '213123123123', 1, '2', 'TUF GAMING', '12345'),
(2, '1015126', '39ru2939r293', 2, '8', 'TUF GAMING', '12345'),
(3, '1015126', '931923912391', 3, '15', 'G2010', ''),
(4, '1024757', '312039012309', 2, '7', 'Swift 3 ', ''),
(5, '1024757', '511435523145', 1, '3', 'OPTIFLEX 2050', 'foloj70732'),
(6, '1024757', '045902390590', 1, '1', 'Nitro 5', ''),
(7, '1024757', '931023010000', 1, '4', 'N265', ''),
(8, '1024757', '094203940923', 1, '2', 'Nitro 5', ''),
(9, '1019814', '312435124535', 2, '8', 'TUF GAMING', '12345'),
(10, '1015126', '821398918938', 2, '8', 'TUF GAMING', '00500783'),
(11, '1052708', '039429040902', 1, '2', 'TUF GAMING', '12345'),
(12, '1024757', '312312312312', 2, '7', 'Swift 3', '12345'),
(13, '1015126', '311251351123', 2, '8', 'TUF GAMING', '12345'),
(14, '1015126', '312312312312', 1, '2', 'TUF GAMING', '12345'),
(15, '1015126', '125478191919', 2, '7', 'NIRTO 5', '12345'),
(16, '1015126', '123456789101', 1, '2', 'TUF GAMING', '12345'),
(17, '1015126', 'GNB154796512', 3, '15', 'MP287', '12345'),
(18, '1015126', '512135121351', 1, '2', 'TUF GAMING', '12345'),
(19, '1015126', '543511235115', 2, '8', 'TUF GAMING', '90301'),
(20, '1024757', '099997767676', 2, '7', 'Nitro 5', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_device_brand`
--

CREATE TABLE `tbl_device_brand` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(64) NOT NULL COMMENT 'ชื่อแบรนด์',
  `device_type_id` int(11) NOT NULL COMMENT 'ประเภทอุปกรณ์'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_device_brand`
--

INSERT INTO `tbl_device_brand` (`brand_id`, `brand_name`, `device_type_id`) VALUES
(1, 'ACER', 1),
(2, 'ASUS', 1),
(3, 'DELL', 1),
(4, 'HP', 1),
(5, 'LENOVO', 1),
(6, 'MSI', 1),
(7, 'ACER', 2),
(8, 'ASUS', 2),
(9, 'DELL', 2),
(10, 'HP', 2),
(11, 'LENOVO', 2),
(12, 'MICROSOFT', 2),
(13, 'MSI', 2),
(14, 'BROTHER', 3),
(15, 'CANON', 3),
(16, 'EPSON', 3),
(17, 'HP', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_device_types`
--

CREATE TABLE `tbl_device_types` (
  `device_type_id` int(11) NOT NULL COMMENT 'รหัสอุปกรณ์',
  `device_type_name` varchar(64) NOT NULL COMMENT 'ชื่ออุปกรณ์'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_device_types`
--

INSERT INTO `tbl_device_types` (`device_type_id`, `device_type_name`) VALUES
(1, 'Computer PC\r\n'),
(2, 'Laptop'),
(3, 'Printer');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_district`
--

CREATE TABLE `tbl_district` (
  `district_id` int(11) NOT NULL,
  `district_name` varchar(64) NOT NULL COMMENT 'ชื่ออำเภอ',
  `district_code` int(11) NOT NULL COMMENT 'หมายเลขประจำอำเภอ',
  `province_id` int(11) NOT NULL COMMENT 'หมายเลขจังหวัด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_district`
--

INSERT INTO `tbl_district` (`district_id`, `district_name`, `district_code`, `province_id`) VALUES
(1, 'เมืองสงขลา', 1001, 1),
(2, 'สทิงพระ', 1002, 1),
(3, 'จะนะ', 1003, 1),
(4, 'นาทวี', 1004, 1),
(5, 'เทพา', 1005, 1),
(6, 'สะบ้าย้อย', 1006, 1),
(7, 'ระโนด', 1007, 1),
(8, 'กระแสสินธุ์', 1008, 1),
(9, 'รัตภูมิ', 1009, 1),
(10, 'สะเดา', 1010, 1),
(11, 'หาดใหญ่	', 1011, 1),
(12, 'นาหม่อม', 1012, 1),
(13, 'ควนเนียง', 1013, 1),
(14, 'บางกล่ำ', 1014, 1),
(15, 'สิงหนคร', 1015, 1),
(16, 'คลองหอยโข่ง', 1016, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_province`
--

CREATE TABLE `tbl_province` (
  `province_id` int(11) NOT NULL COMMENT 'รหัสจังหวัด',
  `province_name` varchar(64) NOT NULL COMMENT 'ชื่อจังหวัด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_province`
--

INSERT INTO `tbl_province` (`province_id`, `province_name`) VALUES
(1, 'สงขลา');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_repair`
--

CREATE TABLE `tbl_repair` (
  `repair_id` int(11) NOT NULL,
  `repair_number` varchar(20) NOT NULL COMMENT 'รหัสแจ้งซ่อม',
  `cus_number` int(11) NOT NULL COMMENT 'รหัสลูกค้า',
  `device_number` varchar(32) NOT NULL COMMENT 'หมายเลขอุปกรณ์',
  `address_number` int(11) NOT NULL COMMENT 'หมายเลขที่อยู่',
  `repair_detail` varchar(128) NOT NULL COMMENT 'ปัญหา/อาการเสีย',
  `repair_result` varchar(64) NOT NULL COMMENT 'ผลการตรวจเช็ค',
  `repair_fix` varchar(128) NOT NULL COMMENT 'วิธีการแก้ปัญหา',
  `repair_date` date NOT NULL COMMENT 'วัน-เดือน-ปี แจ้งซ่อม',
  `repair_time` time NOT NULL COMMENT 'เวลาแจ้งซ่อม',
  `status` int(11) NOT NULL COMMENT 'สถานะการแจ้งซ่อม',
  `report_u_id` int(11) NOT NULL COMMENT 'ผู้แจ้งซ่อม',
  `worker` varchar(64) NOT NULL COMMENT 'ผู้รับผิดชอบ',
  `repair_end` date NOT NULL COMMENT 'วันสิ้นสุดการซ่อม',
  `repair_end_time` time NOT NULL COMMENT 'เวลาสิ้นสุดของการซ่อม',
  `total_price` float NOT NULL COMMENT 'ค่าใช้จ่ายทั้งหมด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_repair`
--

INSERT INTO `tbl_repair` (`repair_id`, `repair_number`, `cus_number`, `device_number`, `address_number`, `repair_detail`, `repair_result`, `repair_fix`, `repair_date`, `repair_time`, `status`, `report_u_id`, `worker`, `repair_end`, `repair_end_time`, `total_price`) VALUES
(1, '6680917', 1015126, '213123123123', 2790466, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'เปลี่ยนเมนบอร์ดใหม่', '2023-10-12', '11:00:34', 3, 99, '7', '0000-00-00', '00:00:00', 321),
(2, '6624979', 1015126, '39ru2939r293', 2790466, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'ซ่อมแซมเมนบอร์ด', '2023-10-12', '13:58:28', 3, 99, '7', '0000-00-00', '00:00:00', 321),
(3, '6681445', 1015126, '931923912391', 2790466, 'ปริ้นไม่ได้', 'น้ำหมึกหมด', 'เติมน้ำหมึกใหม่', '2023-10-12', '16:32:55', 3, 99, '7', '0000-00-00', '00:00:00', 428),
(4, '6649141', 1024757, '312039012309', 2724757, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'เปลี่ยนเมนบอร์ดใหม่', '2023-10-12', '19:10:08', 3, 99, '2', '0000-00-00', '00:00:00', 321),
(5, '6626053', 1024757, '511435523145', 2724757, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'เปลี่ยนเมนบอร์ด', '2023-10-12', '19:42:59', 3, 99, '1', '0000-00-00', '00:00:00', 321),
(6, '6671657', 1024757, '045902390590', 2724757, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'เปลี่ยนเมนบอร์ดใหม่', '2023-10-12', '19:55:11', 3, 99, '1', '0000-00-00', '00:00:00', 321),
(7, '6610997', 1024757, '931023010000', 2724757, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'แก้ไขวงจรเมนบอร์ดใหม่จนสามารถเข้าใช้งานได้อีกครั้ง', '2023-10-12', '20:08:34', 4, 99, '1', '0000-00-00', '00:00:00', 321),
(8, '6698334', 1024757, '094203940923', 2724757, 'เปิดเครื่องไม่ติด', 'เมนบอร์ดพัง\n', 'ซ่อมได้ละ', '2023-10-12', '20:36:57', 3, 99, '2', '0000-00-00', '00:00:00', 321),
(9, '6619814', 1019814, '312435124535', 2719814, 'เปิดเครื่องไม่ติด', 'เมนบอร์ดมีปัญหา', '', '2023-10-12', '22:01:17', 2, 99, '7', '0000-00-00', '00:00:00', 0),
(10, '6654063', 1015126, '821398918938', 2790466, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', '', '2023-10-13', '05:08:37', 6, 1, '', '0000-00-00', '00:00:00', 0),
(11, '6664460', 1052708, '039429040902', 2770184, 'เปิดเครื่องไม่ติด', 'เมนบอร์ดมีปัญหา', '', '2023-10-13', '05:17:04', 6, 1, '', '0000-00-00', '00:00:00', 0),
(12, '6655370', 1024757, '312312312312', 2724757, 'เปิดเครื่องไม่ติด', 'เมนบอร์ดมีปัญหา', '', '2023-10-13', '05:21:07', 6, 1, '', '0000-00-00', '00:00:00', 0),
(13, '6646310', 1015126, '311251351123', 2790466, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '05:25:14', 1, 1, '', '0000-00-00', '00:00:00', 0),
(14, '6673366', 1015126, '312312312312', 2772524, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '05:29:09', 1, 1, '', '0000-00-00', '00:00:00', 0),
(15, '6690574', 1015126, '125478191919', 2790466, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '05:31:40', 1, 1, '', '0000-00-00', '00:00:00', 0),
(16, '6668984', 1015126, '123456789101', 2790466, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '05:37:20', 1, 1, '', '0000-00-00', '00:00:00', 0),
(17, '6630036', 1015126, 'GNB154796512', 2790466, 'สั่งปริ้นงานบนคอมไม่ได้', '', '', '2023-10-13', '05:55:51', 1, 1, '', '0000-00-00', '00:00:00', 0),
(18, '6635789', 1015126, '512135121351', 2790466, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '06:06:42', 1, 1, '', '0000-00-00', '00:00:00', 0),
(19, '6630583', 1015126, '543511235115', 2746394, 'เปิดเครื่องไม่ติด', '', '', '2023-10-13', '06:12:17', 1, 1, '', '0000-00-00', '00:00:00', 0),
(20, '6626932', 1024757, '099997767676', 2724757, 'เปิดเครื่องไม่ติด', 'เกิดจากเมนบอร์ดมีปัญหา', 'เปลี่ยนวงจรเมนบอร์ดใหม่ ', '2023-10-13', '09:27:11', 3, 1, '2', '0000-00-00', '00:00:00', 321);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_repair_detail`
--

CREATE TABLE `tbl_repair_detail` (
  `detail_id` int(11) NOT NULL,
  `repair_number` int(11) NOT NULL COMMENT 'หมายเลขแจ้งซ่อม',
  `detail` int(11) NOT NULL COMMENT 'รายละเอียดการซ่อม',
  `amount` int(11) NOT NULL COMMENT 'จำนวน',
  `price` int(11) NOT NULL COMMENT 'ราคา'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_repair_detail`
--

INSERT INTO `tbl_repair_detail` (`detail_id`, `repair_number`, `detail`, `amount`, `price`) VALUES
(1, 6680917, 1, 0, 300),
(2, 6680917, 1, 0, 300),
(3, 6680917, 1, 0, 300),
(4, 6681445, 2, 0, 400),
(5, 6624979, 1, 0, 300),
(6, 6649141, 1, 0, 300),
(7, 6649141, 1, 0, 300),
(8, 6626053, 1, 0, 300),
(9, 6671657, 1, 0, 300),
(10, 6610997, 1, 0, 300),
(11, 6698334, 1, 0, 300),
(12, 6626932, 1, 0, 300);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(32) NOT NULL COMMENT 'ตำแหน่ง'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_roles`
--

INSERT INTO `tbl_roles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'Technician'),
(3, 'Employee'),
(4, 'Manager');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_service`
--

CREATE TABLE `tbl_service` (
  `service_id` int(11) NOT NULL,
  `service_type` varchar(64) NOT NULL COMMENT 'ประเภทการบริการ',
  `service_price` int(11) NOT NULL COMMENT 'ราคา'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_service`
--

INSERT INTO `tbl_service` (`service_id`, `service_type`, `service_price`) VALUES
(1, 'ค่าบริการซ่อมคอมพิวเตอร์ - โน๊ตบุ๊ค', 300),
(2, 'ค่าบริการซ่อมเครื่องปริ้น', 400);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_spares`
--

CREATE TABLE `tbl_spares` (
  `spares_id` int(11) NOT NULL COMMENT 'รหัสอะไหล่',
  `spares_name` varchar(64) NOT NULL COMMENT 'ชื่ออะไหล่',
  `spares_type_id` int(11) NOT NULL COMMENT 'ประเภทอะไหล่',
  `price` float NOT NULL COMMENT 'ราคา',
  `stock` int(11) NOT NULL COMMENT 'จำนวน',
  `img_url` varchar(128) NOT NULL COMMENT 'รูปภาพอะไหล่'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_spares`
--

INSERT INTO `tbl_spares` (`spares_id`, `spares_name`, `spares_type_id`, `price`, `stock`, `img_url`) VALUES
(1, 'Intel CPU Core i5-13500 2.5 GHz 14C/20T LGA-1700', 1, 9590, 16, '1.jpg'),
(2, 'COLORFUL VGA iGame RTX 3060 Ti Ultra W OC G6X V2-V 8GB GDDR6X 25', 1, 12130, 20, '2.jpg'),
(24, 'AMD CPU Ryzen 7 7800X3D 4.20 Ghz 8C-16T AM5', 1, 17700, 18, '3.png'),
(31, 'ASRock VGA Intel ARC A770 Phantom Gaming D OC 8GB GDDR6 ', 4, 11000, 19, '5.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_spares_type`
--

CREATE TABLE `tbl_spares_type` (
  `spares_type_id` int(11) NOT NULL COMMENT 'รหัสประเภทอะไหล่',
  `spares_type_name` varchar(64) NOT NULL COMMENT 'ชื่อประเภทอะไหล่'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_spares_type`
--

INSERT INTO `tbl_spares_type` (`spares_type_id`, `spares_type_name`) VALUES
(1, 'CPU'),
(2, 'Mainboard'),
(3, 'Ram'),
(4, 'Graphic Card\r\n'),
(5, 'Power Supply\r\n'),
(6, 'Sound Card'),
(7, 'Cooling System');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_status`
--

CREATE TABLE `tbl_status` (
  `status_id` int(11) NOT NULL COMMENT 'ไอดีสถานะ',
  `status_name` varchar(64) NOT NULL COMMENT 'ชื่อสถานะ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_status`
--

INSERT INTO `tbl_status` (`status_id`, `status_name`) VALUES
(1, 'รอตรวจเช็คอาการเสีย'),
(2, 'กำลังดำเนินการ'),
(3, 'เสร็จสิ้น'),
(4, 'ซ่อมเสร็จสิ้น / รอลูกค้ารับเครื่อง'),
(6, 'รอมอบหมายงาน');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subdistrict`
--

CREATE TABLE `tbl_subdistrict` (
  `subdistrict_id` int(11) NOT NULL,
  `zip_code` int(11) NOT NULL COMMENT 'รหัสไบรษณีย์',
  `subdistrict_name` varchar(64) NOT NULL COMMENT 'ชื่อตำบล',
  `district_code` int(11) NOT NULL COMMENT 'หมายเลขอำเภอ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_subdistrict`
--

INSERT INTO `tbl_subdistrict` (`subdistrict_id`, `zip_code`, `subdistrict_name`, `district_code`) VALUES
(1, 90000, 'บ่อยาง', 1001),
(2, 90000, 'เขารูปช้าง', 1001),
(3, 90000, 'เกาะแต้ว', 1001),
(4, 90100, 'พะวง', 1001),
(5, 90000, 'ทุ่งหวัง', 1001),
(6, 90100, 'เกาะยอ	', 1001),
(7, 90190, 'จะทิ้งพระ', 1002),
(8, 90190, 'กระดังงา', 1002),
(9, 90190, 'สนามชัย', 1002),
(10, 90190, 'ดีหลวง', 1002),
(11, 90190, 'ชุมพล', 1002),
(12, 90190, 'คลองรี', 1002),
(13, 90190, 'คูขุด', 1002),
(14, 90190, 'ท่าหิน', 1002),
(15, 90190, 'วัดจันทร์', 1002),
(16, 90190, 'บ่อแดง', 1002),
(17, 90190, 'บ่อดาน', 1002),
(18, 90130, 'บ้านนา', 1003),
(19, 90130, 'ป่าชิง', 1003),
(20, 90130, 'สะพานไม้แก่น', 1003),
(21, 90130, 'สะกอม', 1003),
(22, 90130, 'นาหว้า', 1003),
(23, 90130, 'นาทับ', 1003),
(24, 90130, 'น้ำขาว', 1003),
(25, 90130, 'ขุนตัดหวาย', 1003),
(26, 90130, 'ท่าหมอไทร', 1003),
(27, 90130, 'จะโหนง', 1003),
(28, 90130, 'คู', 1003),
(29, 90130, 'แค', 1003),
(30, 90130, 'คลองเปียะ', 1003),
(31, 90130, 'ตลิ่งชัน', 1003),
(32, 90160, 'นาทวี', 1004),
(33, 90160, 'ฉาง', 1004),
(34, 90160, 'นาหมอศรี', 1004),
(35, 90160, 'คลองทราย', 1004),
(36, 90160, 'ปลักหนู', 1004),
(37, 90160, 'ท่าประดู่', 1004),
(38, 90160, 'สะท้อน', 1004),
(39, 90160, 'ทับช้าง', 1004),
(40, 90160, 'ประกอบ', 1004),
(41, 90160, 'คลองกวาง', 1004),
(42, 90150, 'เทพา', 1005),
(43, 90150, 'ปากบาง', 1005),
(44, 90150, 'เกาะสะบ้า', 1005),
(45, 90260, 'ลำไพล', 1005),
(46, 90260, 'ท่าม่วง', 1005),
(47, 90260, 'วังใหญ่', 1005),
(48, 90150, 'สะกอม', 1005),
(49, 90210, 'สะบ้าย้อย', 1006),
(50, 90210, 'ทุ่งพอ', 1006),
(51, 90210, 'เปียน', 1006),
(52, 90210, 'บ้านโหนด', 1006),
(53, 90210, 'จะแหน', 1006),
(54, 90210, 'คูหา', 1006),
(55, 90210, 'เขาแดง', 1006),
(56, 90210, 'บาโหย', 1006),
(57, 90210, 'ธารคีรี', 1006),
(58, 90140, 'ระโนด', 1007),
(59, 90140, 'คลองแดน', 1007),
(60, 90140, 'ตะเครียะ', 1007),
(61, 90140, 'ท่าบอน', 1007),
(62, 90140, 'บ้านใหม่', 1007),
(63, 90140, 'บ่อตรุ', 1007),
(64, 90140, 'ปากแตระ', 1007),
(65, 90140, 'พังยาง', 1007),
(66, 90140, 'ระวะ', 1007),
(67, 90140, 'วัดสน', 1007),
(68, 90140, 'บ้านขาว	', 1007),
(69, 90140, 'แดนสงวน', 1007),
(70, 90270, 'เกาะใหญ่', 1008),
(71, 90270, 'โรง', 1008),
(72, 90270, 'เชิงแส', 1008),
(73, 90270, 'กระแสสินธุ์', 1008),
(74, 90180, 'กำแพงเพชร', 1009),
(75, 90180, 'ท่าชะมวง', 1009),
(76, 90180, 'คูหาใต้', 1009),
(77, 90180, 'ควนรู', 1009),
(78, 90180, 'เขาพระ', 1009),
(79, 90120, 'สะเดา', 1010),
(80, 90120, 'ปริก', 1010),
(81, 90170, 'พังลา', 1010),
(82, 90120, 'สำนักแต้ว', 1010),
(83, 90240, 'ทุ่งหมอ', 1010),
(84, 90170, 'ท่าโพธิ์', 1010),
(85, 90240, 'ปาดังเบซาร์', 1010),
(86, 90320, 'สำนักขาม', 1010),
(87, 90170, 'เขามีเกียรติ', 1010),
(88, 90110, 'หาดใหญ่', 1011),
(89, 90110, 'ควนลัง', 1011),
(90, 90110, 'คูเต่า', 1011),
(91, 90110, 'คอหงส์', 1011),
(92, 90110, 'คลองแห	', 1011),
(93, 90110, 'คลองอู่ตะเภา', 1011),
(94, 90110, 'ฉลุง', 1011),
(95, 90110, 'ทุ่งใหญ่', 1011),
(96, 90110, 'ทุ่งตำเสา', 1011),
(97, 90110, 'ท่าข้าม', 1011),
(98, 90110, 'น้ำน้อย', 1011),
(99, 90250, 'บ้านพรุ', 1011),
(100, 90230, 'พะตง', 1011),
(101, 90310, 'นาหม่อม', 1012),
(102, 90310, 'พิจิตร', 1012),
(103, 90310, 'ทุ่งขมิ้น', 1012),
(104, 90310, 'คลองหรัง', 1012),
(105, 90220, 'รัตภูมิ', 1013),
(106, 90220, 'ควนโส', 1013),
(107, 90220, 'ห้วยลึก', 1013),
(108, 90220, 'บางเหรียง', 1013),
(109, 90110, 'บางกล่ำ', 1014),
(110, 90110, 'ท่าช้าง', 1014),
(111, 90110, 'แม่ทอม', 1014),
(112, 90110, 'บ้านหาร', 1014),
(113, 90280, 'ชิงโค', 1015),
(114, 90280, 'สทิงหม้อ', 1015),
(115, 90280, 'ทำนบ', 1015),
(116, 90330, 'รำแดง', 1015),
(117, 90330, 'วัดขนุน', 1015),
(118, 90330, 'ชะแล้', 1015),
(119, 90330, 'ปากรอ', 1015),
(120, 90330, 'ป่าขาด', 1015),
(121, 90280, 'หัวเขา', 1015),
(122, 90330, 'บางเขียด', 1015),
(123, 90330, 'ม่วงงาม', 1015),
(124, 90230, 'คลองหอยโข่ง', 1016),
(125, 90230, 'ทุ่งลาน', 1016),
(126, 90230, 'โคกม่วง', 1016),
(127, 90115, 'คลองหลา', 1016);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_Id` int(11) NOT NULL COMMENT 'ไอดี',
  `username` varchar(20) NOT NULL COMMENT 'รหัสผู้ใช้งาน',
  `password` varchar(32) NOT NULL COMMENT 'รหัสผ่าน',
  `u_name` varchar(30) NOT NULL COMMENT 'ชื่อ',
  `u_lastname` varchar(30) NOT NULL COMMENT 'นามสกุล',
  `u_tel` varchar(20) NOT NULL COMMENT 'เบอร์โทร',
  `u_email` varchar(50) NOT NULL COMMENT 'อีเมล์',
  `u_role` int(11) NOT NULL COMMENT 'ตำแหน่ง'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_Id`, `username`, `password`, `u_name`, `u_lastname`, `u_tel`, `u_email`, `u_role`) VALUES
(1, 'ITVT_001', '7dac116e4c088ba9a72fe41cdf2e54a4', 'สุกฤษฎิ์', 'แซ่เลี้ยว', '0942547377', 'reballkungzaza1159@gmail.com', 2),
(2, 'ITVT_002', 'bb917f9c534e506ed132539b55eaaf06', 'นิธิ', 'ทองวงศ์', '0897586942', 'nithi_it@gmail.com', 2),
(7, 'ITVT_003', 'd4ba4fac621446c422411a38ff7ac801', 'ภานุวัฒน์', 'บัวเพชร', '0985641256', 'poompoomrock@gmail.com', 2),
(99, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'ดวงใจ', 'แสงคง', '0874754914', 'admin.itvertex@gmail.com', 1),
(101, 'nattawat', '0fe094808e0d1c4cc755a2dbd50afc40', 'ณัฐวัฒน์', 'แสงคง', '0905412365', 'nattawat_sangkong@gmail.com', 4);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_warranty`
--

CREATE TABLE `tbl_warranty` (
  `warranty_id` int(11) NOT NULL,
  `repair_number` varchar(32) NOT NULL COMMENT 'หมายเลขแจ้งซ่อม',
  `warranty_number` int(11) NOT NULL COMMENT 'รหัสประกัน',
  `cus_number` varchar(32) NOT NULL COMMENT 'รหัสลูกค้า',
  `device_number` varchar(32) NOT NULL COMMENT 'หมายเลขอุปกรณ์',
  `warranty` date NOT NULL COMMENT 'วันสิ้นสุดประกัน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_thai_520_w2;

--
-- Dumping data for table `tbl_warranty`
--

INSERT INTO `tbl_warranty` (`warranty_id`, `repair_number`, `warranty_number`, `cus_number`, `device_number`, `warranty`) VALUES
(2, '6624641', 7750614, '1010691', '213456u7i8lu', '2024-01-08'),
(3, '6651499', 7783874, '1015126', 'dqijfewviwji', '2024-01-09'),
(4, '6669918', 7758562, '1015126', 'ifewjv9jv9j9', '2024-01-09'),
(5, '6670184', 7787366, '1052708', '404020399239', '2024-01-09'),
(6, '6674177', 7786937, '1010691', '412341232112', '2024-01-09'),
(7, '6698883', 7745373, '1052708', '849394294923', '2024-01-09'),
(8, '6680917', 7765679, '1015126', '213123123123', '2024-01-10'),
(9, '6680917', 7797465, '1015126', '213123123123', '2024-01-10'),
(10, '6680917', 7794229, '1015126', '213123123123', '2024-01-10'),
(11, '6681445', 7720878, '1015126', '931923912391', '2024-01-10'),
(12, '6624979', 7767672, '1015126', '39ru2939r293', '2024-01-10'),
(13, '6649141', 7721205, '1024757', '312039012309', '2024-01-10'),
(14, '6649141', 7767798, '1024757', '312039012309', '2024-01-10'),
(15, '6626053', 7751671, '1024757', '511435523145', '2024-01-10'),
(16, '6671657', 7779690, '1024757', '045902390590', '2024-01-10'),
(17, '6610997', 7746253, '1024757', '931023010000', '2024-01-10'),
(18, '6698334', 7789002, '1024757', '094203940923', '2024-01-10'),
(19, '6626932', 7751858, '1024757', '099997767676', '2024-01-11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_claim`
--
ALTER TABLE `tbl_claim`
  ADD PRIMARY KEY (`claim_id`);

--
-- Indexes for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  ADD PRIMARY KEY (`cus_id`);

--
-- Indexes for table `tbl_customer_address`
--
ALTER TABLE `tbl_customer_address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `tbl_device`
--
ALTER TABLE `tbl_device`
  ADD PRIMARY KEY (`device_id`);

--
-- Indexes for table `tbl_device_brand`
--
ALTER TABLE `tbl_device_brand`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `tbl_device_types`
--
ALTER TABLE `tbl_device_types`
  ADD PRIMARY KEY (`device_type_id`);

--
-- Indexes for table `tbl_district`
--
ALTER TABLE `tbl_district`
  ADD PRIMARY KEY (`district_id`);

--
-- Indexes for table `tbl_province`
--
ALTER TABLE `tbl_province`
  ADD PRIMARY KEY (`province_id`);

--
-- Indexes for table `tbl_repair`
--
ALTER TABLE `tbl_repair`
  ADD PRIMARY KEY (`repair_id`);

--
-- Indexes for table `tbl_repair_detail`
--
ALTER TABLE `tbl_repair_detail`
  ADD PRIMARY KEY (`detail_id`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `tbl_service`
--
ALTER TABLE `tbl_service`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `tbl_spares`
--
ALTER TABLE `tbl_spares`
  ADD PRIMARY KEY (`spares_id`);

--
-- Indexes for table `tbl_spares_type`
--
ALTER TABLE `tbl_spares_type`
  ADD PRIMARY KEY (`spares_type_id`);

--
-- Indexes for table `tbl_status`
--
ALTER TABLE `tbl_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `tbl_subdistrict`
--
ALTER TABLE `tbl_subdistrict`
  ADD PRIMARY KEY (`subdistrict_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_Id`);

--
-- Indexes for table `tbl_warranty`
--
ALTER TABLE `tbl_warranty`
  ADD PRIMARY KEY (`warranty_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_claim`
--
ALTER TABLE `tbl_claim`
  MODIFY `claim_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสเคลม', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  MODIFY `cus_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_customer_address`
--
ALTER TABLE `tbl_customer_address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสที่อยู่', AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tbl_device`
--
ALTER TABLE `tbl_device`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_device_brand`
--
ALTER TABLE `tbl_device_brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tbl_device_types`
--
ALTER TABLE `tbl_device_types`
  MODIFY `device_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสอุปกรณ์', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_district`
--
ALTER TABLE `tbl_district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_province`
--
ALTER TABLE `tbl_province`
  MODIFY `province_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสจังหวัด', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_repair`
--
ALTER TABLE `tbl_repair`
  MODIFY `repair_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tbl_repair_detail`
--
ALTER TABLE `tbl_repair_detail`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_service`
--
ALTER TABLE `tbl_service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_spares`
--
ALTER TABLE `tbl_spares`
  MODIFY `spares_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสอะไหล่', AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `tbl_spares_type`
--
ALTER TABLE `tbl_spares_type`
  MODIFY `spares_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสประเภทอะไหล่', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_status`
--
ALTER TABLE `tbl_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ไอดีสถานะ', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_subdistrict`
--
ALTER TABLE `tbl_subdistrict`
  MODIFY `subdistrict_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_Id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ไอดี', AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `tbl_warranty`
--
ALTER TABLE `tbl_warranty`
  MODIFY `warranty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 16, 2025 at 09:05 AM
-- Server version: 11.3.2-MariaDB-log
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yume_cos`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'Genshin Impact'),
(5, 'Hololive Vtuber'),
(6, 'Honkai Star Rail'),
(7, 'Zenless Zone Zero'),
(10, 'Anime Series'),
(12, 'Blue Archive'),
(13, 'Project SEKAI'),
(14, 'Wuthering Waves');

-- --------------------------------------------------------

--
-- Table structure for table `costumeimages`
--

CREATE TABLE `costumeimages` (
  `image_id` int(11) NOT NULL,
  `costume_id` int(11) NOT NULL,
  `image_url` varchar(355) NOT NULL,
  `public_id` varchar(255) NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT 1,
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `costumeimages`
--

INSERT INTO `costumeimages` (`image_id`, `costume_id`, `image_url`, `public_id`, `is_main`, `uploaded_at`) VALUES
(43, 43, 'https://res.cloudinary.com/verencecloud/image/upload/v1748693085/cosplay_image_collections/1748693083549-%281%29%20Ayaka%20Default.jpg', 'cosplay_image_collections/1748693083549-(1) Ayaka Default', 1, '2025-05-31 05:04:48'),
(44, 43, 'https://res.cloudinary.com/verencecloud/image/upload/v1748693086/cosplay_image_collections/1748693083554-%282%29%20Ayaka%20Default.jpg', 'cosplay_image_collections/1748693083554-(2) Ayaka Default', 0, '2025-05-31 05:04:48'),
(45, 43, 'https://res.cloudinary.com/verencecloud/image/upload/v1748693087/cosplay_image_collections/1748693085318-%283%29%20Ayaka%20Default.jpg', 'cosplay_image_collections/1748693085318-(3) Ayaka Default', 0, '2025-05-31 05:04:48'),
(46, 43, 'https://res.cloudinary.com/verencecloud/image/upload/v1748693087/cosplay_image_collections/1748693085321-%284%29%20Ayaka%20Default.jpg', 'cosplay_image_collections/1748693085321-(4) Ayaka Default', 0, '2025-05-31 05:04:48'),
(47, 44, 'https://res.cloudinary.com/verencecloud/image/upload/v1748698337/cosplay_image_collections/1748698334363-%281%29%20Firefly%20Casual.jpg', 'cosplay_image_collections/1748698334363-(1) Firefly Casual', 1, '2025-05-31 06:32:39'),
(48, 44, 'https://res.cloudinary.com/verencecloud/image/upload/v1748698345/cosplay_image_collections/1748698334365-%282%29%20Firefly%20Casual.jpg', 'cosplay_image_collections/1748698334365-(2) Firefly Casual', 0, '2025-05-31 06:32:39'),
(49, 44, 'https://res.cloudinary.com/verencecloud/image/upload/v1748698341/cosplay_image_collections/1748698334367-%283%29%20Firefly%20Casual.jpg', 'cosplay_image_collections/1748698334367-(3) Firefly Casual', 0, '2025-05-31 06:32:39'),
(51, 44, 'https://res.cloudinary.com/verencecloud/image/upload/v1748698343/cosplay_image_collections/1748698334372-%285%29%20Firefly%20Casual.jpg', 'cosplay_image_collections/1748698334372-(5) Firefly Casual', 0, '2025-05-31 06:32:39'),
(52, 45, 'https://res.cloudinary.com/verencecloud/image/upload/v1748931904/cosplay_image_collections/1748931897325-%281%29%20Corin%20Wickes.jpg', 'cosplay_image_collections/1748931897325-(1) Corin Wickes', 1, '2025-06-02 23:25:12'),
(53, 45, 'https://res.cloudinary.com/verencecloud/image/upload/v1748931906/cosplay_image_collections/1748931900354-%282%29%20Corin%20Wickes.jpg', 'cosplay_image_collections/1748931900354-(2) Corin Wickes', 0, '2025-06-02 23:25:12'),
(54, 45, 'https://res.cloudinary.com/verencecloud/image/upload/v1748931913/cosplay_image_collections/1748931903755-%283%29%20Corin%20Wickes.jpg', 'cosplay_image_collections/1748931903755-(3) Corin Wickes', 0, '2025-06-02 23:25:12'),
(55, 45, 'https://res.cloudinary.com/verencecloud/image/upload/v1748931909/cosplay_image_collections/1748931907687-%284%29%20Corin%20Wickes.jpg', 'cosplay_image_collections/1748931907687-(4) Corin Wickes', 0, '2025-06-02 23:25:12'),
(60, 47, 'https://res.cloudinary.com/verencecloud/image/upload/v1749978835/cosplay_image_collections/1749978832033-1.png', 'cosplay_image_collections/1749978832033-1', 1, '2025-06-15 02:14:03'),
(61, 47, 'https://res.cloudinary.com/verencecloud/image/upload/v1749978838/cosplay_image_collections/1749978835032-2.png', 'cosplay_image_collections/1749978835032-2', 0, '2025-06-15 02:14:03'),
(62, 47, 'https://res.cloudinary.com/verencecloud/image/upload/v1749978842/cosplay_image_collections/1749978837591-3.png', 'cosplay_image_collections/1749978837591-3', 0, '2025-06-15 02:14:03'),
(63, 47, 'https://res.cloudinary.com/verencecloud/image/upload/v1749978841/cosplay_image_collections/1749978840765-4.png', 'cosplay_image_collections/1749978840765-4', 0, '2025-06-15 02:14:03'),
(64, 48, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979311/cosplay_image_collections/1749979308280-1.png', 'cosplay_image_collections/1749979308280-1', 1, '2025-06-15 02:21:58'),
(65, 48, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979314/cosplay_image_collections/1749979310349-2.png', 'cosplay_image_collections/1749979310349-2', 0, '2025-06-15 02:21:58'),
(66, 48, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979314/cosplay_image_collections/1749979312907-3.png', 'cosplay_image_collections/1749979312907-3', 0, '2025-06-15 02:21:58'),
(67, 48, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979317/cosplay_image_collections/1749979312935-4.png', 'cosplay_image_collections/1749979312935-4', 0, '2025-06-15 02:21:58'),
(68, 49, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979980/cosplay_image_collections/1749979977715-1.png', 'cosplay_image_collections/1749979977715-1', 1, '2025-06-15 02:33:06'),
(69, 49, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979982/cosplay_image_collections/1749979979607-2.png', 'cosplay_image_collections/1749979979607-2', 0, '2025-06-15 02:33:06'),
(70, 49, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979984/cosplay_image_collections/1749979981416-3.png', 'cosplay_image_collections/1749979981416-3', 0, '2025-06-15 02:33:06'),
(71, 49, 'https://res.cloudinary.com/verencecloud/image/upload/v1749979983/cosplay_image_collections/1749979982160-4.png', 'cosplay_image_collections/1749979982160-4', 0, '2025-06-15 02:33:06'),
(72, 50, 'https://res.cloudinary.com/verencecloud/image/upload/v1749980605/cosplay_image_collections/1749980602548-1.png', 'cosplay_image_collections/1749980602548-1', 1, '2025-06-15 02:43:32'),
(73, 50, 'https://res.cloudinary.com/verencecloud/image/upload/v1749980608/cosplay_image_collections/1749980604595-2.png', 'cosplay_image_collections/1749980604595-2', 0, '2025-06-15 02:43:32'),
(74, 50, 'https://res.cloudinary.com/verencecloud/image/upload/v1749980608/cosplay_image_collections/1749980607280-3.png', 'cosplay_image_collections/1749980607280-3', 0, '2025-06-15 02:43:32'),
(75, 50, 'https://res.cloudinary.com/verencecloud/image/upload/v1749980610/cosplay_image_collections/1749980607637-4.png', 'cosplay_image_collections/1749980607637-4', 0, '2025-06-15 02:43:32'),
(76, 51, 'https://res.cloudinary.com/verencecloud/image/upload/v1750495707/cosplay_image_collections/1750495703707-1.png', 'cosplay_image_collections/1750495703707-1', 1, '2025-06-21 01:48:34'),
(77, 51, 'https://res.cloudinary.com/verencecloud/image/upload/v1750495709/cosplay_image_collections/1750495706260-2.png', 'cosplay_image_collections/1750495706260-2', 0, '2025-06-21 01:48:34'),
(78, 51, 'https://res.cloudinary.com/verencecloud/image/upload/v1750495710/cosplay_image_collections/1750495708281-3.png', 'cosplay_image_collections/1750495708281-3', 0, '2025-06-21 01:48:34'),
(79, 51, 'https://res.cloudinary.com/verencecloud/image/upload/v1750495711/cosplay_image_collections/1750495709295-4.png', 'cosplay_image_collections/1750495709295-4', 0, '2025-06-21 01:48:34'),
(84, 53, 'https://res.cloudinary.com/verencecloud/image/upload/v1750552909/cosplay_image_collections/1750552906626-1.png', 'cosplay_image_collections/1750552906626-1', 1, '2025-06-21 17:41:55'),
(85, 53, 'https://res.cloudinary.com/verencecloud/image/upload/v1750552911/cosplay_image_collections/1750552908820-2.png', 'cosplay_image_collections/1750552908820-2', 0, '2025-06-21 17:41:55'),
(86, 53, 'https://res.cloudinary.com/verencecloud/image/upload/v1750552913/cosplay_image_collections/1750552910872-3.png', 'cosplay_image_collections/1750552910872-3', 0, '2025-06-21 17:41:55'),
(87, 53, 'https://res.cloudinary.com/verencecloud/image/upload/v1750552913/cosplay_image_collections/1750552913404-4.png', 'cosplay_image_collections/1750552913404-4', 0, '2025-06-21 17:41:55');

-- --------------------------------------------------------

--
-- Table structure for table `costumes`
--

CREATE TABLE `costumes` (
  `costume_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 1,
  `size` enum('S','M','L','XL') NOT NULL,
  `gender` enum('Pria','Wanita') NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `tipe` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `costumes`
--

INSERT INTO `costumes` (`costume_id`, `name`, `description`, `price`, `stock`, `size`, `gender`, `category_id`, `created_at`, `tipe`) VALUES
(43, 'Kamisato Ayaka', 'KAMISATO AYAKA - GENSHIN IMPACT\n\nHARGA : 80k / 4 Hari', '80000.00', 2, 'M', 'Wanita', 1, '2025-05-31 05:04:48', ''),
(44, 'Firefly Casual', 'FIREFLY - HONKAI STAR RAIL\nHARGA : 70k / 4 Hari', '70000.00', 3, 'L', 'Wanita', 6, '2025-05-31 06:32:39', ''),
(45, 'Corin Wickes', 'KAMISATO AYAKA - GENSHIN IMPACT\n\nHARGA : 80k / 4 Hari', '100000.00', 1, 'S', 'Wanita', 7, '2025-06-02 23:25:12', ''),
(47, 'Violet Evergarden', 'VIOLET - VIOLET EVERGARDEN\n\nHARGA : 150k / 4 Hari', '150000.00', 3, 'M', 'Wanita', 10, '2025-06-15 02:14:03', ''),
(48, 'Hoshimachi Suisei', 'HOSHIMACHI SUISEI DEFAULT - HOLOLIVE JP\n\nHARGA : 110k / 4 Hari', '110000.00', 2, 'L', 'Wanita', 5, '2025-06-15 02:21:58', ''),
(49, 'Wanderer', 'WANDERER SCARAMOUCHE  - GENSHIN IMPACT\n\nHARGA : 85k / 4 Hari', '85000.00', 3, 'L', 'Pria', 1, '2025-06-15 02:33:06', ''),
(50, 'Scaramouche', 'Scaramouche Balladeer  - GENSHIN IMPACT\n\nHARGA : 160k / 4 Hari', '160000.00', 3, 'XL', 'Pria', 1, '2025-06-15 02:43:32', ''),
(51, 'Phoebe', 'test deskripsi', '115000.00', 3, 'M', 'Wanita', 14, '2025-06-21 01:48:34', ''),
(53, 'Aventurine ', 'test', '140000.00', 3, 'L', 'Pria', 6, '2025-06-21 17:41:55', '');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

CREATE TABLE `rentals` (
  `rental_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `costume_id` int(11) NOT NULL,
  `rental_start` date DEFAULT NULL,
  `rental_end` date DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `status` enum('pending','ongoing','active','completed','returning') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`rental_id`, `user_id`, `costume_id`, `rental_start`, `rental_end`, `total_price`, `status`, `created_at`) VALUES
(1, 6, 47, '2025-06-17', '2025-06-21', '150000.00', 'completed', '2025-06-16 06:47:18'),
(2, 6, 48, '2025-06-19', '2025-06-23', '110000.00', 'completed', '2025-06-16 06:54:01'),
(3, 6, 45, '2025-06-19', '2025-06-23', '100000.00', 'completed', '2025-06-16 07:30:04'),
(4, 6, 44, '2025-06-19', '2025-06-23', '70000.00', 'completed', '2025-06-16 07:36:46'),
(5, 6, 49, '2025-06-19', '2025-06-23', '85000.00', 'completed', '2025-06-17 00:25:56'),
(7, 6, 50, '2025-06-19', '2025-06-23', '160000.00', 'completed', '2025-06-17 08:37:19'),
(8, 6, 50, '2025-06-20', '2025-06-24', '160000.00', 'completed', '2025-06-17 08:37:25'),
(9, 6, 44, '2025-06-20', '2025-06-24', '70000.00', 'completed', '2025-06-17 17:01:51'),
(10, 6, 47, '2025-06-20', '2025-06-24', '150000.00', 'returning', '2025-06-17 17:09:36'),
(11, 6, 47, '2025-06-20', '2025-06-24', '150000.00', 'completed', '2025-06-17 17:10:02'),
(12, 6, 49, '2025-06-20', '2025-06-24', '85000.00', 'completed', '2025-06-17 17:11:07'),
(13, 6, 49, '2025-06-20', '2025-06-24', '85000.00', 'completed', '2025-06-17 17:11:28'),
(14, 6, 49, '2025-06-20', '2025-06-24', '85000.00', 'completed', '2025-06-17 17:12:09'),
(15, 6, 49, '2025-06-20', '2025-06-24', '85000.00', 'completed', '2025-06-17 17:18:29'),
(16, 6, 44, NULL, NULL, '70000.00', 'pending', '2025-06-17 17:47:30'),
(17, 6, 48, '2025-06-20', '2025-06-24', '110000.00', 'active', '2025-06-20 05:37:39'),
(18, 6, 44, '2025-06-20', '2025-06-24', '70000.00', 'active', '2025-06-20 05:56:26'),
(19, 6, 48, NULL, NULL, '110000.00', 'ongoing', '2025-06-20 05:56:33'),
(20, 13, 45, NULL, NULL, '100000.00', 'ongoing', '2025-06-20 06:41:44'),
(21, 13, 48, '2025-06-22', '2025-06-26', '110000.00', 'active', '2025-06-20 07:01:34'),
(22, 6, 51, '2025-06-21', '2025-06-25', '115000.00', 'completed', '2025-06-21 01:58:01'),
(23, 6, 49, NULL, NULL, '85000.00', 'pending', '2025-06-21 17:54:17'),
(24, 6, 53, '2025-06-22', '2025-06-26', '140000.00', 'completed', '2025-06-21 17:59:03'),
(25, 6, 53, '2025-06-22', '2025-06-26', '140000.00', 'completed', '2025-06-21 18:08:47'),
(26, 13, 53, '2025-06-22', '2025-06-26', '140000.00', 'completed', '2025-06-21 21:19:06'),
(27, 13, 43, NULL, NULL, '80000.00', 'ongoing', '2025-06-21 21:29:17'),
(28, 13, 50, NULL, NULL, '160000.00', 'pending', '2025-06-21 21:29:41'),
(29, 13, 51, '2025-06-22', '2025-06-26', '115000.00', 'completed', '2025-06-22 01:10:47'),
(30, 13, 53, '2025-06-22', '2025-06-26', '140000.00', 'completed', '2025-06-22 01:38:55'),
(31, 13, 51, '2025-06-22', '2025-06-26', '115000.00', 'completed', '2025-06-22 02:36:52'),
(32, 6, 51, '2025-06-23', '2025-06-27', '115000.00', 'completed', '2025-06-23 06:19:17'),
(33, 16, 53, '2025-06-24', '2025-06-28', '140000.00', 'completed', '2025-06-23 19:56:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `nik_ktp` char(16) NOT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `username`, `email`, `password`, `phone_number`, `nik_ktp`, `address`, `created_at`, `role`) VALUES
(5, 'Sienna', 'sena', 'sienna@example.com', '$2b$15$.p7DuR2pBDpKloIMwmPXYuoaUJOVzfMbTdNDL6W.Ujk/tpDwbauaC', '085788990011', '9971033711870002', 'Jl. Pangeran Antasari No. 112, RT 004 / RW 002, Kel. Kedamaian, Kec. Kedamaian, Kota Bandar Lampung, Lampung 35122', '2025-05-29 21:12:48', 'user'),
(6, 'Seraphina Noctis', 'seraphina_noctis', 'seraphina_noctis@example.com', '$2b$15$evFje4CzGnTaI4a/t6VmqO4QyqU3bYTb21Y.fKu7RT3Ms.rdBawoe', '081322334455', '1871021408920003', 'Jl. Raden Intan No. 15, Enggal, Bandar Lampung', '2025-05-29 21:24:02', 'user'),
(11, 'Lyra Caelum', 'lyra_caelum', 'lyra_caelum@example.com', '$2b$15$.dbVdyHTKs0.Ly1E2y8ETOZxSs3cs.gTXPsSGpGs//mUm2fzn3Coe', '087844556677', '1871025008880002', 'Perumahan Villa Citra Blok A2, Jagabaya, Bandar Lampung', '2025-06-13 19:56:41', 'user'),
(12, 'Lucian Ecliptis', 'lucian_ecliptis', 'lucian_ecliptis@example.com', '$2b$15$leQ1kPv9QU.XAbkLGP0XrOXWYF51jW27OoclgZXg3uNp0Eac.GYY.', '087811223344', '1871032501790003', 'Jl. Ryacudu No. 50, Sukarame, Bandar Lampung', '2025-06-13 20:36:45', 'user'),
(13, 'Aurelia Vespera', 'aurelia_vespera', 'aurelia_vespera@example.com', '$2b$15$t06GO7TWp38scLQefgVJj.anykzkVRQQMAXxUkxfALPZq1OZWU07q', '085711223344', '1871046111950004', 'Jalan Pulau Sebesi Gg. Manggis No. 18, Kelurahan Sukarame, Kecamatan Sukarame, Bandar Lampung', '2025-06-14 05:46:14', 'user'),
(14, 'Selene Draconis', 'selene_draconis', 'selene_draconis@example.com', '$2b$15$IVyyjeQO1C5Y2Grv41kYs.P.KRRKqVjZE/zUOfgpmYAcVXOOOpWHe', '081312345678', '1871062105930004', 'Jl. Urip Sumoharjo No. 6, Sukarame, Bandar Lampung', '2025-06-14 05:59:06', 'user'),
(15, 'Cyprian Ignis', 'cyprian_ignis', 'cyprian_ignis@example.com', '$2b$15$48NIDfN0WRprXKtYQzQoCe.AOUWgqc1/9dCFHbIavm0chtQuf7fFG', '087711223344', '1871080406950003', 'Perumahan Bukit Kencana Blok C1, Kedaton, Bandar Lampung', '2025-06-20 05:44:00', 'user'),
(16, 'Octavia Silva', 'octavia_silva', 'octavia_silva@example.com', '$2b$15$1AeyrTAQZNfGMXBXGTqWP.AiArepEv1XGtkL1tcWXeH5G3HAm6nc.', '081912345678', '1871032503920001', 'Jl. Imam Bonjol No. 23, Kemiling, Bandar Lampung', '2025-06-23 19:56:14', 'user'),
(17, 'Stevia', 'stevi', 'stevia@example.com', '$2b$15$xO2X4hnFHVBflrWEKJ/8jestGhFzD5Oz6tZHxvSxeArTu3jOxtuX2', '087811223344', '1871022008960002', 'Jl. Ryacudu No. 50, Sukarame, Bandar Lampung', '2025-11-15 20:59:29', 'user'),
(18, 'Skyla', 'kayla', 'skyla@example.com', '$2b$15$D/dSeK/6RBy.kUqFFZC5e.l9x1Z5PVix6EBvoV.wfMKVdfzZSI9xG', '082198765432', '1871011501870001', 'Jl. Gajah Mada No. 1, Tanjung Karang Timur, Bandar Lampung', '2025-11-15 21:06:04', 'admin'),
(19, 'Serena', 'seren', 'serena@example.com', '$2b$15$DIoq9zxf9fgGfSnNpkJojeMjVPjcBNQ1DyEZA2Nw8GTmnnVMWlA3K', '081398765432', '1871121010940003', 'Jl. Arif Rahman Hakim No. 88, Way Halim, Bandar Lampung', '2025-11-16 02:03:47', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `costumeimages`
--
ALTER TABLE `costumeimages`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `idx_costume_id` (`costume_id`);

--
-- Indexes for table `costumes`
--
ALTER TABLE `costumes`
  ADD PRIMARY KEY (`costume_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`rental_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `costume_id` (`costume_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nik_ktp` (`nik_ktp`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `costumeimages`
--
ALTER TABLE `costumeimages`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT for table `costumes`
--
ALTER TABLE `costumes`
  MODIFY `costume_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `rentals`
--
ALTER TABLE `rentals`
  MODIFY `rental_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `costumeimages`
--
ALTER TABLE `costumeimages`
  ADD CONSTRAINT `fk_costume_images_costume` FOREIGN KEY (`costume_id`) REFERENCES `costumes` (`costume_id`) ON DELETE CASCADE;

--
-- Constraints for table `costumes`
--
ALTER TABLE `costumes`
  ADD CONSTRAINT `costumes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`costume_id`) REFERENCES `costumes` (`costume_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

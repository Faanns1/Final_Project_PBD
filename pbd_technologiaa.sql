-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2025 at 08:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pbd_technologia`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_produk_kategori_harga` (IN `p_id_kategori` INT, IN `p_min_harga` BIGINT)   BEGIN
    SELECT 
        b.id,
        b.title AS nama_produk,
        b.price AS harga,
        c.name AS nama_kategori
    FROM best_seller b
    JOIN category c ON b.id_category = c.id_category
    WHERE b.id_category = p_id_kategori
      AND b.price >= p_min_harga
    ORDER BY b.price DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_produk_tersedia` ()   BEGIN
    DECLARE jumlah INT;

    -- Hitung jumlah produk yang tersedia
    SELECT COUNT(*) INTO jumlah FROM best_seller WHERE status = 'In Stock';

    -- Flow control: cek apakah ada produk
    IF jumlah = 0 THEN
        SELECT 'Tidak ada produk yang tersedia.' AS pesan;
    ELSE
        -- Tampilkan produk tersedia
        SELECT 
            id AS ID,
            title AS Nama,
            price AS Harga,
            status AS Status
        FROM best_seller
        WHERE status = 'In Stock'
        ORDER BY price DESC;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_welcome_message` () RETURNS VARCHAR(100) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    RETURN 'Selamat datang di Technologia!';
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_harga` (`harga` INT, `jumlah` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    RETURN harga * jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `nama_lengkap`, `email`, `role`, `created_at`, `updated_at`) VALUES
(1, 'person1', '$2y$10$5V8rcQCsGJ/P.TZ3dxUGUOjipc71d3Rqs2TxIViv7dVTkE0R/CCnK', 'Person1', 'person1@gmail.com', 'admin', '2025-06-12 08:29:51', '2025-06-12 08:29:51'),
(4, 'person2', '$2y$10$cB2tQJYu4yR5rlHaRMDIEe/kvbm3L43BP4.PuYpl6lfJ5YGHjI0wu', 'person2', 'person2@gmail.com', 'admin', '2025-07-26 03:25:53', '2025-07-26 03:25:53'),
(5, 'person3', '$2y$10$T6q6HRkTHu35sDUZlJ9K9.9RedXCqNT1Ikzr4YvG0MNzVy.xFoEqu', 'person3', 'person3@gmail.com', 'admin', '2025-07-26 03:26:28', '2025-07-26 03:26:28'),
(6, 'person4', '$2y$10$/RBOhrBFza2S6Yd2P47G7uhh6mlhpo66TBhlY81z76dXruGIXmr7G', 'person4', 'person4@gmail.com', 'admin', '2025-07-26 03:26:49', '2025-07-26 03:26:49'),
(7, 'person5', '$2y$10$j3S7SHQDh9.ROWco84/sn.a/6K4/D3GS5tq/j5/A1odEjMW.2YGju', 'person5', 'person5@gmail.com', 'admin', '2025-07-26 03:27:10', '2025-07-26 03:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `best_seller`
--

CREATE TABLE `best_seller` (
  `id` int(11) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `specs` text NOT NULL,
  `price` bigint(20) NOT NULL,
  `old_price` bigint(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `image_1` varchar(255) DEFAULT NULL,
  `image_2` varchar(255) DEFAULT NULL,
  `image_3` varchar(255) DEFAULT NULL,
  `category` text DEFAULT NULL,
  `buy_link` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `id_category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `best_seller`
--

INSERT INTO `best_seller` (`id`, `slug`, `title`, `specs`, `price`, `old_price`, `status`, `image_1`, `image_2`, `image_3`, `category`, `buy_link`, `description`, `qr_code`, `created_at`, `id_category`) VALUES
(18, 'msikatana15b13vfk', 'MSI Katana 15 B13VFK 1850ID', 'Intel Core i7-13620H | RTX 4060 | 15.6\" QHD(2560x1440), 165Hz Refresh Rate | 16GB (8GB x 2, DDR5-5200) | Win 11 + Office Home & Students 2021', 20049000, 0, 'In Stock', '/Images/1750556652_MSI Katana 15 B13VFK 1850ID 1.png', '/Images/1750556652_MSI Katana 15 B13VFK 1850ID 2.png', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Intel, Laptop Intel i7, Laptop RTX, MSI Katana, MSI', 'https://www.tokopedia.com/hosanacomp/msi-katana-15-b13vfk-1850id-intel-i7-13620h-16gb-1tb-rtx4060-8gb-qhd-ips-win11-ohs-16gb-512gb-ssd-win11-home-4664b?extParam=ivf%3Dfalse%26keyword%3Dmsi+katana+15+b13vfk+1850id%26search_id%3D20250516080738E99F3F53DAD4C108B7BX%26src%3Dsearch&t_id=1747380994320&t_st=31&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'OS : Windows 11 Home + Microsoft Office Home & Student 2021 included | Processor : 13th Gen Intel Core i7-13620H, 10 cores (6 P-cores + 4 E-cores), Max Turbo Frequency 4.9 GHz | Display : 15.6\" QHD (2560x1440), 165Hz Refresh Rate, IPS-Level, 100% DCI-P3 (Typical) | Chipset : Integrated SoC | Graphics : NVIDIA GeForce RTX 4060 Laptop GPU 8GB GDDR6 | RAM : 16GB (8GB*2, DDR5-5200), 2 Slots, Max 64GB | Storage : 1TB NVMe PCIe SSD Gen4x4, 2x M.2 SSD slot (NVMe PCIe Gen4) | Wireless : Intel Wi-Fi 6 AX201 (2*2 ax) + BT5.2 | Keyboard : 4-Zone RGB Gaming Keyboard | Camera : HD type (30fps@720p) | Audio : 2x 2W Audio Speaker, Nahimic 3 Audio Enhancer, Hi-Res Audio Ready | LAN : Gigabit Ethernet | Ports : 1x Mic-in/Headphone-out Combo Jack, 1x Type-C (USB3.2 Gen1 / DP), 2x Type-A USB3.2 Gen1, 1x Type-A USB2.0, 1x HDMI 2.1 (8K @ 60Hz / 4K @ 120Hz) | Battery : 3-Cell 53.5 Whr | AC Adapter : 200W Adaptor | Dimension (W x D x H) : 359 x 259 x 24.9 mm | Weight : 2.25 kg\r\n', '/Images/1750556652_qr MSI Katana 15 B13VFK 1850ID.png', '2025-06-22 08:44:12', 1),
(19, 'hp14sdq5152tu', 'HP 14S DQ5152TU', 'Intel Core i5 1235U | Intel Iris Xᵉ Graphics | 14\" FHD (1920 x 1080) | 8 GB DDR4-3200 | Win 11 + Office Home & Students 2021', 7099000, 0, 'In Stock', '/Images/1750558213_HP 14S DQ5152TU 1.png', '/Images/1750558213_HP 14S DQ5152TU 2.png', '/Images/1750558213_qr HP 14S DQ5152TU.png', ' Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i5, Laptop Intel Iris Graphics, HP 14S, HP', 'https://www.tokopedia.com/agreshpauthorized/laptop-hp-14s-dq5152tu-core-i5-1235u-8gb-512ssd-w11-ohs-14-0-fhd-ips-silver-harga-terbaik-8gb-256ssd-9a52a?extParam=ivf%3Dfalse%26keyword%3Dhp+14s+dq5152tu&src=topads&t_id=1747380994320&t_st=30&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'OS : Windows 11 Home Single Language | Processor : Intel Core i5-1235U (up to 4.4 GHz with Intel Turbo Boost Technology, 12 MB L3 cache, 10 cores, 12 threads) | Memory : 8 GB DDR4-3200 MHz RAM (2 x 4 GB) (Upgradeable) | Internal Storage : 512 GB PCIe NVMe M.2 SSD (Upgradeable) | Display : 35.6 cm (14\") diagonal, FHD (1920 x 1080), IPS, micro-edge, antiglare, 250 nits, 45% NTSC | Graphics : Intel Iris Xᵉ Graphics (integrated) | Ports : 1 SuperSpeed USB Type-C 5Gbps, 2 SuperSpeed USB Type-A 5Gbps, 1 HDMI 1.4b, 1 AC smart pin, 1 headphone/microphone combo | Expansion Slots : 1 multi-format SD media card reader | Camera : HP True Vision 720p HD camera and integrated dual array digital microphones | Audio : Dual speakers | Keyboard : Backlit, natural silver keyboard | Wireless : Wi-Fi and Bluetooth 5 combo | Power Supply : 45 W Smart AC power adapter | Battery : 3-cell, 41 Wh Li-ion | Product Design : Paint finish cover and base, vertical brushed In-mould roll keyboard frame | Product Color : Natural silver | Dimensions (W x D x H) : 32.4 x 22.5 x 1.79 cm | Weight : 1.46 kg\r\n', '', '2025-06-22 09:10:13', 2),
(20, 'lenovoloq15arp9j5id', 'Lenovo LOQ 15ARP9 J5ID', 'AMD Ryzen 7 7435HS | RTX 4050 | 15.6\" FHD (1920x1080), 144Hz Refresh Rate | 32GB DDR5-4800 | Win 11 + 365 Basic + Office Home 2024', 14699000, 0, 'In Stock', '/Images/1750558753_Lenovo LOQ 15ARP9 J5ID  1.png', '/Images/1750558753_Lenovo LOQ 15ARP9 J5ID  2.png', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop Ryzen 7, Laptop RTX, Lenovo LOQ, Lenovo', 'https://www.tokopedia.com/gasolsumbersari/lenovo-loq-15arp9-j5id-rtx-4050-6gb-ryzen-7-7435hs-512gb-ssd-12gb-ram-15-6-fhd-ips-144hz-win11-notebook-laptop-gaming-1731369088578520975?extParam=ivf%3Dfalse%26keyword%3Dlenovo+loq+15arp9+j5id%26search_id%3D20250516080503E99F3F53DAD4C11241GM%26src%3Dsearch&t_id=1747380994320&t_st=29&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : AMD Ryzen 7 7435HS (8C / 16T, 3.1 / 4.5GHz, 4MB L2 / 16MB L3) | AI PC Category : AI-Powered Gaming PC | Graphics : NVIDIA GeForce RTX 4050 6GB GDDR6, Boost Clock 2370MHz, TGP 105W | Chipset : AMD SoC Platform | Memory : 1x 12GB SO-DIMM DDR5-4800 | Memory Slots : Two DDR5 SO-DIMM slots, dual-channel capable | Max Memory : Up to 32GB DDR5-4800 | Storage : 512GB SSD M.2 2242 PCIe 4.0x4 NVMe | Storage Support : Up to two drives, 2x M.2 SSD (M.2 2242 SSD up to 1TB each) | Storage Slot : Two M.2 2280 PCIe 4.0 x4 slots | Card Reader : None | Optical : None | Audio Chip : High Definition (HD) Audio, Realtek ALC3287 codec | Speakers : Stereo speakers, 2W x2, optimized with Nahimic Audio | Camera : HD 720p with E-shutter | Microphone : 2x, Array | Battery : 60Wh | Power Adapter : 170W Slim Tip (3-pin) | Special Features : AI Chip: LA1 | Display : 15.6\" FHD (1920x1080) IPS 300nits Anti-glare, 100% sRGB, 144Hz, G-SYNC | Touchscreen : None | Color Calibration : None | Keyboard : White Backlit, English | Touchpad : Buttonless Mylar surface multi-touch touchpad, supports Precision TouchPad (PTP), 75 x 120 mm (2.95 x 4.72 inches) | Case Color : Luna Grey | Surface Treatment : Painting | Case Material : PC-ABS (Top), PC-ABS (Bottom) | Pen : Pen Not Supported | Dimensions (WxDxH) : 359.86 x 258.7 x 21.9-23.9 mm (14.17 x 10.19 x 0.86-0.94 inches) | Operating System : Windows 11 Home Single Language, English | Bundled Software : Microsoft 365 Basic + Office Home 2024 | WLAN + Bluetooth : Wi-Fi 6, 802.11ax 2x2 + BT5.2 | WWAN : Non-WWAN | Ethernet : 100/1000M (RJ-45) | Standard Ports : 3x USB-A (USB 5Gbps / USB 3.2 Gen 1), 1x USB-C (USB 10Gbps / USB 3.2 Gen 2) with Lenovo PD 140W and DisplayPort 1.4, 1x HDMI 2.1 up to 8K/60Hz, 1x Headphone/microphone combo jack (3.5mm), 1x Ethernet (RJ-45), 1x Power connector\r\n', '/Images/1750558753_qr Lenovo LOQ 15ARP9 J5ID.png', '2025-06-22 09:19:13', 1),
(21, 'asustuf14fa401uu', 'Asus TUF A14 FA401UU', 'Ryzen 7 8845HS | RTX 4050 | 14\" 2.5K (2560 x 1600, WQXGA), 165Hz Refresh Rate | 8GB x 2 LPDDR5X 7500 | Win 11 + Office Home & Students 2021', 21999000, 0, 'In Stock', '/Images/1750559125_Asus TUF A14 FA401UU 1.jpg', '/Images/1750559125_Asus TUF A14 FA401UU 2.jpg', '/Images/1750559125_ASUS TUF A14 FA401UU (2).jpg', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop Ryzen 7, Laptop RTX, Asus TUF, Asus', 'https://www.tokopedia.com/nvidiageforceofficial/asus-tuf-a14-fa401uu-geforce-rtx-4050-ryzen-7-8845hs-16gb-512gb-165hz-16-512-unit-set-1bc0a?extParam=ivf%3Dfalse%26keyword%3Dasus+tuf+a14+fa401uu%26search_id%3D20250516080417B98EBC002CD63E278BOC%26src%3Dsearch&t_id=1747380994320&t_st=28&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Graphics : NVIDIA GeForce RTX 4050 Laptop GPU, 2345Mhz* at 100W(2295MHz Boost Clock+50MHz O.C.,75W+25W Dynamic Boost), 6GB GDDR6 | Processor : AMD Ryzen 7 8845HS Processor 3.8GHz (24MB Cache, up to 5.1 GHz, 8 cores, 16 Threads); AMD XDNA NPU up to 16TOPS | Memory : 8GB*2 LPDDR5X 7500 on board, Max Capacity:16GB (Soldered) | Display : 14-inch, 2.5K (2560 x 1600, WQXGA) 16:10 aspect ratio, IPS-level, Anti-glare, sRGB:100%, Refresh Rate:165Hz, G-Sync, MUX Switch + NVIDIA Advanced Optimus | Storage : 512GB PCIe 4.0 NVMe M.2 SSD | Keyboard : Backlit Chiclet Keyboard Single Light | Wireless Network : Wi-Fi 6(802.11ax)+Bluetooth 5.1 (Dual band) 2*2 | Interfaces : 1x 3.5mm Combo Audio Jack, 1x HDMI 2.1 FRL, 2x USB 3.2 Gen 2 Type-A, 1x USB 3.2 Gen 2 Type-C support DisplayPort, 1x Type-C USB 4 support DisplayPort / power delivery, 1x card reader (microSD) (UHS-II) | Connection : Wi-Fi 6E(802.11ax) (Triple band) 2*2 + Bluetooth 5.3 Wireless Card (*Bluetooth version may change with OS version different) | Operating System : Windows 11 Home + Office Home Student 2021 | Battery : 73WHrs, 4S1P, 4-cell Li-ion | Weight : 1.46 Kg (3.22 lbs)\r\n', '/Images/1750559125_qr Asus TUF A14 FA401UU.png', '2025-06-22 09:25:25', 1),
(22, 'msimodern14c7m280id', 'MSI Modern 14-C7M-280ID', 'AMD Ryzen 7 7730U | AMD Radeon Graphics | 14\" FHD(1920x1080) | 16GB DDR4-3200 | Win 11 + Office Home & Students 2021', 8899000, 0, 'In Stock', '/Images/1750559419_MSI Modern 14-C7M-280ID 1.png', '/Images/1750559419_MSI Modern 14-C7M-280ID 2.jpg', '', ' Laptop, Laptop By Brand, Laptop By AMD, Laptop Ryzen, Laptop Ryzen 7, MSI Modern, MSI', 'https://www.tokopedia.com/blessingcombali/msi-modern-14-c7m-280id-ryzen-7-7730u-16gb-512gb-w11-ohs-classic-black?extParam=ivf%3Dfalse%26keyword%3Dmsi+modern+14-c7m-280id&src=topads&t_id=1747380994320&t_st=27&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Ryzen 7 7730U (8 Cores, Max Boost 4.5GHz) | Color : Classic Black | MSI Sleeve Bag include inside Box | Operating System : Windows 11 Home + OHS 2021 | Chipset : Integrated SoC | Graphics : AMD Radeon Graphics | Memory : 16GB DDR4-3200 onboard | Storage : 512GB NVMe SSD PCIe Gen3 | Display : 14\" FHD (1920x1080), IPS-Level | Keyboard : Single Backlit Keyboard (White) | Audio : 2x 2W Audio Speaker, Hi-Res Audio Ready | Webcam : HD (30fps@720p) | WLAN : AMD RZ616 Wi-Fi 6E, Bluetooth v5.3 | I/O Ports : 1x Mic-in/Headphone-out Combo Jack, 1x Type-C USB3.2 Gen2 with PD charging, 1x Type-A USB3.2 Gen2, 2x Type-A USB2.0, 1x HDMI 2.1 (4K @ 60Hz), 1x Micro SD | Battery : 3-Cell, 39.3 Whrs | AC Adapter : 65W Adaptor\r\n', '/Images/1750559419_qr MSI Modern 14-C7M-280ID.png', '2025-06-22 09:30:19', 1),
(23, 'acernitrov15anv1541r99d', 'Acer Nitro V 15 ANV15-41-R99D', 'AMD Ryzen 5-6600H | RTX 3050 | 15.6\" FHD (1920x1080), 165Hz Refresh Rate | 8 GB DDR5 | Win 11 + Office Home & Students 2021', 10395000, 0, 'In Stock', '/Images/1750559762_Acer Nitro V 15 ANV15-41-R99D.png', '/Images/1750559762_Acer Nitro V 15 ANV15-41-R99D 2.png', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop Ryzen 5, Laptop RTX, Acer Nitro, Acer', 'https://www.tokopedia.com/multikom-id/acer-nitro-v-15-anv15-41-r99d-r5-6600h-8gb-512gb-ssd-rtx3050-6gb-15-6-fhd-165hz-win-11-home-ohs-2021-black-1730910373754603255?extParam=ivf%3Dfalse%26keyword%3Dacer+nitro+v+15+anv15-41-r99d%26search_id%3D20250516080241BEFF8E657ECC5A08EVKP%26src%3Dsearch&t_id=1747380994320&t_st=26&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : AMD Ryzen 5-6600H | Display : 15.6\" Full HD (1920x1080), IPS (In-Plane Switching), Acer ComfyView, LED-backlit TFT LCD, 165 Hz | Graphics : NVIDIA GeForce RTX 3050 with 6 GB GDDR6 VRAM (TGP : 50W, MGP : 65W) | Memory : 8 GB (1*8GB) DDR5 4800MHz Dual-channel, 1 Slot kosong, Upgradable up to 32 GB DDR5 | Storage : 512 GB (1*512GB) SSD PCIe Gen4 + 1 Slot kosong up to 2TB (1TB+1TB) | Operation System : Windows 11 Home & Office Home Student 2021\r\n', '/Images/1750559762_qr Acer Nitro V 15 ANV15-41-R99D.png', '2025-06-22 09:36:02', 1),
(24, 'lenovov14g4amnv7id', 'Lenovo V14 G4 AMN V7ID', 'AMD Ryzen 3 7320U | AMD Radeon 610M | 14\" FHD (1920x1080) | 8GB LPDDR5-5500 | Win 11 + Office Home & Students 2021', 5549000, 0, 'In Stock', '/Images/1750560386_Lenovo V14 G4 AMN V7ID.png', '/Images/1750560386_Lenovo V14 G4 AMN V7ID 2.png', '', ' Laptop, Laptop By Brand, Laptop Ryzen, Laptop Ryzen 3, Laptop AMD, Lenovo V14, Lenovo', 'https://www.tokopedia.com/agresidjaktim/laptop-lenovo-v14-g4-i3-1315-16gb-512gb-w11-14-0fhd-1731150458610616096?extParam=ivf%3Dfalse%26keyword%3Dlenovo+v14%26search_id%3D20250621064433496E05E1AEA0A91C5KY6%26src%3Dsearch&t_id=1749870350570&t_st=63&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=rec_product_detail_outer_pdp_1_module&t_spt=search_result', 'Processor : Intel Core i3-7320U | RAM : 8GB / 16GB | SSD : 256GB / 512GB NVME | VGA : Intel UHD Graphics | Display : 14\" FHD (1920x1080) 250nits Anti-glare | Sistem Operasi : Windows 11 Original | I/O ports : 1x USB 2.0, 1x USB 3.2 Gen 1, 1x USB-C 3.2 Gen 1 (support data transfer, Power Delivery 3.0 and DisplayPort 1.2), 1x HDMI 1.4b, 1x Ethernet (RJ-45), 1x Headphone / microphone combo jack (3.5mm), 1x Power connector\r\n', '/Images/1750560386_qr Lenovo V14 G4 AMN V7ID.png', '2025-06-22 09:46:26', 3),
(25, 'macbookair132020', 'MacBook Air 13 2020', 'Apple M1 Chip (8-Core CPU 7-Core GPU) | 8GB RAM | 256GB SSD | 13\" Liquid Retina Display', 10329000, 0, 'In Stock', '/Images/1750562051_MacBook Air 13 2020.png', '/Images/1750562051_MacBook Air 13 2020 2.png', '', ' Laptop, Laptop By Brand, Laptop M1,  Apple M1, Macbook Air, Apple', 'https://www.tokopedia.com/digitechmall/macbook-air-2020-m1-13-8gb-256gb-8-core-cpu-7-core-gpu-256-gb-ibox-1731123476942456435?extParam=ivf%3Dfalse%26keyword%3Dmacbook+air+13+2020%26search_id%3D202505160801301C292C9EFC5BA43E03I3%26src%3Dsearch&t_id=1747380994320&t_st=25&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Apple M1 chip with 8-core CPU | 16-core Neural Engine | 8GB unified memory | Retina display with True Tone | Backlit Magic Keyboard | Touch ID | Force Touch trackpad | Two Thunderbolt / USB 4 ports\r\n', '/Images/1750562051_qr MacBook Air 13 2020.png', '2025-06-22 10:14:11', 5),
(27, 'acerliteal114m', 'Acer Lite (AL1-14M) - Metal Cover', 'Intel Core i3-1215U | Intel UHD Graphics | 14.0″ WUXGA 1920 x 120 | 1×8 GB DDR4 | Win 11 + Office Home & Students 2021', 6371000, 0, 'In Stock', '/Images/1750562866_Acer Lite (AL1-14M) - Metal Cover.jpeg', '/Images/1750562866_Acer Lite (AL1-14M) - Metal Cover 2.jpeg', '', ' Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i3, Laptop Intel UHD Graphics, Acer Lite, Acer', 'https://www.tokopedia.com/trendcomputerbdg/acer-lite-al1-14m-3mid-magical-color-metal-cover-intel-core-i3-1215u-8-512gb-14-wuxga-ips-win11-office-1731133430735079127?extParam=ivf%3Dfalse%26keyword%3Dacer+lite+%28al1-14m%29+-+metal+cover%26search_id%3D20250516075910E99F3F53DAD4C1334SBJ%26src%3Dsearch&t_id=1747380994320&t_st=23&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : Intel Core i3-1215U Processor (6 Cores, 4.4 Ghz) | Display : 14.0″ WUXGA 1920 x 1200, IPS Acer ComfyView LED-backlit TFT LCD | Memory : 1×8 GB DDR4 (Upgradeable) | Storage : 512GB SSD NVMe Gen3 | Graphics : Intel UHD Graphics | Keyboard : Backlit | Port : 3x USB 3.2 Gen 1, 1x USB Type-C, 1x HDMI port 1.4 with HDCP support | Wireless : Bluetooth 5.1 & Wi-Fi 5 AC | Camera : FHD Camera | Speaker : Two built-in stereo speakers | Material : Metal Top Cover | Battery : 57 Wh | Free : Bagpack | OS : Windows 11 Home & Office Home & Student 2021\r\n', '/Images/1750562866_qr Acer Lite (AL1-14M) - Metal Cover.png', '2025-06-22 10:27:46', 5),
(28, 'asuszenbookduoux8406i7', 'ASUS Zenbook DUO UX8406', 'Intel Core Ultra 7 155H | Intel Arc Graphics | 14\" 3K (2880 x 1800) OLED, 120Hz Refresh Rate | 16GB LPDDR5 | Win 11 + Office Home & Students 2021', 23999000, 0, 'In Stock', '/Images/1750563488_ASUS Zenbook DUO UX8406.jpeg', '/Images/1750563488_ASUS Zenbook DUO UX8406 v2.jpeg', '/Images/1750563488_ASUS Zenbook DUO UX8406 v3.jpeg', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i7, Laptop Intel Arc Graphics, Asus Zenbook, Asus', 'https://www.tokopedia.com/rogonline/asus-zenbook-duo-ux8406-ultra-7-155h-16gb-1tb-ssd-w11-ohs-dual-screen-non-paket-inkwell-gray-41a87?extParam=ivf%3Dfalse%26keyword%3Dasus+zenbook+duo+ux8406%26search_id%3D20250516075818D29076102C25EA24AHUG%26src%3Dsearch&t_id=1747380994320&t_st=22&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : Intel Core Ultra 7 155H, 1.4 GHz (24MB Cache, up to 4.8 GHz, 16 cores, 22 Threads) Intel AI Boost NPU | Graphics : Intel Arc Graphics | Memory : 16GB Soldered LPDDR5 (Dual Channel) | Storage : 1TB M.2 NVMe PCIe 4.0 SSD | Display : 14.0-inch, 3K (2880 x 1800) OLED 16:10 aspect ratio, 0.2ms response time, 120Hz refresh rate, 400nits, 500nits HDR peak brightness, 100% DCI-P3 color gamut, 1,000,000:1, VESA CERTIFIED DisplayHDR True Black 500, 1.07 billion colors, PANTONE Validated, Glossy display, 70% less harmful blue light, Touch screen, Screen-to-body ratio 91%, With stylus support | Keyboard : Soft Keyboard, 1.4mm Key-travel, Precision touchpad | Camera : 1080p FHD camera with IR function to support Windows Hello | Network : Wi-Fi 6E(802.11ax) (Dual band) 2*2 + Bluetooth 5.3 | Battery : 75WHrs, 4S1P, 4-cell Li-ion, TYPE-C, 65W AC Adapter | Operating System : Windows 11 Home Original | Include : Microsoft Office Home Student 2021 Original Life Time | Berat : 1.6 Kg | Durability : US MIL-STD 810H military-grade standard | Audio and Speakers : Smart Amp Technology, Built-in speaker, Built-in array microphone, harman/kardon (Premium), with Cortana support | Security : Trusted Platform Module (TPM) 2.0, Trusted Platform Module (Firmware TPM), IR webcam with Windows Hello support | Ports In / Out : 1x*\r\n', '/Images/1750563488_qr ASUS Zenbook DUO UX8406.png', '2025-06-22 10:38:08', 4),
(29, 'lenovoideapadslim5i', 'Lenovo Ideapad Slim 5i', 'Intel Core 7 240H | Integrated Intel Graphics | 14\" WUXGA (1920x1200) | 2x 8GB SO-DIMM DDR5-5600 | Win 11 + Office Home & Students 2021', 11369000, 0, 'In Stock', '/Images/1750563866_Lenovo Ideapad Slim 5i.jpeg', '/Images/1750563866_Lenovo Ideapad Slim 5i 2.jpeg', '', ' Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i7 , Intel Graphics,Lenovo Ideapad, Lenovo', 'https://www.tokopedia.com/sinamuliamakassar/lenovo-ideapad-slim-5i-i5-13420h-1tb-ssd-16gb-wuxga-oled-win11-ohs-luna-grey-16gb-standar-6d99c?extParam=ivf%3Dfalse%26keyword%3Dlenovo+ideapad+slim+5i%26search_id%3D20250516075652FD92C9BFE763ED00BWLX%26src%3Dsearch&t_id=1747380994320&t_st=21&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : Intel® Core™ i5-13420H, 8C (4P + 4E) / 12T, P-core 2.1 / 4.6GHz, E-core 1.5 / 3.4GHz, 12MB | Graphics : Integrated Intel® UHD Graphics | Chipset : Intel® SoC Platform | Memory : 2x 8GB SO-DIMM DDR5-5600 | Memory Slots : Two DDR5 SO-DIMM slots, dual-channel capable | Max Memory : Up to 32GB DDR5-5600 | Storage : 1TB SSD M.2 2242 PCIe® 4.0x4 NVMe® | Storage Support : Up to two drives, 2x M.2 SSD | Storage Slot : Two M.2 slots (One M.2 2242 PCIe® 4.0 x4 slot, One M.2 2280 PCIe 4.0 x4 slot) | Card Reader : microSD Card Reader | Audio Chip : High Definition (HD) Audio | Speakers : Stereo speakers, 2W x2, Dolby Audio™ optimized | Camera : FHD 1080p + IR with Privacy Shutter, ToF Sensor | Microphone : 2x Array | Battery : Integrated 60Wh | Power Adapter : 65W USB-C® Slim (Wall-mount) | Display : 14\" WUXGA (1920x1200) OLED 400nits Glossy, 100% DCI-P3, DisplayHDR™ True Black 500 | Touchscreen : None | Keyboard : Backlit, English | Touchpad : Buttonless Mylar® surface multi-touch touchpad, 75 x 120 mm (2.95 x 4.72 inches) | Surface Treatment : Anodizing Sandblasting | Case Material : Aluminium (Top), Aluminium (Bottom) | Pen : Pen Not Supported | Dimensions (WxDxH) : 313.4 x 222 x 16.9 mm (12.34 x 8.74 x 0.67 inches) | Weight : Around 1.39 kg (3.06 lbs) | OS : Windows® 11 Home Sin\r\n', '/Images/1750563866_qr Lenovo Ideapad Slim 5i.png', '2025-06-22 10:44:26', 2),
(49, 'acer7pro', 'ACER Aspire 7 Pro A715', 'Intel Core 5 12450H | Intel Arc Graphics | 15,6\" WUXGA (1920 x 1200), 144Hz | 8GB DDR4 SO-DIMM | Win 11 + Office Home & Students 2021', 10489000, 0, 'In Stock', '/Images/1751114950_ACER Aspire 7 Pro A715 (1).jpg', '/Images/1751114950_ACER Aspire 7 Pro A715 (2).jpg', '/Images/1751114950_ACER Aspire 7 Pro A715 (3).jpg', '', 'https://www.tokopedia.com/acer-jakarta/acer-aspire-7-pro-a715-59g-56k7-rtx3050-intel-core-i5-12450h-8-512gb-ssd-windows-11-ohs-15-6-fhd-144hz-black-1730956348146353300?extParam=ivf%3Dfalse%26keyword%3Dacer+gaming+aspire+7+a715-59g-56k7+intel+i5%26search_id%3D2025062713111913F9896DF612793D32RY%26src%3Dsearch&t_id=1751029242384&t_st=2&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : 12th Generation Intel Core i5-12450H Processor | Memory : 8GB DDR4 (1x8GB SO-DIMM) + 1 Slot Kosong | Varian RAM & Storage : 8/512 = 1x8GB DDR4, 1x512GB SSD | 8/1TB = 1x8GB DDR4, 2x512GB SSD | 16/512 = 2x8GB DDR4, 1x512GB SSD | 16/1TB = 2x8GB DDR4, 2x512GB SSD | 32/512 = 2x16GB DDR4, 1x512GB SSD | 32/1TB = 2x16GB DDR4, 2x512GB SSD | (Taruh di Note Pesanan jika mau Request jadi 1 Keping semua (RAM&SSD), pastinya harus sesuai kemampuan laptop juga (Chat Admin terlebih dahulu). Jika tidak ada Note Pesanan, Kami kirim sesuai Konfigurasi Default diatas!) | Storage : 512GB PCIe NVMe M.2 SSD + 1 Slot Kosong | Graphic Card : NVIDIA GeForce RTX 3050 with 6GB of GDDR6 (MGP 75W) | Display : 15.6 inch Full HD IPS (1920 x 1080), 144Hz refresh rate, IPS, 300nits | Keyboard : Single Zone (RGB) | Wifi : Wi-Fi 6 & Bluetooth 5.0 | Camera : 720p | Weight : 2.1kg | Battery : 53Wh | Power Adaptor : 150 W | Ports : 1x HDMI | 2x USB 3.2 Gen 1 Type-A Ports | 2x USB Type C 3.2 Gen2 | 1x RJ45 | 1x Mini DP | 1x Audio Combo Jack | 1x Micro SD', '/Images/1751114950_ACER Aspire 7 Pro A715 (qr).png', '2025-06-28 19:49:10', 3),
(53, 'advanworkprolite', 'Advan WorkPro Lite', 'Intel Core i5 12450H | Intel UHD Graphics | 14\" FHD IPS (1820 x 1090) | 8GB DDR4 | Win 11 Home Original', 4599000, 0, 'In Stock', '/Images/1751115611_Advan WorkPro Lite (1).jpg', '/Images/1751115611_Advan WorkPro Lite (2).jpg', '/Images/1751115611_Advan WorkPro Lite (3).jpg', '', 'https://www.tokopedia.com/advanstore/advan-workpro-lite-intel-core-i5-12450h-14-inch-fhd-ips-8gb-256gb-windows-11-laptop-notebook-upgradeable-1729896008895071978?extParam=ivf%3Dtrue%26keyword%3Dadvan+workprolite%26search_id%3D2025062812590394F6D7E04A4D453D8DHL%26src%3Dsearch&t_id=1751115551445&t_st=1&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Dimension : 322.6 x 210.2 x 19.8 mm | Weight : ≤1.5kg | Display : 14.0\" FHD IPS 1920 x 1080 | CPU : Intel® Core i5-12450H | GPU : Intel® UHD Graphics | Memory : 8GB DDR4 (UPGRADEABLE) | Storage : 256GB PCIe 3.0 (UPGRADEABLE) | Camera : 720 HD with privacy shutter | Wifi : 802.11b/g/n/ac | Bluetooth : 5.1 | Battery : 7.6V / 6000mAh / 45.6Wh | Port Variants : 1x Charging Ø3.5 x 1.35mm | 1x Type C (DP, PD, USB3.2 GEN 1) | 1x Standard HDMI 1.4 | 1x Audio Ø3.5mm Combo | 1x TF card | 1x Kensington Lock | 1x USB 2.0 | Free : WINDOWS 11 HOME ORIGINAL', '/Images/1751115611_Advan WorkPro Lite (qr).png', '2025-06-28 20:00:11', 3),
(56, 'asusrogflow', 'Asus ROG FLOW Z13', 'AMD Ryzen AI MAX + 395 | AMD XDNA | 13,4\" 2.5K (2560 x 1600) | 32GB LPDDR5X | Win 11 + Office Home 2024 + Microsoft 365 Basic', 35999000, 0, 'In Stock', '/Images/1751116386_Asus ROG FLOW Z13 (1).jpg', '/Images/1751116386_Asus ROG FLOW Z13 (2).jpg', '/Images/1751116386_Asus ROG FLOW Z13 (3).jpg', '', 'https://www.tokopedia.com/asusrogindonesia/asus-rog-flow-z13-gz302ea-touch-ryzen-ai-max-395-32gb-1tb-w11-ohs-13-4-2-5k-180hz-pen-2in1-blk-rza86n6g-hm-1730868359454033546?extParam=ivf%3Dfalse%26keyword%3Dasus+flow%26search_id%3D2025062714005863923F49E52413049P3D%26src%3Dsearch&t_id=1751029242384&t_st=45&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Sistem Operasi: Windows 11 Home | Prosesor: AMD Ryzen AI MAX+ 395 Processor 3.0GHz (80MB Cache, up to 5.1GHz, 16 cores, 32 Threads); AMD XDNA NPU up to 50TOPS | Neural Processor: AMD XDNA NPU up to 50TOPS | Tampilan: ROG Nebula Display, 13.4-inch, 2.5K (2560 x 1600, WQXGA), 16:10 aspect ratio, IPS-level, Glossy display, DCI-P3: 100%, Refresh Rate: 180Hz, Adaptive-Sync, Pantone Validated, Support Dolby Vision HDR: Yes | Memori: 32GB LPDDR5X 8000 on board (Max Capacity: 32GB) | Penyimpanan: 1TB PCIe 4.0 NVMe M.2 SSD (2230) | Expansion Slots: 1x M.2 PCIe | Port I/O: 1x 3.5mm Combo Audio Jack | 1x HDMI 2.1 FRL | 1x USB 3.2 Gen 2 Type-A | 2x Type-C USB 4 (support DisplayPort / power delivery, up to 40Gbps) | 1x microSD card reader (UHS-II) | Keyboard dan Touchpad: Backlit Chiclet Keyboard 1-Zone RGB | Kamera: 13MP camera and 5MP IR camera | Audio: Smart Amp Technology, Dolby Atmos, Hi-Res certification (for headphone), Built-in 3-microphone array, 2x 2W dual-force with Smart Amp Technology | Jaringan dan Komunikasi: Wi-Fi 7 (802.11be) Triple band 2x2 + Bluetooth 5.4 (versi dapat berubah tergantung OS) | Baterai: 70WHrs, 4S1P, 4-cell Li-ion | Suplai Daya: Rectangle Conn 200W AC Adapter (20V DC, 10A), TYPE-C 100W AC Adapter (20V DC, 5A) | AURA SYNC: Yes | Lampu Perangkat: Aura Sync Light Bar | Berat: 1.20 Kg (2.65 lbs) | Dimensi: 30.0 x 20.4 x 1.29 ~ 1.49 cm (11.81\" x 8.03\" x 0.51\" ~ 0.59\") | Microsoft Office: Microsoft Office Home 2024 + Microsoft 365 Basic', '/Images/1751116386_Asus ROG FLOW Z13 (qr).png', '2025-06-28 20:13:06', 1),
(58, 'axioomybookhype5', 'Axioo MyBook Hype 5', 'Ryzen 5 7430U | Radeon Vega 7 | 14\" FHD (1920 x 1080) | 8GB DDR4 | Win 11', 5299000, 0, 'In Stock', '/Images/1751116936_Axioo MyBook Hype 5 (1).jpg', '/Images/1751116936_Axioo MyBook Hype 5 (2).jpg', '/Images/1751116936_Axioo MyBook Hype 5 (3).jpg', '', 'https://www.tokopedia.com/laptopmurahid/axioo-hype-5-ryzen-5-7430u-16gb-1tb-ssd-14-fhd-ips-w11pro-office-1731132495851455766?extParam=ivf%3Dfalse%26keyword%3Daxioo+mybook+hype+5%26search_id%3D2025062714174234ED066DF378EF0FCHU2%26src%3Dsearch&t_id=1751029242384&t_st=50&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: AMD Ryzen 5 7430U (6C / 12T, 2.3 / 4.3GHz, 3MB L2 / 16MB L3) | RAM: 8GB/16GB DDR4 (2x SODIMM DDR4 Up to 64GB Dual Channel, Frequency Up to 3200MHz) | Storage: 256 / 512 / 1TB M.2 NVMe PCIe Gen. 3 x4 | VGA: AMD Radeon RX Vega 7 | Display: 14″ FHD (1920x1080) IPS | Sistem Operasi: Windows 11 PRO ORIGINAL PERMANEN | Warna: Grey / Blue | Kamera: 2MP | Audio: Stereo | Antarmuka: 2x USB 3.2 Gen1 type A port | 1x USB 2.0 port | 1x USB 3.0 Type C port (Full Function: Data, Power, Video) | 1x 3.5mm 2-in-1 Audio Combo Jack | 1x HDMI 1.4 output port | 1x DC-in jack port | Keyboard: Backlit | Bluetooth: 5.1 | WLAN: Wi-Fi 5 Realtek 8822CE ac/b/g/n | Battery: 45.6Wh | Adapter: 65W AC Adapter | Dimensi: 322 x 206 x 19.4mm | Berat: 1.41kg', '/Images/1751116936_Axioo MyBook Hype 5 (qr).png', '2025-06-28 20:22:16', 2),
(59, NULL, 'Lenovo Ideapad', '', 3000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Masuk', NULL, '2025-07-26 21:02:31', 1),
(999, NULL, 'Laptop Mid', '', 6500000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Performa seimbang', NULL, '2025-07-28 10:53:26', 1),
(1000, NULL, 'Laptop Pro Max', '', 6000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Spesifikasi tinggi', NULL, '2025-07-28 10:51:07', 1);

--
-- Triggers `best_seller`
--
DELIMITER $$
CREATE TRIGGER `after_delete_produk` AFTER DELETE ON `best_seller` FOR EACH ROW BEGIN
    INSERT INTO log_aktivitas_produk (
        aksi, id_produk, nama_produk, harga, keterangan
    )
    VALUES (
        'HAPUS PRODUK',
        OLD.id,
        OLD.title,
        OLD.price,
        'Produk telah dihapus dari sistem'
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_produk` AFTER INSERT ON `best_seller` FOR EACH ROW BEGIN
    INSERT INTO log_aktivitas_produk (
        aksi, id_produk, nama_produk, harga, keterangan
    )
    VALUES (
        'TAMBAH PRODUK',
        NEW.id,
        NEW.title,
        NEW.price,
        'Produk baru ditambahkan ke daftar best seller'
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_produk` AFTER UPDATE ON `best_seller` FOR EACH ROW BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO log_aktivitas_produk (
            aksi, id_produk, nama_produk, harga, keterangan
        )
        VALUES (
            'UPDATE HARGA',
            NEW.id,
            NEW.title,
            NEW.price,
            CONCAT('Harga lama: Rp', OLD.price, ', Harga baru: Rp', NEW.price)
        );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id_category` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id_category`, `name`) VALUES
(1, 'gaming'),
(2, 'workstation'),
(3, 'students'),
(4, 'video editing'),
(5, 'business');

-- --------------------------------------------------------

--
-- Table structure for table `log_aktivitas_produk`
--

CREATE TABLE `log_aktivitas_produk` (
  `id_log` int(11) NOT NULL,
  `aksi` varchar(50) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `nama_produk` varchar(255) DEFAULT NULL,
  `harga` bigint(20) DEFAULT NULL,
  `waktu` datetime DEFAULT current_timestamp(),
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_aktivitas_produk`
--

INSERT INTO `log_aktivitas_produk` (`id_log`, `aksi`, `id_produk`, `nama_produk`, `harga`, `waktu`, `keterangan`) VALUES
(1, 'UPDATE HARGA', 18, 'MSI Katana 15 B13VFK 1850ID', 20049000, '2025-07-26 21:15:47', 'Harga lama: Rp19999000, Harga baru: Rp20049000'),
(2, 'TAMBAH PRODUK', 999, 'Lenovo Ideapad', 5000000, '2025-07-26 21:23:16', 'Produk baru ditambahkan ke daftar best seller'),
(3, 'HAPUS PRODUK', 999, 'Lenovo Ideapad', 5000000, '2025-07-26 21:29:55', 'Produk telah dihapus dari sistem'),
(4, 'TAMBAH PRODUK', 1000, 'Laptop Pro Max', 6000000, '2025-07-28 10:51:07', 'Produk baru ditambahkan ke daftar best seller'),
(5, 'TAMBAH PRODUK', 999, 'Laptop Mid', 6500000, '2025-07-28 10:53:26', 'Produk baru ditambahkan ke daftar best seller');

-- --------------------------------------------------------

--
-- Table structure for table `on_sale`
--

CREATE TABLE `on_sale` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `specs` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `old_price` decimal(10,2) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `image_1` varchar(255) DEFAULT NULL,
  `image_2` varchar(255) DEFAULT NULL,
  `image_3` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `buy_link` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `on_sale`
--

INSERT INTO `on_sale` (`id`, `slug`, `title`, `specs`, `price`, `old_price`, `status`, `image_1`, `image_2`, `image_3`, `category`, `buy_link`, `description`, `qr_code`, `created_at`, `id_category`) VALUES
(3, '1', 'MSI VECTOR 16HX', 'Intel Core Ultra 9 processor 275HX | RTX 5080 | 16″ QHD+ (2560×1600), 240Hz Refresh Rate | 16GB (8GB*2 DDR5-5600), Max 96GB', 40988000.00, 60000000.00, 'In Stock', '/Images/1750565059_MSI VECTOR 16HX AI (1).jpg', '/Images/1750565059_MSI VECTOR 16HX AI (2).jpg', '', 'Laptop, Laptop By Brand, Laptop By AMD, Laptop Ryzen, Laptop Intel I9, MSI Modern, MSI', 'https://www.tokopedia.com/gameridos/msi-vector-16hx-ai-ultra-9-275hx-rtx5080-16gb-ram-16gb-ssd-1tb-w11-ohs-16-qhd-240hz-100dcip3-24zrgb-1730920466065163873?extParam=ivf%3Dfalse%26keyword%3Dmsi+vector+16hx%26search_id%3D20250622035608B2EB73490357542F6ONX%26src%3Dsearch&t_id=1750564580451&t_st=3&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Spesifikasi: Processor: Intel Core Ultra 9 275HX, 24C (8P + 16E) / 24T, Max Turbo up to 5.4GHz, 36MB | RAM: 16GB DDR5-6400MHz (2 slot) | Storage: 1 TB M.2 SSD NVMe PCIe Gen 4 (2 slot) | VGA: NVIDIA GeForce RTX 5080 Laptop GPU 16GB GDDR7 powers advanced AI with 1334 AI TOPS, TGP 175W | Display: 16” QHD+ (2560x1600), 240Hz, IPS-Level | Sistem Operasi: Windows 11 Home 64bit + Office Home & Student 2021 | Warna: Cosmos Gray | Kamera: IR FHD type (30fps@1080p) with HDR | Audio: 2x 2W Speaker | Antarmuka: 2x Thunderbolt 5 (DisplayPort/ Power Delivery 3.1), 2x Type-A USB3.2 Gen2, 1x SD Express Card Reader, 1x HDMI 2.1 (8K @ 60Hz / 4K @ 120Hz), 1x RJ45, 1x Mic-in/Headphone-out Combo Jack | Keyboard: 24-Zone RGB Gaming Keyboard with Copilot Key | Bluetooth: 5.4 | WLAN: Wi-Fi 7 11be, 2x2 | Battery: Integrated 90Wh | Adapter: 330 W Smart AC | Dimensi: 357 x 284 x 22.20-28.55 mm | Berat: 2.7 kg | Kelengkapan Unit: Unit Laptop, Charger, Kartu Garansi, Box / Dus Laptop, Tas Laptop', '/Images/1750565059_download.png', '2025-06-22 04:04:19', 1),
(4, '3', 'Lenovo Yoga Slim 7 Aura Edition', 'Intel Core Ultra 5 processor 226V | Intel Arc Graphics 130V | 14″ 2.8K OLED (2880×1800), 120Hz Refresh Rate | 16GB LPDDR5x-8533', 16799000.00, 17999000.00, 'In Stock', '/Images/1750565903_Lenovo Yoga Slim 7 1.png', '/Images/1750565903_Lenovo Yoga Slim 7 2.png', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i5 , Intel Graphics, Lenovo Ideapad, Lenovo', 'https://www.tokopedia.com/distrilapid/lenovo-yoga-slim-7-aura-edition-ultra-5-226v-intel-arc-16gb-512gb-14-2-8k-oled-1731287857740416525?extParam=ivf%3Dtrue%26keyword%3Dlenovo+yoga+slim+7%26search_id%3D202506220408526C524F9D5D70272D2C43%26src%3Dsearch&t_id=1750564580451&t_st=4&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Spesifikasi: Processor: Intel Core Ultra 5 226V, 8C (4P + 4LPE) / 8T, Max Turbo up to 4.5GHz, 8MB | NPU: Intel AI Boost, up to 40 TOPS | Graphics: Intel Arc Graphics 130V | Memory: 16GB Soldered LPDDR5x-8533 | Storage: 512GB SSD M.2 2242 PCIe 4.0x4 NVMe, up to 1TB M.2 2242 SSD | Display: 14\" 2.8K WQXGA+ (2880x1800) OLED, 1100nits (peak) / 500nits (typical), Glossy / Anti-fingerprint, 100% DCI-P3, 120Hz, Eyesafe, Dolby Vision, DisplayHDR True Black 1000, Glass, Touch, X-Rite, PureSight Pro | Audio Chip: HD Audio, SoundWire, Cirrus Logic CS42L43 codec | Speakers: 4 stereo speakers, 2W x2 (woofers), 2W x2 (tweeters), Dolby Atmos, Smart AMP | Camera: 5.0MP + IR with E-shutter | Microphone: 4x, Array | Battery: Integrated 70Wh | Power Adapter: 65W USB-C Slim (2-pin, Wall-mount) | Dimensions: 312 x 219.3 x 13.9 mm | Weight: Starting at 1.28 kg | WLAN + Bluetooth: Wi-Fi 7 802.11be 2x2 + BT 5.4\r\n\r\n', '/Images/1750565903_download (1).png', '2025-06-22 04:18:23', 2),
(5, '44', 'Asus ExpertBook P1 P1403CVA', 'Intel Core i5-13500H | Intel UHD Graphics | 14″ FHD (1920×1080), 300nits, Anti-glare | 8GB DDR5, Max 64GB', 8549000.00, 8799000.00, 'In Stock', '/Images/1750566658_Asus ExpertBook P1 P1403CVA 1.png', '/Images/1750566658_Asus ExpertBook P1 P1403CVA 2.png', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i5, Laptop RTX, Asus ROG, Asus', 'https://www.tokopedia.com/itgaleri/asus-expertbook-p1403cva-s65850ws-intel-core-i5-13500h-8gb-512gb-14-0-fhd-vips-win11-ohs2021-misty-grey-1730787850226468806?extParam=ivf%3Dfalse%26keyword%3Dasus+expertbook+p1+p1403cva-s65850ws%26search_id%3D20250622042304577BCC914F9E55328CJK%26src%3Dsearch&t_id=1750564580451&t_st=5&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Core i5-13500H 2.6 GHz (18MB Cache, up to 4.7 GHz, 12 cores, 16 Threads) | Graphics: Intel UHD Graphics | Display: 14.0-inch FHD (1920 x 1080), 16:9, Wide view, Anti-glare, LED Backlit, 300nits, NTSC 45%, Screen-to-body ratio 87% | Memory: 8GB DDR5 SO-DIMM, Max up to 64GB | Storage: 512GB M.2 2280 NVMe PCIe 4.0 SSD | Ports: 2x USB 3.2 Gen 1 Type-A, 2x USB 3.2 Gen 2 Type-C (support display/power delivery), 1x 3.5mm Combo Audio Jack | Wireless: Wi-Fi 6 (802.11ax) Dual Band 2x2 + Bluetooth 5.3 | Battery: 42WHrs 3-cell Li-ion + 50WHrs 3-cell Li-ion, Long life rechargeable lithium polymer | Adapter: TYPE-C 65W AC Adapter (20V DC, 3.25A, Input: 100~240V AC 50/60Hz) | Weight: 1.40 kg (3.09 lbs) | Durability: US MIL-STD 810H military-grade standard | Security: HDD User Password Protection, BIOS Boot/User Password, TPM 2.0, Absolute Persistence 2.0 (Computrace), Fingerprint sensor integrated with Touchpad, Kensington Nano Security Slot (6x 2.5mm) | OS: Windows 11 Home + Office Home Student 2021 | Warranty: 3 Years\r\n\r\n', '/Images/1750566658_download (2).png', '2025-06-22 04:30:58', 3),
(6, '22', 'Acer Nitro Lite NL16 71G', 'Intel Core i7-13620H | NVIDIA GeForce RTX 2050 4GB GDDR6 | 16″ WUXGA (1920×1200), 180Hz, 100% sRGB | 16GB DDR5, Max Upgradeable | 512GB SSD NVMe', 12999000.00, 19499000.00, 'In Stock', '/Images/1750567231_Acer Nitro Lite NL16 71G 74MV 1.png', '/Images/1750567231_Acer Nitro Lite NL16 71G 74MV 2.png', '', 'Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop RTX, Acer Nitro,', 'https://www.tokopedia.com/acerstoreofficial/acer-nitro-lite-gaming-nl16-71g-74mv-16-intel-core-i7-13620h-rtx2050-ram-16-gb-512gb-ssd-windows-11-1731357142956213688?extParam=ivf%3Dfalse%26keyword%3Dacer+nitro+lite+nl16+71g%26search_id%3D20250622043246F9B902FC3289AF0773O3%26src%3Dsearch&t_id=1750564580451&t_st=6&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Spesifikasi: Processor: Intel Core i7-13620H Processor (24MB Cache, up to 4.90 GHz) | OS: Windows 11 Home | Memory: 16GB DDR5 (8+8) | Storage: 512GB SSD NVMe | Display: 16\" WUXGA LED IPS, 180Hz, 100% sRGB | Graphics: NVIDIA GeForce RTX 2050 with 4GB GDDR6 | Include: Office Home 2024 | I/O Ports: 1x USB Type-C (USB 3.2 Gen 2 up to 10Gbps, Thunderbolt 4, USB charging 5V 3A, DC-in 20V 65W), 2x USB Standard-A (USB 3.2 Gen 1, 1 with power-off USB charging) | 1x 3.5mm headphone/speaker jack (with mic support) | 1x HDMI 2.1 with HDCP support | 1x Ethernet (RJ-45)', '/Images/1750567231_qr code.png', '2025-06-22 04:40:31', 4),
(7, '67', 'HP OmniBook X 14 FE0333QU', 'napdragon® X Elite X1E-78-100 | Qualcomm® Adreno™ GPU | 14″ 2.2K Touchscreen (2240×1400), IPS, 100% sRGB, 300 nits | 16GB LPDDR5x | 1TB SSD NVMe', 18799000.00, 23999000.00, 'In Stock', '/Images/1750567707_HP OmniBook X 14 FE0333QU 1.png', '/Images/1750567707_HP OmniBook X 14 FE0333QU  2.png', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i5, Laptop Intel Iris Graphics, HP 14S, HP', 'https://www.tokopedia.com/sinarmulia/hp-omnibook-x-14-fe0333qu-snapdragon-x-elite-1tb-ssd-16gb-2-2k-ips-touch-100-srgb-win11-ohs-1730916689842046122?extParam=ivf%3Dfalse%26keyword%3Dhp+omnibook+x+14+fe0333qu%26search_id%3D20250622044304320722549D1751272EFF%26src%3Dsearch&t_id=1750564580451&t_st=7&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Operating System: Windows 11 Home Single Language | Processor: Snapdragon® X Elite X1E-78-100 (up to 3.4 GHz, 12 cores) | Processor Generation: Snapdragon® X Elite | Chipset: Qualcomm® integrated SoC | Memory: 16GB LPDDR5x-8448 MT/s (onboard) | Storage: 1TB PCIe® NVMe™ M.2 SSD | Display: 14\" 2.2K (2240 x 1400), multitouch-enabled, IPS, edge-to-edge glass, Corning® Gorilla® Glass NBT™, Low Blue Light, 300 nits, 100% sRGB, 16:10, micro-edge, flicker-free | Graphics: Qualcomm® Adreno™ GPU | Audio: Dual speakers, HP Audio Boost, Poly Studio | Keyboard: Full-size backlit soft grey | Pointing Device: HP Imagepad | Webcam: 5MP IR camera with temporal noise reduction & dual array mics | Wireless: Qualcomm® FastConnect™ 7800 Wi-Fi 7 (2x2) + Bluetooth® 5.4 | Ports: 1x USB-A 10Gbps (HP Sleep and Charge), 1x USB-C 10Gbps (PD, DisplayPort 1.4a, Sleep and Charge), 1x USB-C 40Gbps (PD, DisplayPort 1.4a, Sleep and Charge), 1x 3.5mm combo audio jack | Battery: 3-cell, 59Wh Li-ion polymer | Adapter: 65W USB-C power adapter | Security: TPM (Firmware TPM), camera privacy shutter, mic mute key | Cloud Service: 25 GB Dropbox for 12 months | Dimensions: 31.29 x 22.35 x 1.43–1.44 cm | Weight: 1.34 kg', '/Images/1750567707_HP OmniBook X 14 FE0333QU 3.png', '2025-06-22 04:48:27', 5),
(8, '54', 'MSI Prestige 16 B1VEG', 'Intel Core Ultra 7 155H | RTX 4050 6GB | 16″ QHD+ (2560×1600), 100% DCI-P3 | 32GB LPDDR5 | 1TB SSD PCIe Gen4', 26699000.00, 28999000.00, 'In Stock', '/Images/1750568141_MSI Prestige 16 B1VEG 1.jpg', '/Images/1750568141_MSI Prestige 16 B1VEG 2.jpg', '', ' Laptop, Laptop By Brand, Laptop By AMD, Laptop Ryzen, Laptop Ryzen 7, MSI Modern, MSI', 'https://www.tokopedia.com/msi-indonesia/msi-prestige-16-ai-studio-b1veg-ultra-7-155h-rtx4050-32gb-1tb-w11-ohs-16-0-qhd-ips?extParam=ivf%3Dfalse%26keyword%3Dmsi+prestige+16+b1veg%26search_id%3D20250622045043357A6FDF7642BF10426G%26src%3Dsearch&t_id=1750564580451&t_st=8&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Spesifikasi: Processor: Intel Core Ultra 7 155H with Intel AI Boost (NPU), 16 cores (6P + 8E + 2LPE), up to 4.8 GHz | Display: 16″ QHD+ (2560×1600), IPS-Level, 100% DCI-P3 (Typical) | Memory: 32GB LPDDR5-6400 | Storage: 1TB NVMe SSD PCIe Gen4 | Graphics: NVIDIA GeForce RTX 4050 Laptop GPU 6GB GDDR6 | Keyboard: Single Backlit (White) + Fingerprint | Wireless: Intel Killer Wi-Fi 7 BE1750, Bluetooth 5.4 | Ports: 1x USB-C (USB/DP/Thunderbolt 4, PD3.1), 1x USB-C (USB3.2 Gen2/DP, PD), 1x USB-A USB3.2 Gen2, 1x SD (XC/HC) Card Reader, 1x HDMI 2.1 (8K@60Hz / 4K@120Hz), 1x RJ45, 1x Mic-in/Headphone-out Combo Jack | Webcam: IR FHD (30fps@1080p) | Audio: 2x 2W Speakers | Battery: 4-Cell 99.9Whr | Color: Stellar Gray | SKU: 9S7-15A211-223 | Free: Topload Bag | OS: Windows 11 Home + Office Home & Student 2021 | Garansi: Resmi MSI 2 Tahun\r\n\r\n', '/Images/1750568141_MSI PRESTIGE 16 AI STUDIO.png', '2025-06-22 04:55:41', 5),
(9, '43', 'MSI Stealth 16 AI+ A3HVGG', 'Ryzen AI 9 HX 370 | RTX 4070 8GB | 16″ QHD+ 240Hz, 100% DCI-P3 | 32GB LPDDR5x | 1TB SSD Gen4 ', 30899000.00, 38999000.00, 'In Stock', '/Images/1750568702_MSI Stealth 16 AI+ A3HVGG 1.png', '/Images/1750568702_MSI Stealth 16 AI+ A3HVGG 2.png', '', 'Laptop, Laptop By Brand, Laptop By AMD, Laptop Ryzen, Laptop Ryzen 9, MSI Modern, MSI', 'https://www.tokopedia.com/gateway/msi-stealth-a16-ai-a3hvgg-ryzen-ai-9-365-rtx4070-32gb-1tb-ssd-16-0-wqxga-240hz-100dcip3-non-bundling-38cdf?extParam=ivf%3Dfalse%26keyword%3Dmsi+stealth+16+ai%2B+a3hvgg%26search_id%3D20250622050007496E05E1AEA0A93BERRL%26src%3Dsearch&t_id=1750564580451&t_st=10&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', ' Processor: AMD Ryzen AI 9 HX 370 with up to 50 NPU TOPS (80 total AI TOPS) | VGA: NVIDIA GeForce RTX 4070 Laptop GPU 8GB GDDR6, up to 1980MHz Boost Clock, 105W Max Graphics Power, 321 AI TOPS | Memory: 32GB LPDDR5x-7500 (Max 64GB) | Storage: 1TB NVMe PCIe Gen4x4 SSD, 2x M.2 SSD slot (PCIe Gen4) | Display: 16\" QHD+ (2560×1600), 240Hz, IPS-Level | OS: Windows 11 Home + Microsoft Office Home and Student 2021 | Ports: 1x USB-C (USB4 / DisplayPort / PD 3.0 / Thunderbolt 4 compatible), 2x USB-A USB3.2 Gen2, 1x HDMI 2.1 (8K @ 60Hz / 4K @ 120Hz), 1x RJ45, 1x Mic-in/Headphone-out Combo Jack | Camera: IR FHD (30fps@1080p) with HDR | Keyboard: Per-Key RGB Gaming Keyboard | Battery: 4-cell, 99.9Whr | Adapter: 240W | Network: Wi-Fi 7 (802.11be) + Bluetooth 5.4 | Audio: 2x 2W Speaker, 4x 2W Woofer | SKU: MSI STEALTH A16 AI+ -A3HVGG.055 | Garansi: 2 Tahun Resmi', '/Images/1750568702_MSI Stealth 16 AI+ A3HVGG 3.png', '2025-06-22 05:05:02', 4),
(10, '23', 'Acer Aspire Lite 14 AL1', 'Intel N150 | Intel UHD Graphics | 14″ WUXGA IPS Matte | 8GB LPDDR5 | 256/512GB SSD | Windows 11 + OHS', 4899000.00, 6499000.00, 'In Stock', '/Images/1750569089_Acer Aspire Lite 14 AL14 1.png', '/Images/1750569089_Acer Aspire Lite 14 AL14 2.png', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i3, Laptop Intel UHD Graphics, Acer Lite,', 'https://www.tokopedia.com/acer-moi/acer-aspire-lite-14-intel-n150-8gb-512gb-ssd-w11-ohs2021-14-0wuxga-blue-al14-32p-c6cc-c1es-1731535070773937778?extParam=ivf%3Dfalse%26keyword%3Dacer+aspire+lite+14+al1%26search_id%3D202506220506378E98D81F8217303DBO6R%26src%3Dsearch&t_id=1750564580451&t_st=11&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', ' Processor: Intel N150, Quad-core (4 Core), Turbo up to 3.60 GHz, 6MB Cache | Graphics: Intel UHD Graphics | Memory: 8GB LPDDR5 | Storage: 256GB / 512GB SSD NVMe Gen3 | Display: 14\" WUXGA (1920x1200), LCD ComfyView (Matte), IPS, 35.6 cm | Audio: 2x Speaker | OS: Windows 11 Home + Office Home Student | Keyboard: Chicklet Keyboard | Built-in Devices: Microphone, Webcam | Ports: 1x USB-C (USB 3.2 Gen 1, 5 Gbps, 5V/3A charging), 1x USB-C (USB 2.0), 1x USB-A (USB 3.2 Gen 1) | Keterangan Varian: Unit Only (laptop + backpack), P.Antigores (antigores layar + body + cleaning kit), P.Aksesoris (mouse wireless + mousepad + sleeve case), P.Antigores+Acc (paket lengkap)\r\n\r\n', '/Images/1750569089_Acer Aspire Lite 14 AL1 3.png', '2025-06-22 05:11:29', 3),
(11, '41', 'HP Victus 15 FA2717TX', 'Intel Core i5-13420H | RTX 4050 6GB | 15.6″ FHD 144Hz IPS | 16GB DDR4 | 512GB SSD ', 14399000.00, 16399999.00, 'In Stock', '/Images/1750569479_HP Victus 15 FA2717TX 1.png', '/Images/1750569479_HP Victus 15 FA2717TX 2.png', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i5, Laptop Intel Iris Graphics, HP 14S, HP', 'https://www.tokopedia.com/amtitstore/hp-victus-15-fa2717tx-core-i5-13420h-16gb-512gb-ssd-rtx-4050-15-6-fhd-win11-ohs-1731403638564882055?extParam=ivf%3Dfalse%26keyword%3Dhp+victus+15+fa2717tx%26search_id%3D2025062205125982CEC96096D4281FFQ3N%26src%3Dsearch&t_id=1750564580451&t_st=12&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Core i5-13420H (up to 4.6 GHz with Intel Turbo Boost, 12MB L3 cache, 8 cores, 12 threads) | Display: 15.6\" FHD (1920x1080), IPS, 144Hz, 9ms response time, anti-glare, micro-edge, 300nits, 45% NTSC | Memory: 16GB DDR4-3200MHz, Upgradeable | Storage: 512GB PCIe NVMe SSD | Graphics: NVIDIA GeForce RTX 4050 Laptop GPU 6GB | Keyboard: 1-Zone RGB Backlit Keyboard | Wireless: MediaTek Wi-Fi 6 MT7921 (2x2) + Bluetooth 5.3 | Ports: 1x USB-A (5Gbps), 1x USB-A (5Gbps, HP Sleep and Charge), 1x USB-C (5Gbps, DisplayPort 1.4, Sleep and Charge), 1x HDMI 2.1, 1x RJ-45, 1x AC Smart Pin, 1x 3.5mm Combo Audio Jack, 1x Multi-format SD Card Reader | Camera: 1080p FHD TNR | Audio: Audio by B&O, Dual Speakers, HP Audio Boost | Battery: 4-cell, 52.5 Wh Li-ion Polymer | Adapter: 200W Smart AC | OS: Windows 11 Home + Office Home & Student 2024 + Microsoft 365 (1 Tahun) | Warna: Mica Silver | SKU: 15-fa2717TX (B7WA7PA) | Garansi: Resmi HP 2 Tahun + ADP', '/Images/1750569479_HP Victus 15 FA2717TX 3.png', '2025-06-22 05:17:59', 2),
(12, '11', 'ASUS TUF F16 FX607VU', 'i7-13620H | RTX 4050 6GB | 16\" FHD+ 165Hz | 16GB DDR5 | 512GB SSD Gen4 | MUX Switch ', 20499000.00, 21999000.00, 'In Stock', '/Images/1750569901_ASUS TUF F16 FX607VU 1.png', '/Images/1750569901_ASUS TUF F16 FX607VU 2.png', '/Images/1750569901_ASUS TUF F16 FX607VU 3.png', 'Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop Ryzen 7, Laptop RTX, Asus TUF, Asus', 'https://www.tokopedia.com/asusrogindonesia/asus-tuf-gaming-f16-fx607vu-i745j6m-hm-mecha-gray-intel-core-i7-13620h-nvidia-geforce-rtx-4050-16gb-512gb-16inch-win11-ohs24-m365-1731307251852019338?extParam=ivf%3Dfalse%26keyword%3Dasus+tuf+f16+fx607vu%26search_id%3D2025062205192734ED066DF378EF066O5U%26src%3Dsearch&t_id=1750564580451&t_st=13&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Display: 16\" FHD+ (1920x1200), 16:10, WUXGA, 165Hz, IPS-Level, 300nits, Anti-glare, 100% sRGB | CPU: Intel Core i7-13620H (13th Gen, 2.4 GHz up to 4.9 GHz, 10 cores: 6P + 4E, 24MB Cache) | GPU: NVIDIA GeForce RTX 4050 Laptop GPU, 6GB GDDR6, MUX Switch + NVIDIA Advanced Optimus, 194 AI TOPs, TGP 140W (2420MHz Boost Clock) | Memory: 16GB DDR5-5200 (2x SO-DIMM, Max 64GB) | Storage: 512GB PCIe 4.0 NVMe M.2 SSD, 2x M.2 PCIe slots | Keyboard: Backlit Chiclet 1-Zone RGB with Copilot Key | Webcam: 720p HD Camera | Speaker: 2-speaker system | Wireless: Wi-Fi 6 (802.11ax) Dual Band 2x2 + Bluetooth 5.3 | Audio: AI noise-canceling, Dolby Atmos, Hi-Res certification, Microsoft Cortana (support suspended) | Ports: 1x RJ45 LAN, 1x Thunderbolt 4 (DisplayPort, 40Gbps), 1x USB 3.2 Gen 2 Type-C (DP, PD, G-SYNC, 10Gbps), 2x USB 3.2 Gen 1 Type-A (5Gbps), 1x HDMI 2.1 FRL | Battery: 56WHrs, 4-cell Li-ion | Adapter: 240W AC Adapter (20V DC, 12A) | Dimensi: 35.4 x 25.1 x 2.21 ~ 2.67 cm | Berat: 2.20 kg | OS & Garansi: Windows 11 Home, Garansi Global 2 Tahun (1 Tahun Perfect Warranty)\r\n\r\n', '/Images/1750569901_ASUS TUF F16 FX607VU 4.png', '2025-06-22 05:25:01', 1),
(50, 'acerswiftgo14', 'Acer Swift GO 14 OLED SFG14', 'Intel Core Ultra 7 155H | Intel Arc Graphics | 14\" WUXGA (2880 x 1800) | 16 LPDDR5X Dual Channel Memory | Win 11 + Office Home 2021', 13449000.00, 14999000.00, 'In Stock', '/Images/1751115124_Acer Swift GO 14 OLED SFG14 (1).jpg', '/Images/1751115124_Acer Swift GO 14 OLED SFG14 (2).jpg', '/Images/1751115124_Acer Swift GO 14 OLED SFG14 (3).jpg', '', 'https://www.tokopedia.com/acer-moi/acer-swift-go-14-ai-ultra-7-155h-evo-16gb-1tb-srgb100-2-8k-w11-ohs2021-sfg14-73-75ws-1731237716558055026?extParam=ivf%3Dfalse%26keyword%3Dacer+swift+go+14+oled+sfg14%26search_id%3D2025062713182034ED066DF378EF36518B%26src%3Dsearch&t_id=1751029242384&t_st=3&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : Intel Core Ultra 7 processor 155H with AI Boost | Graphics : Intel Arc Graphics (8 Xe Cores, 2.25 GHz) | OS : Windows 11 Home | Memory : 16GB LPDDR5X Dual Channel Memory | Storage : 512GB/1TB SSD NVMe Gen4 (2 slot for upgrade) | Features : QHD AI Camera, Killer Wifi 7, Windows Copilot | Display : 14.0″ 2.8K (2880 x 1800), IPS Display, 16:10, sRGB 100%, high-brightness (300nits), Acer ComfyView LED-backlit TFT LCD, Wide viewing angle up to 170 degrees', '/Images/1751115124_Acer Swift GO 14 OLED SFG14 (qr).png', '2025-06-28 12:52:04', 1),
(54, 'hp245g10', 'HP 245 G10 ', 'AMD Ryzen 5 7520U | AMD Radeon Graphics | 14.1\" FHD | 8 GB DDR4-3200 | Win 11 + Office Home Original', 6749000.00, 9890000.00, 'In Stock', '/Images/1751115825_HP 245 G10 (1).jpeg', '/Images/1751115825_HP 245 G10 (2).jpeg', '/Images/1751115825_HP 245 G10 (3).jpeg', '', 'https://www.tokopedia.com/hp/laptop-hp-245-g10-ryzen-5-radeon-8gb-ram-512gb-ssd-windows-11-14-inch-amd-garansi-1-tahun-official-1730423503403124611?extParam=ivf%3Dfalse%26keyword%3Dhp+245+g10%26search_id%3D20250628031651CAF1A3DFB505FF1C2HAY%26src%3Dsearch&t_id=1751029242384&t_st=52&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', '*Operating System: Windows 11 Home Single Language – HP recommends Windows 11 Pro for business | Processor: AMD Ryzen 5 7520U (up to 4.3 GHz max boost clock, 4 MB L3 cache, 4 cores, 8 threads) | Memory: 8 GB DDR4-3200 MHz RAM (onboard) | Internal Storage: 512 GB PCIe NVMe SSD | Display: 35.6 cm (14\") diagonal FHD display | Keyboard: Full-size, textured, island-style keyboard | Wireless: Realtek Wi-Fi 6 (2x2) and Bluetooth️ 5.3 wireless card | Battery Life: Long Life (Battery life will vary depending on configuration and maximum capacity will naturally decrease with time and usage) | Dimensions: 32.4 x 21.5 x 1.79 cm | Weight: Starting at 1.36 kg | Processor Family: AMD Ryzen 5 processor | Graphics: AMD Radeon Graphics | Audio Features: Stereo speakers, integrated digital microphone', '/Images/1751115825_HP 245 G10 (qr).png', '2025-06-28 13:03:45', 2),
(59, 'asusvivobooks14', 'Asus Vivobook S 14 OLED Flip', 'Intel Core i5 13500H | Intel Iris Xe Graphics | 14\" 2.8K (2800 x 1800) | 8GB DDR4 | Win 11 + Office Home Students 2021', 13049000.00, 16599000.00, 'In Stock', '/Images/1751117103_Asus Vivobook S 14 OLED Flip (1).jpg', '/Images/1751117103_Asus Vivobook S 14 OLED Flip (2).jpg', '/Images/1751117103_Asus Vivobook S 14 OLED Flip (3).jpg', '', 'https://www.tokopedia.com/rogsstoreid/asus-vivobook-s14-flip-oled-tp3402va-touch-core-i5-13500h-16gb-512gb-w11-ohs-14-0-2-8k-2in1-standard-blue-6046e?extParam=ivf%3Dfalse%26keyword%3Dasus+vivobook+s+14+oled+flip%26search_id%3D20250627140632D395771085AAB002ELJM%26src%3Dsearch&t_id=1751029242384&t_st=48&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Core i5 13500H | Graphics: Intel Iris Xe Graphics | Display: 14.0-inch, 2.8K (2880 x 1800) OLED 16:10 aspect ratio, IPS-level Panel, 400nits, 100% DCI-P3 color gamut, VESA CERTIFIED Display HDR True Black 500, 1.07 billion colors, Glossy display, 65% less harmful blue light, TÜV Rheinland-certified, Touch screen, With stylus support, Screen-to-body ratio: 85% | Memory: 8GB DDR4 | Storage: 512GB M.2 NVMe PCIe SSD | Operating System: Windows 11 Home + Office Home Student 2021 | I/O Ports: 1x USB 2.0 Type-A | 1x USB 3.2 Gen 2 Type-A | 1x Thunderbolt 4 supports display / power delivery | 1x HDMI 2.1 TMDS | 1x DC-in', '/Images/1751117103_Asus Vivobook S 14 OLED Flip (qr).png', '2025-06-28 13:25:03', 3),
(61, 'axiooslimbook', 'Axioo Slimbook Hype 10', 'Intel Celeron N4020 | Intel UHD Graphics 600 | 14.1\" 2.5K (2560 x 1600) | 8GB DDR4 | Win 10 ', 2749000.00, 6999000.00, 'In Stock', '/Images/1751166820_Axioo Slimbook Hype 10 (1).jpg', '/Images/1751166820_Axioo Slimbook Hype 10 (2).jpg', '', '', 'https://www.tokopedia.com/axiooslimbook/laptop-axioo-hype-10-n4020-8gb-256gb-windows-10-pro-normal-dos-11f61?extParam=ivf%3Dfalse%26keyword%3Daxioo+slimbook+hype+10%26search_id%3D20250627142053577BCC914F9E55302R3H%26src%3Dsearch&t_id=1751029242384&t_st=51&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Celeron Processor N4020 (1.1GHz Base, 2.8GHz Burst, 2 Core 2 Threads, Base TDP: 6W) | Code Name: Gemini Lake Refresh | Graphics: Intel UHD Graphics 600 | LCD: 14.1\" inch TN (16:9) | Display / Resolution: HD 1366x768 | Memory: 8GB DDR4 / ONBOARD | Storage: 256 GB M.2 2280 SATA | O.S: Windows 10 (64-bit) | Camera Front: 2Mpx | Sound System: HD Audio, Built-in Microphone | Ports: 2x USB 3.0 ports, 1x USB 2.0 port, 2x USB 3.0 Type C ports, 1x 3.5mm 2-in-1 Audio Combo Jack, 1x HDMI output port, 1x DC-in jack port | Power Management: AC Adapter 12V/2A, Embedded cells Lithium-ion polymer battery pack, 7.6V, 38Wh, 5000mAh | Connection: Wi-Fi Intel 9560 a/b/g/n/ac, Bluetooth 5.1 | Speaker: 2 x Speakers | Security: Kensington lock slot, TPM 2.0 | Bios: AMI | Dimension: 323.4(W) x 219.9(H) x 20.7(D) mm | Weight: 1.4Kg', '/Images/1751166820_Axioo Slimbook Hype 10 (qr).png', '2025-06-29 03:13:40', 4),
(62, 'msisummit', 'MSI SUMMIT A16 A3HMTG AI', 'AMD Ryzen AI 9-365 | AMD Radeon 880M Graphics | 16\" QHD+ (2560x1600) | 32GB LPDDR5x-7500 | Win 11 + Office Home Student 2021 Original', 27499000.00, 29499000.00, 'In Stock', '/Images/1751167229_MSI Summit A16 AI (1).jpg', '/Images/1751167229_MSI Summit A16 AI (2).jpg', '/Images/1751167229_MSI Summit A16 AI (3).jpg', '', 'https://www.tokopedia.com/msi-indonesia/msi-summit-a16-a3hmtg-ai-ryzen-9-365-32gb-1tb-16-0wqxga-165hz-touch-w11-ohs?extParam=ivf%3Dfalse%26keyword%3Dmsi+summit+a16+ai%26search_id%3D2025062903152934ED066DF378EF25FWJS%26src%3Dsearch&t_id=1751166937532&t_st=1&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: AMD Ryzen AI 9-365 up to 50 NPU TOPS (73 total AI TOPS) | Graphic: AMD Radeon 880M Graphics | Memory: 32GB LPDDR5x-7500 | Storage: 1TB 1x M.2 SSD slot (NVMe PCIe Gen4) | Display: 16” QHD+ (2560x1600), 165Hz, IPS-Level | OS: Windows 11 Home | Include: Microsoft Office Home and Student 2021 | Camera: IR FHD type (30fps@1080p) with HDR, 3D Noise Reduction+ (3DNR+) | Keyboard: Single Backlit Keyboard (White) with Copilot Key | Battery: 4-Cell 82 Battery (Whr) | I/O Ports: 1x Type-A USB3.2 Gen2, 1x Micro SD Card Reader, 1x HDMI 2.1 (8K @ 60Hz / 4K @ 120Hz), 2x Type-C (USB4 / DisplayPort / Power Delivery 3.0 / Thunderbolt 4 compatible)', '/Images/1751167229_MSI Summit A16 AI (qr).png', '2025-06-29 03:20:29', 5),
(63, NULL, 'Produk Baru', NULL, 3500000.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deskripsi uji', NULL, '2025-07-28 04:20:28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` int(11) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`id`, `password`, `first_name`, `last_name`, `email`, `gender`) VALUES
(1, '05-347-5309', 'Lilia', 'Titcom', 'ltitcom0@live.com', 'Female'),
(2, '00-257-3655', 'Ethe', 'Alfonsetto', 'ealfonsetto1@apple.com', 'Male'),
(3, '86-957-8700', 'Sheree', 'Branchett', 'sbranchett2@businessweek.com', 'Female'),
(4, '53-874-2481', 'Clive', 'Fust', 'cfust3@patch.com', 'Male'),
(5, '73-844-5478', 'Madel', 'Bloom', 'mbloom4@who.int', 'Female'),
(6, '00-446-8485', 'Aubine', 'Wass', 'awass5@gravatar.com', 'Female'),
(7, '21-863-6908', 'Shem', 'Liddiatt', 'sliddiatt6@wordpress.org', 'Male'),
(8, '44-894-4505', 'Rosemaria', 'Tritton', 'rtritton7@dropbox.com', 'Female'),
(9, '19-173-1210', 'Albrecht', 'Ackred', 'aackred8@dropbox.com', 'Male'),
(10, '41-373-9190', 'Sabra', 'Cantle', 'scantle9@reddit.com', 'Female'),
(11, '85-896-2617', 'Georgette', 'Tythe', 'gtythea@earthlink.net', 'Female'),
(12, '72-269-9461', 'Rae', 'Toolan', 'rtoolanb@comsenz.com', 'Polygender'),
(13, '00-006-4989', 'Barnabe', 'Dalrymple', 'bdalrymplec@ed.gov', 'Male'),
(14, '80-925-7088', 'Hanson', 'Fairlie', 'hfairlied@icio.us', 'Male'),
(15, '88-629-8391', 'Kahaleel', 'Arter', 'kartere@artisteer.com', 'Male'),
(16, '27-567-0045', 'Irvin', 'Aiken', 'iaikenf@icq.com', 'Male'),
(17, '67-963-0909', 'Orelia', 'Linturn', 'olinturng@utexas.edu', 'Female'),
(18, '60-651-3222', 'Floria', 'Parbrook', 'fparbrookh@istockphoto.com', 'Female'),
(19, '97-089-5674', 'Esteban', 'Zannetti', 'ezannettii@pcworld.com', 'Male'),
(20, '62-382-6676', 'Hedvige', 'MacKimmie', 'hmackimmiej@tiny.cc', 'Female'),
(21, '12-085-6557', 'Brandi', 'Kloisner', 'bkloisnerk@fastcompany.com', 'Female'),
(22, '95-698-4884', 'Cello', 'Iianon', 'ciianonl@discuz.net', 'Male'),
(23, '55-727-6764', 'Kahaleel', 'Ferentz', 'kferentzm@geocities.jp', 'Male'),
(24, '27-170-6246', 'Cathee', 'Eilhertsen', 'ceilhertsenn@biglobe.ne.jp', 'Female'),
(25, '80-301-4476', 'Gardener', 'Hearthfield', 'ghearthfieldo@elpais.com', 'Male'),
(26, '80-386-3196', 'Loni', 'Stoke', 'lstokep@samsung.com', 'Female'),
(27, '23-301-6923', 'Murial', 'Marrable', 'mmarrableq@ebay.co.uk', 'Female'),
(28, '61-595-6217', 'Ursala', 'Kenrick', 'ukenrickr@purevolume.com', 'Bigender'),
(29, '01-316-3029', 'Chandra', 'Syder', 'csyders@purevolume.com', 'Female'),
(30, '16-168-0890', 'Bren', 'Windrass', 'bwindrasst@cnet.com', 'Female'),
(31, '54-043-1523', 'Blanche', 'Kupka', 'bkupkau@free.fr', 'Female'),
(32, '78-792-0286', 'Bettye', 'Cockrem', 'bcockremv@seesaa.net', 'Female'),
(33, '29-316-5355', 'Krishnah', 'Vasilik', 'kvasilikw@mac.com', 'Male'),
(34, '64-502-6191', 'Reinhard', 'Winterbotham', 'rwinterbothamx@aboutads.info', 'Genderfluid'),
(35, '47-504-4211', 'Omero', 'Virgo', 'ovirgoy@pinterest.com', 'Male'),
(36, '91-477-1078', 'Nicolais', 'Deans', 'ndeansz@ycombinator.com', 'Male'),
(37, '37-056-5044', 'Mara', 'Panks', 'mpanks10@sakura.ne.jp', 'Female'),
(38, '71-065-8960', 'Jeffie', 'Polack', 'jpolack11@ovh.net', 'Male'),
(39, '75-517-4499', 'Udell', 'Fayerman', 'ufayerman12@europa.eu', 'Male'),
(40, '34-256-2999', 'Clareta', 'Grigolli', 'cgrigolli13@parallels.com', 'Bigender'),
(41, '56-891-3152', 'Erskine', 'Roderick', 'eroderick14@usatoday.com', 'Male'),
(42, '10-082-4405', 'Rod', 'Laverack', 'rlaverack15@seesaa.net', 'Male'),
(43, '81-343-3318', 'Lucie', 'O\'Hearn', 'lohearn16@senate.gov', 'Female'),
(44, '61-957-6449', 'Prisca', 'Richarson', 'pricharson17@chron.com', 'Female'),
(45, '90-250-4573', 'Gerti', 'Kilsby', 'gkilsby18@w3.org', 'Female'),
(46, '58-340-3857', 'Ashla', 'Perrett', 'aperrett19@drupal.org', 'Female'),
(47, '40-899-6650', 'Staffard', 'Zecchini', 'szecchini1a@artisteer.com', 'Male'),
(48, '25-443-2932', 'Janeczka', 'Batting', 'jbatting1b@accuweather.com', 'Female'),
(49, '25-556-0569', 'Orran', 'Jayes', 'ojayes1c@dell.com', 'Male'),
(50, '76-711-0575', 'Sari', 'Maudett', 'smaudett1d@ameblo.jp', 'Female'),
(51, '71-505-9184', 'Axel', 'Hadye', 'ahadye1e@com.com', 'Male'),
(52, '36-582-0213', 'Winfield', 'Blucher', 'wblucher1f@amazon.com', 'Male'),
(53, '50-079-4853', 'Beatrisa', 'Blinerman', 'bblinerman1g@squarespace.com', 'Agender'),
(54, '19-000-0842', 'Ezmeralda', 'Copcott', 'ecopcott1h@soup.io', 'Bigender'),
(55, '44-724-3060', 'Curtice', 'Beincken', 'cbeincken1i@va.gov', 'Male'),
(56, '33-112-3400', 'Hammad', 'Brosetti', 'hbrosetti1j@acquirethisname.com', 'Male'),
(57, '50-708-9597', 'Linda', 'Morcom', 'lmorcom1k@vimeo.com', 'Female'),
(58, '88-289-2357', 'Shelby', 'Monini', 'smonini1l@walmart.com', 'Female'),
(59, '96-566-9560', 'Bron', 'Baccup', 'bbaccup1m@statcounter.com', 'Male'),
(60, '22-909-3058', 'Abbey', 'Mahon', 'amahon1n@sourceforge.net', 'Female'),
(61, '90-827-1262', 'Brendan', 'Helleckas', 'bhelleckas1o@alexa.com', 'Male'),
(62, '38-420-4802', 'Egbert', 'Cordell', 'ecordell1p@printfriendly.com', 'Male'),
(63, '31-810-8599', 'Cynthy', 'Redgewell', 'credgewell1q@goo.gl', 'Female'),
(64, '62-982-2723', 'Hymie', 'Pellitt', 'hpellitt1r@aol.com', 'Male'),
(65, '79-161-4208', 'Lea', 'Saull', 'lsaull1s@infoseek.co.jp', 'Female'),
(66, '75-203-7357', 'Gearalt', 'Charge', 'gcharge1t@google.cn', 'Male'),
(67, '94-136-1776', 'Dael', 'Wackly', 'dwackly1u@wikipedia.org', 'Female'),
(68, '54-642-1813', 'Isa', 'Donavan', 'idonavan1v@sbwire.com', 'Male'),
(69, '01-496-8040', 'Neill', 'Currell', 'ncurrell1w@go.com', 'Male'),
(70, '25-111-8333', 'Brnaby', 'Pasmore', 'bpasmore1x@a8.net', 'Male'),
(71, '39-661-1513', 'Becky', 'Targett', 'btargett1y@meetup.com', 'Female'),
(72, '69-906-4755', 'Caddric', 'Golightly', 'cgolightly1z@ebay.com', 'Male'),
(73, '28-616-9341', 'Dalt', 'Duffett', 'dduffett20@soup.io', 'Male'),
(74, '28-579-8242', 'Nilson', 'Dugmore', 'ndugmore21@google.pl', 'Male'),
(75, '06-398-5389', 'Hugues', 'Paynes', 'hpaynes22@goo.gl', 'Male'),
(76, '51-819-8469', 'Ban', 'Mattosoff', 'bmattosoff23@microsoft.com', 'Male'),
(77, '86-274-2326', 'Shirl', 'Janc', 'sjanc24@4shared.com', 'Female'),
(78, '33-160-5577', 'Gwenette', 'Battista', 'gbattista25@sogou.com', 'Female'),
(79, '81-477-0629', 'Nikolai', 'Grasha', 'ngrasha26@theatlantic.com', 'Male'),
(80, '79-797-0400', 'Melody', 'Fulleylove', 'mfulleylove27@gizmodo.com', 'Female'),
(81, '74-831-0533', 'Olivier', 'Nelligan', 'onelligan28@businesswire.com', 'Male'),
(82, '11-828-7706', 'Harli', 'Choldcroft', 'hcholdcroft29@slideshare.net', 'Female'),
(83, '46-684-4782', 'Artus', 'Hebdon', 'ahebdon2a@businessinsider.com', 'Male'),
(84, '94-076-1596', 'Alexandr', 'Olliar', 'aolliar2b@kickstarter.com', 'Male'),
(85, '52-560-2778', 'Ingelbert', 'Pedder', 'ipedder2c@xrea.com', 'Male'),
(86, '25-341-7487', 'Raye', 'Hovenden', 'rhovenden2d@amazon.co.uk', 'Female'),
(87, '50-652-4304', 'Hanson', 'Grimley', 'hgrimley2e@networkadvertising.org', 'Male'),
(88, '31-086-5556', 'Ritchie', 'Beazer', 'rbeazer2f@vistaprint.com', 'Male'),
(89, '87-783-7091', 'Camel', 'Aberdein', 'caberdein2g@walmart.com', 'Female'),
(90, '41-924-4031', 'Inessa', 'Bromige', 'ibromige2h@ameblo.jp', 'Female'),
(91, '56-060-0821', 'Riannon', 'Falloon', 'rfalloon2i@domainmarket.com', 'Female'),
(92, '22-863-8551', 'Lorilee', 'Kassel', 'lkassel2j@google.nl', 'Female'),
(93, '61-858-7998', 'Onofredo', 'Dawks', 'odawks2k@sourceforge.net', 'Male'),
(94, '38-505-8054', 'Doralynne', 'Maskelyne', 'dmaskelyne2l@nbcnews.com', 'Female'),
(95, '54-803-3171', 'Dan', 'Pere', 'dpere2m@economist.com', 'Male'),
(96, '30-045-2397', 'Aeriel', 'Rodder', 'arodder2n@github.io', 'Female'),
(97, '25-920-1132', 'Alyson', 'Urridge', 'aurridge2o@t.co', 'Female'),
(98, '11-114-7044', 'Lloyd', 'Wombwell', 'lwombwell2p@i2i.jp', 'Male'),
(99, '56-962-0755', 'Wendie', 'Neeves', 'wneeves2q@berkeley.edu', 'Female'),
(100, '85-049-3257', 'Dag', 'Gatheridge', 'dgatheridge2r@va.gov', 'Male'),
(101, '14-399-0484', 'Stacie', 'Jennaway', 'sjennaway2s@reuters.com', 'Female'),
(102, '83-417-4626', 'Gypsy', 'Antonin', 'gantonin2t@smh.com.au', 'Female'),
(103, '02-038-7471', 'Henderson', 'Isakowicz', 'hisakowicz2u@newyorker.com', 'Polygender'),
(104, '68-467-9645', 'Georg', 'Facher', 'gfacher2v@edublogs.org', 'Male'),
(105, '44-746-5667', 'Zonnya', 'Janosevic', 'zjanosevic2w@indiegogo.com', 'Female'),
(106, '93-682-3534', 'Renault', 'Hallen', 'rhallen2x@yahoo.com', 'Male'),
(107, '13-278-0081', 'Zondra', 'Stoneley', 'zstoneley2y@imdb.com', 'Female'),
(108, '20-475-0889', 'Wesley', 'O\'Cooney', 'wocooney2z@ustream.tv', 'Male'),
(109, '52-319-0851', 'Wait', 'Quant', 'wquant30@cmu.edu', 'Male'),
(110, '44-434-2114', 'Hendrik', 'Huntley', 'hhuntley31@paypal.com', 'Male'),
(111, '99-725-7028', 'Rosalie', 'McFarlane', 'rmcfarlane32@webs.com', 'Female'),
(112, '77-407-3590', 'Stephine', 'Kynoch', 'skynoch33@163.com', 'Female'),
(113, '18-527-4948', 'Lisbeth', 'Shilvock', 'lshilvock34@twitpic.com', 'Female'),
(114, '20-555-6408', 'Kariotta', 'Weekley', 'kweekley35@ask.com', 'Female'),
(115, '10-245-8423', 'Lorraine', 'Riedel', 'lriedel36@archive.org', 'Female'),
(116, '58-888-1881', 'Sinclair', 'McCosh', 'smccosh37@rambler.ru', 'Male'),
(117, '47-191-6148', 'Cherianne', 'Blackham', 'cblackham38@yahoo.co.jp', 'Female'),
(118, '07-162-2934', 'Dollie', 'Dymott', 'ddymott39@blinklist.com', 'Female'),
(119, '46-382-3166', 'Rafferty', 'Eard', 'reard3a@springer.com', 'Male'),
(120, '28-383-7461', 'Jobie', 'Howat', 'jhowat3b@noaa.gov', 'Female'),
(121, '22-804-6986', 'Matty', 'Haug', 'mhaug3c@google.es', 'Polygender'),
(122, '49-025-9607', 'Kaile', 'Mesias', 'kmesias3d@telegraph.co.uk', 'Female'),
(123, '31-416-2175', 'Bernhard', 'Dormer', 'bdormer3e@ibm.com', 'Male'),
(124, '50-277-7529', 'Jonathan', 'Duffin', 'jduffin3f@jigsy.com', 'Male'),
(125, '36-629-8718', 'Ingaborg', 'Gonzales', 'igonzales3g@digg.com', 'Female'),
(126, '09-680-7324', 'Anthony', 'Dilawey', 'adilawey3h@chronoengine.com', 'Male'),
(127, '62-322-4854', 'Odelle', 'Beardsell', 'obeardsell3i@vinaora.com', 'Female'),
(128, '17-555-5195', 'Zonda', 'Lound', 'zlound3j@dailymail.co.uk', 'Bigender'),
(129, '46-963-7200', 'Vincenty', 'Brason', 'vbrason3k@businessinsider.com', 'Non-binary'),
(130, '22-628-1343', 'Cornie', 'Yurin', 'cyurin3l@hhs.gov', 'Male'),
(131, '86-711-9943', 'Germain', 'Maykin', 'gmaykin3m@booking.com', 'Female'),
(132, '32-607-9762', 'Lynett', 'Ellerman', 'lellerman3n@wufoo.com', 'Female'),
(133, '34-561-6107', 'Richardo', 'Luciano', 'rluciano3o@jiathis.com', 'Male'),
(134, '76-744-9597', 'Hanna', 'Veart', 'hveart3p@boston.com', 'Female'),
(135, '84-874-0870', 'Ailyn', 'Fothergill', 'afothergill3q@squidoo.com', 'Non-binary'),
(136, '26-538-1785', 'Trula', 'Easterbrook', 'teasterbrook3r@google.it', 'Female'),
(137, '65-102-8093', 'Efrem', 'Crosskell', 'ecrosskell3s@amazonaws.com', 'Male'),
(138, '25-213-6260', 'Rutledge', 'Marginson', 'rmarginson3t@live.com', 'Male'),
(139, '67-142-4323', 'Enrica', 'Welfair', 'ewelfair3u@senate.gov', 'Bigender'),
(140, '88-604-7364', 'Lem', 'Franciotti', 'lfranciotti3v@reference.com', 'Male'),
(141, '15-165-8987', 'Selinda', 'Eger', 'seger3w@mtv.com', 'Female'),
(142, '79-327-0624', 'Edsel', 'Sterry', 'esterry3x@shutterfly.com', 'Male'),
(143, '90-755-5211', 'Marguerite', 'Crumly', 'mcrumly3y@cnet.com', 'Female'),
(144, '16-603-3671', 'Jacquette', 'Geraudel', 'jgeraudel3z@cmu.edu', 'Female'),
(145, '91-182-2822', 'Galvin', 'Tonn', 'gtonn40@vk.com', 'Male'),
(146, '65-148-4196', 'Norman', 'Matskiv', 'nmatskiv41@bloglines.com', 'Male'),
(147, '55-402-3850', 'Artemis', 'Dary', 'adary42@quantcast.com', 'Agender'),
(148, '72-180-7147', 'Adela', 'Fowell', 'afowell43@taobao.com', 'Female'),
(149, '10-366-7331', 'Fredek', 'Smaling', 'fsmaling44@infoseek.co.jp', 'Male'),
(150, '82-498-5615', 'Maxy', 'Thomazin', 'mthomazin45@cbc.ca', 'Female'),
(151, '26-615-8251', 'Car', 'Haslock(e)', 'chaslocke46@dedecms.com', 'Male'),
(152, '26-569-8952', 'Martie', 'Drinkel', 'mdrinkel47@webmd.com', 'Male'),
(153, '46-856-5880', 'Shirlee', 'Donke', 'sdonke48@rambler.ru', 'Female'),
(154, '71-412-0303', 'Joby', 'Sjostrom', 'jsjostrom49@vimeo.com', 'Female'),
(155, '22-071-0319', 'Karalee', 'Tireman', 'ktireman4a@cnbc.com', 'Female'),
(156, '92-624-9437', 'Bartholomew', 'Stainbridge', 'bstainbridge4b@tamu.edu', 'Male'),
(157, '25-298-0606', 'Amelita', 'Pulver', 'apulver4c@ustream.tv', 'Female'),
(158, '78-620-9098', 'Pearce', 'Salla', 'psalla4d@stumbleupon.com', 'Male'),
(159, '05-829-5574', 'Bili', 'Forlong', 'bforlong4e@icq.com', 'Female'),
(160, '13-440-8507', 'Gabriella', 'Playden', 'gplayden4f@twitpic.com', 'Female'),
(161, '68-226-9204', 'Barris', 'Meltetal', 'bmeltetal4g@wikimedia.org', 'Male'),
(162, '14-189-5213', 'Efrem', 'Sitlington', 'esitlington4h@mapy.cz', 'Male'),
(163, '44-481-2072', 'Ashla', 'Baxstair', 'abaxstair4i@smh.com.au', 'Female'),
(164, '95-325-3101', 'Cleo', 'Dasent', 'cdasent4j@macromedia.com', 'Female'),
(165, '29-993-0319', 'Madel', 'Kennefick', 'mkennefick4k@netvibes.com', 'Female'),
(166, '26-693-9177', 'Correy', 'Codman', 'ccodman4l@topsy.com', 'Male'),
(167, '34-233-1789', 'Monty', 'Nucci', 'mnucci4m@lycos.com', 'Male'),
(168, '65-825-4836', 'Zenia', 'Rowlett', 'zrowlett4n@walmart.com', 'Female'),
(169, '18-435-1987', 'Berna', 'Prettyjohns', 'bprettyjohns4o@irs.gov', 'Female'),
(170, '45-945-8599', 'Reine', 'Augustine', 'raugustine4p@rakuten.co.jp', 'Female'),
(171, '07-350-8348', 'Marrilee', 'Pardey', 'mpardey4q@usgs.gov', 'Female'),
(172, '64-187-9051', 'Lynn', 'Crannell', 'lcrannell4r@oakley.com', 'Female'),
(173, '75-361-0896', 'Alric', 'Piddick', 'apiddick4s@storify.com', 'Male'),
(174, '22-707-6875', 'Shayne', 'Ramsbottom', 'sramsbottom4t@hao123.com', 'Genderqueer'),
(175, '59-131-4476', 'Deborah', 'Clymo', 'dclymo4u@google.co.uk', 'Female'),
(176, '81-208-1555', 'Nestor', 'Cestard', 'ncestard4v@ameblo.jp', 'Male'),
(177, '70-027-1033', 'Mill', 'Adolf', 'madolf4w@dell.com', 'Agender'),
(178, '60-135-4303', 'Reidar', 'Bedin', 'rbedin4x@booking.com', 'Non-binary'),
(179, '86-426-6378', 'Petronilla', 'Wallbridge', 'pwallbridge4y@yahoo.co.jp', 'Female'),
(180, '57-379-4827', 'Tully', 'Sives', 'tsives4z@youtu.be', 'Male'),
(181, '25-092-8058', 'Edwin', 'Roscam', 'eroscam50@miitbeian.gov.cn', 'Male'),
(182, '00-786-5668', 'Kendall', 'Bayfield', 'kbayfield51@google.com', 'Genderqueer'),
(183, '27-794-5781', 'Lodovico', 'Esh', 'lesh52@independent.co.uk', 'Male'),
(184, '57-344-4338', 'Sayre', 'Domican', 'sdomican53@fema.gov', 'Male'),
(185, '61-803-3677', 'Erskine', 'Goodricke', 'egoodricke54@webeden.co.uk', 'Bigender'),
(186, '77-715-1839', 'Holly-anne', 'Pudney', 'hpudney55@craigslist.org', 'Bigender'),
(187, '35-464-0065', 'Lefty', 'Redman', 'lredman56@europa.eu', 'Male'),
(188, '35-723-7603', 'Nev', 'Bendall', 'nbendall57@dot.gov', 'Male'),
(189, '84-490-0657', 'Melodie', 'Bromfield', 'mbromfield58@soup.io', 'Female'),
(190, '46-717-4964', 'Ellie', 'Callear', 'ecallear59@usnews.com', 'Female'),
(191, '25-703-1479', 'Olly', 'Placide', 'oplacide5a@flickr.com', 'Female'),
(192, '47-070-4831', 'Saudra', 'Brinkler', 'sbrinkler5b@prnewswire.com', 'Female'),
(193, '23-041-3872', 'Francisco', 'Anfonsi', 'fanfonsi5c@bravesites.com', 'Male'),
(194, '46-548-4931', 'Toddy', 'Shurey', 'tshurey5d@example.com', 'Male'),
(195, '78-887-8503', 'Philbert', 'Bettlestone', 'pbettlestone5e@narod.ru', 'Male'),
(196, '92-794-6737', 'Domingo', 'Raft', 'draft5f@prnewswire.com', 'Male'),
(197, '51-498-4067', 'Austin', 'Hadye', 'ahadye5g@parallels.com', 'Male'),
(198, '34-383-1341', 'Micky', 'Kalkofen', 'mkalkofen5h@hugedomains.com', 'Agender'),
(199, '34-847-6195', 'Dorena', 'Bernadzki', 'dbernadzki5i@house.gov', 'Female'),
(200, '86-974-3252', 'Cornie', 'Shaudfurth', 'cshaudfurth5j@comsenz.com', 'Female'),
(201, '66-972-1564', 'Perry', 'Vannacci', 'pvannacci5k@alexa.com', 'Female'),
(202, '06-029-2763', 'Levey', 'Duley', 'lduley5l@privacy.gov.au', 'Male'),
(203, '46-057-7601', 'Leone', 'Croy', 'lcroy5m@google.it', 'Female'),
(204, '70-618-6130', 'Bonita', 'Leavold', 'bleavold5n@hubpages.com', 'Female'),
(205, '47-508-9930', 'Karisa', 'Asaaf', 'kasaaf5o@cloudflare.com', 'Female'),
(206, '79-790-3059', 'Urson', 'Gerriet', 'ugerriet5p@1und1.de', 'Male'),
(207, '15-063-4802', 'Rodge', 'Abramovicz', 'rabramovicz5q@archive.org', 'Non-binary'),
(208, '19-115-4973', 'Yorgos', 'Meadowcroft', 'ymeadowcroft5r@stanford.edu', 'Male'),
(209, '53-669-4370', 'Greg', 'Geater', 'ggeater5s@pinterest.com', 'Male'),
(210, '25-389-8756', 'Al', 'Temlett', 'atemlett5t@seattletimes.com', 'Male'),
(211, '07-879-4668', 'Pammy', 'Spendley', 'pspendley5u@imageshack.us', 'Female'),
(212, '58-300-5065', 'Janene', 'Chesworth', 'jchesworth5v@google.nl', 'Female'),
(213, '34-114-3987', 'Valentina', 'Uzzell', 'vuzzell5w@parallels.com', 'Female'),
(214, '24-538-5178', 'Thekla', 'Elbourne', 'telbourne5x@amazon.de', 'Female'),
(215, '66-837-7787', 'Kerry', 'Twiggs', 'ktwiggs5y@topsy.com', 'Male'),
(216, '60-904-6615', 'Carson', 'Maureen', 'cmaureen5z@npr.org', 'Male'),
(217, '73-757-9535', 'Tom', 'Moule', 'tmoule60@scribd.com', 'Male'),
(218, '25-785-6890', 'Silvan', 'Atkinson', 'satkinson61@google.com.hk', 'Male'),
(219, '29-587-6911', 'Maureen', 'Reford', 'mreford62@dagondesign.com', 'Female'),
(220, '49-918-5868', 'Aldwin', 'Stacy', 'astacy63@time.com', 'Polygender'),
(221, '93-136-5037', 'Selig', 'Louder', 'slouder64@over-blog.com', 'Male'),
(222, '89-838-9200', 'Milzie', 'Fidock', 'mfidock65@phoca.cz', 'Female'),
(223, '17-033-0259', 'Maurene', 'Grzegorzewski', 'mgrzegorzewski66@sfgate.com', 'Female'),
(224, '93-203-2555', 'Lauren', 'Fortnon', 'lfortnon67@hc360.com', 'Female'),
(225, '35-248-4594', 'Lizbeth', 'Josiah', 'ljosiah68@baidu.com', 'Female'),
(226, '95-280-7803', 'Denys', 'Shrimplin', 'dshrimplin69@deviantart.com', 'Female'),
(227, '48-942-9525', 'Stormy', 'Rearie', 'srearie6a@com.com', 'Female'),
(228, '22-520-6283', 'Juliann', 'Epinoy', 'jepinoy6b@house.gov', 'Female'),
(229, '95-418-4236', 'Dulsea', 'Belin', 'dbelin6c@virginia.edu', 'Polygender'),
(230, '77-316-7185', 'Di', 'Risbrough', 'drisbrough6d@imdb.com', 'Female'),
(231, '48-271-1187', 'Doris', 'Gladbach', 'dgladbach6e@xrea.com', 'Female'),
(232, '93-297-0989', 'Ossie', 'Schultheiss', 'oschultheiss6f@digg.com', 'Male'),
(233, '90-616-0106', 'Chery', 'Hollyman', 'chollyman6g@newsvine.com', 'Female'),
(234, '27-943-7961', 'Kirsten', 'Turneux', 'kturneux6h@myspace.com', 'Female'),
(235, '50-512-0302', 'Lorant', 'Rois', 'lrois6i@miitbeian.gov.cn', 'Male'),
(236, '01-259-1845', 'Doreen', 'Purle', 'dpurle6j@ft.com', 'Female'),
(237, '00-913-3009', 'Clint', 'Sigg', 'csigg6k@i2i.jp', 'Non-binary'),
(238, '66-461-8792', 'Lynde', 'Trodd', 'ltrodd6l@themeforest.net', 'Female'),
(239, '81-064-7178', 'Emili', 'Shave', 'eshave6m@alexa.com', 'Female'),
(240, '51-048-3476', 'Siward', 'Winram', 'swinram6n@nasa.gov', 'Male'),
(241, '99-432-9857', 'Georgeta', 'Thursby', 'gthursby6o@si.edu', 'Female'),
(242, '81-781-6725', 'Samuele', 'Mendenhall', 'smendenhall6p@google.de', 'Male'),
(243, '32-425-7316', 'Bebe', 'Agge', 'bagge6q@is.gd', 'Genderfluid'),
(244, '33-154-0215', 'Floris', 'Abrashkov', 'fabrashkov6r@csmonitor.com', 'Female'),
(245, '51-941-7332', 'Stefania', 'Brach', 'sbrach6s@yandex.ru', 'Female'),
(246, '51-381-0540', 'Ermengarde', 'Gebb', 'egebb6t@cargocollective.com', 'Female'),
(247, '44-923-3554', 'Dael', 'McCaughen', 'dmccaughen6u@sciencedaily.com', 'Male'),
(248, '97-994-5172', 'Brigid', 'Brumbye', 'bbrumbye6v@prnewswire.com', 'Female'),
(249, '60-449-8718', 'Lane', 'Kippins', 'lkippins6w@archive.org', 'Male'),
(250, '92-772-4608', 'Yurik', 'Casterton', 'ycasterton6x@pen.io', 'Male'),
(251, '45-839-4914', 'Lou', 'McClosh', 'lmcclosh6y@independent.co.uk', 'Female'),
(252, '86-883-0367', 'Alverta', 'McCheyne', 'amccheyne6z@dyndns.org', 'Female'),
(253, '13-735-6703', 'Jermain', 'Brotherton', 'jbrotherton70@ft.com', 'Bigender'),
(254, '51-718-8464', 'Harriet', 'Jakovijevic', 'hjakovijevic71@army.mil', 'Female'),
(255, '94-482-6847', 'Mario', 'Bartolomucci', 'mbartolomucci72@google.com.hk', 'Male'),
(256, '24-294-8238', 'Reuven', 'Wyper', 'rwyper73@examiner.com', 'Male'),
(257, '78-372-7144', 'Sandye', 'Hand', 'shand74@webs.com', 'Female'),
(258, '78-962-2212', 'Lynde', 'Featherstonhaugh', 'lfeatherstonhaugh75@behance.net', 'Bigender'),
(259, '02-683-8897', 'Thorvald', 'Foxley', 'tfoxley76@t-online.de', 'Male'),
(260, '09-320-1172', 'Stepha', 'Vales', 'svales77@netvibes.com', 'Female'),
(261, '09-425-2384', 'Hussein', 'Lemary', 'hlemary78@hubpages.com', 'Male'),
(262, '31-980-7312', 'Daisy', 'Ainger', 'dainger79@google.fr', 'Female'),
(263, '48-454-4966', 'Clarance', 'Demke', 'cdemke7a@fc2.com', 'Male'),
(264, '27-889-3386', 'Nannette', 'Desesquelle', 'ndesesquelle7b@irs.gov', 'Female'),
(265, '27-189-7961', 'Anson', 'Matisoff', 'amatisoff7c@youtube.com', 'Male'),
(266, '60-284-6759', 'Neal', 'Beagles', 'nbeagles7d@163.com', 'Male'),
(267, '46-209-4923', 'Yorgos', 'Burth', 'yburth7e@webmd.com', 'Male'),
(268, '11-763-7587', 'Weylin', 'Bollins', 'wbollins7f@histats.com', 'Male'),
(269, '45-652-3129', 'Alden', 'Cranfield', 'acranfield7g@live.com', 'Agender'),
(270, '90-297-5430', 'Christin', 'Yakubov', 'cyakubov7h@chronoengine.com', 'Female'),
(271, '29-010-6157', 'Gwenette', 'Netherclift', 'gnetherclift7i@multiply.com', 'Female'),
(272, '34-671-1982', 'Filippa', 'Wilne', 'fwilne7j@senate.gov', 'Female'),
(273, '87-971-7537', 'Charlie', 'Korlat', 'ckorlat7k@eventbrite.com', 'Polygender'),
(274, '27-405-2957', 'Minta', 'Prentice', 'mprentice7l@barnesandnoble.com', 'Female'),
(275, '31-349-2636', 'Justen', 'Vardon', 'jvardon7m@google.pl', 'Male'),
(276, '52-274-6323', 'Armand', 'Aers', 'aaers7n@intel.com', 'Male'),
(277, '05-684-3116', 'Corene', 'Valintine', 'cvalintine7o@behance.net', 'Non-binary'),
(278, '75-824-3487', 'Martainn', 'Justham', 'mjustham7p@hc360.com', 'Male'),
(279, '11-786-4539', 'Piggy', 'Addionizio', 'paddionizio7q@engadget.com', 'Male'),
(280, '42-738-4388', 'Hervey', 'Povele', 'hpovele7r@ucsd.edu', 'Male'),
(281, '06-275-6136', 'Gregory', 'Clitheroe', 'gclitheroe7s@hugedomains.com', 'Male'),
(282, '73-288-2184', 'Carolin', 'Zum Felde', 'czumfelde7t@pen.io', 'Female'),
(283, '74-848-1146', 'Ranice', 'Cunniff', 'rcunniff7u@opera.com', 'Polygender'),
(284, '65-601-4452', 'Raffarty', 'Monget', 'rmonget7v@naver.com', 'Male'),
(285, '07-695-8243', 'Rickey', 'Bortolozzi', 'rbortolozzi7w@cisco.com', 'Male'),
(286, '14-506-3461', 'Kurtis', 'Hymers', 'khymers7x@harvard.edu', 'Male'),
(287, '50-328-2111', 'Malvina', 'Cassidy', 'mcassidy7y@blinklist.com', 'Female'),
(288, '32-351-4595', 'Hyatt', 'Stonall', 'hstonall7z@ca.gov', 'Male'),
(289, '21-611-6694', 'Reinald', 'Offin', 'roffin80@bizjournals.com', 'Male'),
(290, '90-268-4975', 'Yancey', 'Stive', 'ystive81@craigslist.org', 'Male'),
(291, '85-331-3056', 'Lexine', 'Tranmer', 'ltranmer82@shop-pro.jp', 'Female'),
(292, '55-024-6237', 'Killian', 'Yokley', 'kyokley83@npr.org', 'Bigender'),
(293, '94-638-7414', 'Gusella', 'Gianinotti', 'ggianinotti84@tiny.cc', 'Female'),
(294, '90-451-9453', 'Marijn', 'D\'orsay', 'mdorsay85@ucoz.com', 'Male'),
(295, '37-145-1795', 'Remy', 'Jorry', 'rjorry86@blogtalkradio.com', 'Female'),
(296, '28-526-4976', 'Lizzie', 'Hugnin', 'lhugnin87@patch.com', 'Female'),
(297, '17-972-3153', 'Arther', 'Manwaring', 'amanwaring88@statcounter.com', 'Male'),
(298, '23-171-5182', 'Clemente', 'McMennum', 'cmcmennum89@princeton.edu', 'Male'),
(299, '95-087-0820', 'Zea', 'O\'Boyle', 'zoboyle8a@ed.gov', 'Female'),
(300, '13-995-5991', 'Lorne', 'Corton', 'lcorton8b@myspace.com', 'Female'),
(301, '60-318-7207', 'Price', 'Skedge', 'pskedge8c@un.org', 'Male'),
(302, '54-930-1689', 'Gale', 'Espinha', 'gespinha8d@parallels.com', 'Male'),
(303, '38-450-5521', 'Kathy', 'Goard', 'kgoard8e@artisteer.com', 'Female'),
(304, '16-976-2112', 'Lenna', 'Kollatsch', 'lkollatsch8f@netvibes.com', 'Female'),
(305, '57-197-6888', 'Brendis', 'Rittelmeyer', 'brittelmeyer8g@blogtalkradio.com', 'Male'),
(306, '20-870-6496', 'Quint', 'Effnert', 'qeffnert8h@mac.com', 'Male'),
(307, '29-542-2644', 'Edin', 'Shill', 'eshill8i@bizjournals.com', 'Female'),
(308, '02-803-7357', 'Gaultiero', 'Paice', 'gpaice8j@vistaprint.com', 'Male'),
(309, '38-384-8617', 'Shandy', 'Skirvin', 'sskirvin8k@cocolog-nifty.com', 'Female'),
(310, '76-897-6708', 'Mahala', 'Shawcroft', 'mshawcroft8l@mozilla.com', 'Female'),
(311, '67-179-3021', 'Gabbie', 'Kail', 'gkail8m@photobucket.com', 'Female'),
(312, '99-624-0617', 'Duff', 'Rylance', 'drylance8n@cnet.com', 'Male'),
(313, '55-016-3120', 'Arnoldo', 'Ilyukhov', 'ailyukhov8o@yellowpages.com', 'Male'),
(314, '71-831-0547', 'Duke', 'Bazylets', 'dbazylets8p@free.fr', 'Male'),
(315, '31-541-2492', 'Polly', 'Vogel', 'pvogel8q@cbsnews.com', 'Bigender'),
(316, '06-173-9477', 'Ally', 'Mineghelli', 'amineghelli8r@nih.gov', 'Female'),
(317, '16-105-1996', 'Kelby', 'Schimaschke', 'kschimaschke8s@gravatar.com', 'Non-binary'),
(318, '19-738-8817', 'Cordie', 'Venart', 'cvenart8t@wunderground.com', 'Male'),
(319, '53-264-0345', 'Obadiah', 'Lennon', 'olennon8u@bloglovin.com', 'Male'),
(320, '55-628-4983', 'Fifine', 'Hasley', 'fhasley8v@edublogs.org', 'Female'),
(321, '38-207-5475', 'Lindsay', 'Quinney', 'lquinney8w@europa.eu', 'Female'),
(322, '45-964-7519', 'Elston', 'Sidden', 'esidden8x@nasa.gov', 'Male'),
(323, '30-470-4387', 'Jemie', 'Sampson', 'jsampson8y@elegantthemes.com', 'Female'),
(324, '47-205-6593', 'Stefa', 'Dinsey', 'sdinsey8z@over-blog.com', 'Female'),
(325, '49-440-6874', 'Chrystel', 'Allaker', 'callaker90@ning.com', 'Bigender'),
(326, '77-835-7831', 'Briana', 'Gillooly', 'bgillooly91@bigcartel.com', 'Female'),
(327, '32-027-6380', 'Alleen', 'McElwee', 'amcelwee92@netlog.com', 'Female'),
(328, '34-745-7601', 'Rianon', 'Castiello', 'rcastiello93@odnoklassniki.ru', 'Female'),
(329, '28-040-5259', 'Chanda', 'Woodstock', 'cwoodstock94@nsw.gov.au', 'Female'),
(330, '95-424-6931', 'Maximilianus', 'Jardin', 'mjardin95@google.ca', 'Male'),
(331, '05-635-1814', 'Herminia', 'Burnapp', 'hburnapp96@cyberchimps.com', 'Female'),
(332, '99-129-1824', 'Magdalen', 'Buckmaster', 'mbuckmaster97@naver.com', 'Female'),
(333, '27-093-0817', 'Shaylyn', 'Casado', 'scasado98@uiuc.edu', 'Female'),
(334, '89-535-9842', 'Alison', 'Rainsbury', 'arainsbury99@istockphoto.com', 'Female'),
(335, '46-105-2859', 'Aeriel', 'Rizzardo', 'arizzardo9a@usda.gov', 'Female'),
(336, '11-339-2640', 'Glyn', 'Borton', 'gborton9b@canalblog.com', 'Female'),
(337, '27-515-7410', 'Debi', 'Killik', 'dkillik9c@nasa.gov', 'Non-binary'),
(338, '06-885-6683', 'Micah', 'Eliaz', 'meliaz9d@comcast.net', 'Male'),
(339, '26-470-2491', 'Finn', 'Brothwell', 'fbrothwell9e@sakura.ne.jp', 'Male'),
(340, '12-432-2298', 'Aleta', 'Decruse', 'adecruse9f@patch.com', 'Female'),
(341, '55-205-5300', 'Tobit', 'Attewill', 'tattewill9g@spotify.com', 'Male'),
(342, '52-378-6744', 'Hank', 'Stanyon', 'hstanyon9h@nhs.uk', 'Bigender'),
(343, '90-071-1777', 'Selby', 'MacHostie', 'smachostie9i@sciencedirect.com', 'Male'),
(344, '10-434-9012', 'Theo', 'McIlhatton', 'tmcilhatton9j@jugem.jp', 'Non-binary'),
(345, '05-819-4701', 'Danny', 'McBeth', 'dmcbeth9k@ning.com', 'Female'),
(346, '86-072-9662', 'Bell', 'Baker', 'bbaker9l@berkeley.edu', 'Female'),
(347, '30-396-1123', 'Teriann', 'Ughini', 'tughini9m@nydailynews.com', 'Female'),
(348, '73-251-4313', 'Junina', 'McAnalley', 'jmcanalley9n@ed.gov', 'Female'),
(349, '66-218-9793', 'Halette', 'Heinzler', 'hheinzler9o@google.co.jp', 'Female'),
(350, '68-371-8784', 'Armstrong', 'Toolan', 'atoolan9p@cocolog-nifty.com', 'Male'),
(351, '88-667-5312', 'Hurley', 'Faull', 'hfaull9q@rambler.ru', 'Male'),
(352, '64-450-6063', 'Bert', 'Larmet', 'blarmet9r@livejournal.com', 'Male'),
(353, '94-038-4692', 'Cariotta', 'Lamlin', 'clamlin9s@unicef.org', 'Female'),
(354, '66-062-4365', 'Alaster', 'Lillyman', 'alillyman9t@multiply.com', 'Male'),
(355, '45-712-6264', 'Bunnie', 'Patise', 'bpatise9u@msn.com', 'Female'),
(356, '93-410-0330', 'Kiley', 'Thoday', 'kthoday9v@yelp.com', 'Male'),
(357, '48-186-9994', 'Maren', 'Allot', 'mallot9w@whitehouse.gov', 'Female'),
(358, '61-776-2758', 'Willie', 'Jachimczak', 'wjachimczak9x@google.com.hk', 'Female'),
(359, '90-883-4999', 'Mortie', 'Bakewell', 'mbakewell9y@php.net', 'Male'),
(360, '86-173-2261', 'Petronilla', 'Cawthera', 'pcawthera9z@nbcnews.com', 'Female'),
(361, '83-082-6854', 'Lowrance', 'Puncher', 'lpunchera0@army.mil', 'Male'),
(362, '19-828-4929', 'Monti', 'Boorn', 'mboorna1@so-net.ne.jp', 'Male'),
(363, '90-390-4994', 'Gavin', 'Braikenridge', 'gbraikenridgea2@google.de', 'Male'),
(364, '04-375-8992', 'Randal', 'Newis', 'rnewisa3@bing.com', 'Male'),
(365, '58-475-8742', 'Martin', 'Diperaus', 'mdiperausa4@dedecms.com', 'Male'),
(366, '88-634-9484', 'Jeff', 'Fernley', 'jfernleya5@dailymotion.com', 'Male'),
(367, '59-207-5663', 'Ethelda', 'Gwillim', 'egwillima6@tinyurl.com', 'Female'),
(368, '84-446-4331', 'Orelle', 'Storrs', 'ostorrsa7@army.mil', 'Female'),
(369, '84-577-4885', 'Zabrina', 'Valois', 'zvaloisa8@umich.edu', 'Female'),
(370, '87-689-0836', 'Willdon', 'Kew', 'wkewa9@chronoengine.com', 'Male'),
(371, '49-565-5418', 'Allyn', 'Kneale', 'aknealeaa@nytimes.com', 'Female'),
(372, '50-959-3227', 'Shena', 'Delong', 'sdelongab@mit.edu', 'Female'),
(373, '93-929-5996', 'Sascha', 'Dangl', 'sdanglac@odnoklassniki.ru', 'Male'),
(374, '23-764-3002', 'Gilburt', 'MacKissack', 'gmackissackad@spiegel.de', 'Male'),
(375, '51-111-7765', 'Laurene', 'Huzzey', 'lhuzzeyae@mayoclinic.com', 'Female'),
(376, '82-107-1065', 'Shirline', 'Willson', 'swillsonaf@ed.gov', 'Female'),
(377, '98-808-3995', 'Waite', 'Mc Combe', 'wmccombeag@issuu.com', 'Male'),
(378, '76-899-4536', 'Linda', 'Langham', 'llanghamah@sciencedaily.com', 'Female'),
(379, '42-954-0211', 'Bessie', 'Grizard', 'bgrizardai@infoseek.co.jp', 'Female'),
(380, '65-948-8698', 'Windham', 'Nattrass', 'wnattrassaj@buzzfeed.com', 'Male'),
(381, '64-430-6211', 'Shurlock', 'Cline', 'sclineak@google.it', 'Male'),
(382, '14-899-5203', 'Gale', 'Brosini', 'gbrosinial@github.io', 'Non-binary'),
(383, '16-692-4705', 'Beret', 'Kristiansen', 'bkristiansenam@netscape.com', 'Non-binary'),
(384, '18-512-9522', 'Sybyl', 'Jaine', 'sjainean@bigcartel.com', 'Female'),
(385, '05-995-0386', 'Eal', 'Vernall', 'evernallao@cbc.ca', 'Bigender'),
(386, '73-448-2860', 'Corena', 'Laing', 'claingap@discovery.com', 'Female'),
(387, '50-580-5042', 'Dorise', 'Florez', 'dflorezaq@istockphoto.com', 'Female'),
(388, '30-503-4531', 'Tymothy', 'Ree', 'treear@va.gov', 'Agender'),
(389, '93-578-4944', 'Zorine', 'Cloy', 'zcloyas@netscape.com', 'Female'),
(390, '02-811-8870', 'Domenic', 'Mitcham', 'dmitchamat@dot.gov', 'Bigender'),
(391, '37-826-4333', 'Kristine', 'Eathorne', 'keathorneau@businessinsider.com', 'Female'),
(392, '65-056-8699', 'Vlad', 'Gianinotti', 'vgianinottiav@github.com', 'Male'),
(393, '67-411-1499', 'Oona', 'Roggeman', 'oroggemanaw@spotify.com', 'Female'),
(394, '38-222-5304', 'Rasia', 'Sobey', 'rsobeyax@china.com.cn', 'Female'),
(395, '24-760-0975', 'Marcelle', 'Dufty', 'mduftyay@slideshare.net', 'Female'),
(396, '45-220-7777', 'Caye', 'Itzik', 'citzikaz@uiuc.edu', 'Female'),
(397, '50-424-9594', 'Fionnula', 'Josskovitz', 'fjosskovitzb0@state.gov', 'Female'),
(398, '36-919-8677', 'Fredric', 'Dutteridge', 'fdutteridgeb1@sbwire.com', 'Male'),
(399, '49-432-5816', 'Melita', 'Corten', 'mcortenb2@sitemeter.com', 'Female'),
(400, '29-430-4904', 'Jolene', 'Kiddle', 'jkiddleb3@delicious.com', 'Female'),
(401, '14-397-5007', 'Reeva', 'Caldeyroux', 'rcaldeyrouxb4@webs.com', 'Female'),
(402, '83-667-1668', 'Ryon', 'Grishin', 'rgrishinb5@lycos.com', 'Male'),
(403, '44-930-6005', 'Anneliese', 'Plinck', 'aplinckb6@behance.net', 'Female'),
(404, '90-152-1325', 'Edwina', 'Balfour', 'ebalfourb7@dmoz.org', 'Female'),
(405, '82-997-4841', 'Langsdon', 'Andreotti', 'landreottib8@paypal.com', 'Male'),
(406, '70-039-1642', 'Northrup', 'Lieb', 'nliebb9@diigo.com', 'Male'),
(407, '10-872-3185', 'Kimble', 'Shelford', 'kshelfordba@dailymail.co.uk', 'Male'),
(408, '00-541-5832', 'Angel', 'Althorp', 'aalthorpbb@soup.io', 'Agender'),
(409, '60-981-7107', 'Alejandro', 'McIlriach', 'amcilriachbc@topsy.com', 'Male'),
(410, '69-914-5914', 'Pearl', 'Rust', 'prustbd@domainmarket.com', 'Bigender'),
(411, '10-191-0089', 'Ernst', 'Philbrick', 'ephilbrickbe@berkeley.edu', 'Male'),
(412, '59-863-8210', 'Letty', 'Dehm', 'ldehmbf@soup.io', 'Female'),
(413, '57-167-7505', 'Tobias', 'Ivins', 'tivinsbg@cam.ac.uk', 'Genderfluid'),
(414, '53-080-5918', 'Lisha', 'Goede', 'lgoedebh@google.ru', 'Female'),
(415, '21-306-8310', 'Leonidas', 'Easton', 'leastonbi@china.com.cn', 'Male'),
(416, '73-344-7520', 'Evania', 'Roseblade', 'erosebladebj@twitpic.com', 'Female'),
(417, '06-524-8642', 'Tabb', 'Wright', 'twrightbk@admin.ch', 'Male'),
(418, '80-305-7569', 'Johann', 'Pharaoh', 'jpharaohbl@virginia.edu', 'Male'),
(419, '69-964-4518', 'Alisander', 'Marzele', 'amarzelebm@senate.gov', 'Male'),
(420, '65-075-4358', 'Harlan', 'Dowe', 'hdowebn@accuweather.com', 'Male'),
(421, '73-948-5197', 'Cointon', 'Kondrat', 'ckondratbo@reddit.com', 'Male'),
(422, '64-939-8349', 'Patricia', 'Carnock', 'pcarnockbp@washington.edu', 'Female'),
(423, '04-532-5387', 'Harrie', 'De Cleen', 'hdecleenbq@t-online.de', 'Female'),
(424, '25-712-1949', 'Billy', 'Duignan', 'bduignanbr@ca.gov', 'Female'),
(425, '75-223-1123', 'Adan', 'Rubinow', 'arubinowbs@theglobeandmail.com', 'Female'),
(426, '74-381-6142', 'Appolonia', 'Sercombe', 'asercombebt@facebook.com', 'Female'),
(427, '22-304-4514', 'Aldridge', 'Fittes', 'afittesbu@narod.ru', 'Male'),
(428, '23-472-2883', 'Derwin', 'Lattin', 'dlattinbv@bloomberg.com', 'Genderqueer'),
(429, '26-764-8014', 'Karlie', 'Lyston', 'klystonbw@purevolume.com', 'Bigender'),
(430, '55-038-5681', 'Sashenka', 'Glentworth', 'sglentworthbx@example.com', 'Female'),
(431, '17-721-7669', 'Bank', 'Bowcock', 'bbowcockby@so-net.ne.jp', 'Male'),
(432, '85-367-8454', 'Mariann', 'Common', 'mcommonbz@google.co.uk', 'Female'),
(433, '52-471-9124', 'Dominik', 'Billing', 'dbillingc0@creativecommons.org', 'Non-binary'),
(434, '59-962-2311', 'Montague', 'Walsh', 'mwalshc1@indiegogo.com', 'Male'),
(435, '05-350-6570', 'Corette', 'Maggill\'Andreis', 'cmaggillandreisc2@dropbox.com', 'Female'),
(436, '09-565-0097', 'Rozalin', 'Beedie', 'rbeediec3@ask.com', 'Female'),
(437, '48-758-0803', 'Jacinda', 'Bluschke', 'jbluschkec4@studiopress.com', 'Female'),
(438, '06-580-5349', 'Alexandro', 'Claypool', 'aclaypoolc5@webeden.co.uk', 'Male'),
(439, '66-186-3219', 'Reynold', 'Mcasparan', 'rmcasparanc6@shutterfly.com', 'Male'),
(440, '13-330-3731', 'Roanne', 'Raynor', 'rraynorc7@facebook.com', 'Agender'),
(441, '60-386-3320', 'Hewet', 'Balsom', 'hbalsomc8@etsy.com', 'Male'),
(442, '40-794-8086', 'Odo', 'O\'Kuddyhy', 'ookuddyhyc9@phoca.cz', 'Male'),
(443, '31-814-0785', 'Christina', 'Hylands', 'chylandsca@yahoo.co.jp', 'Female'),
(444, '34-021-7206', 'Carroll', 'Lobbe', 'clobbecb@cbslocal.com', 'Male'),
(445, '32-471-9286', 'Timoteo', 'Feasby', 'tfeasbycc@amazon.co.uk', 'Male'),
(446, '52-141-3813', 'Elmo', 'MacNeilley', 'emacneilleycd@deliciousdays.com', 'Male'),
(447, '71-636-9721', 'Donetta', 'Pick', 'dpickce@umich.edu', 'Female'),
(448, '45-337-3380', 'Selena', 'Rames', 'sramescf@google.co.jp', 'Female'),
(449, '70-330-7380', 'Launce', 'MacKibbon', 'lmackibboncg@vimeo.com', 'Male'),
(450, '06-180-0028', 'Timothee', 'Honnicott', 'thonnicottch@google.com.hk', 'Male'),
(451, '94-641-5330', 'Candis', 'McGray', 'cmcgrayci@nasa.gov', 'Bigender'),
(452, '10-080-9197', 'Natale', 'Barosch', 'nbaroschcj@wired.com', 'Male'),
(453, '27-122-1220', 'Lincoln', 'Brickwood', 'lbrickwoodck@wikipedia.org', 'Male'),
(454, '44-070-9928', 'Curt', 'Normanville', 'cnormanvillecl@hostgator.com', 'Male'),
(455, '80-863-0974', 'Tera', 'Leathes', 'tleathescm@pagesperso-orange.fr', 'Female'),
(456, '77-034-4159', 'Glynn', 'Bonsey', 'gbonseycn@eepurl.com', 'Male'),
(457, '27-515-9923', 'Gerri', 'McAlinion', 'gmcalinionco@irs.gov', 'Female'),
(458, '04-756-8247', 'Tadeo', 'Wickie', 'twickiecp@blogspot.com', 'Male'),
(459, '04-633-8477', 'Leena', 'Cassella', 'lcassellacq@example.com', 'Female'),
(460, '82-936-0879', 'Tova', 'Miguel', 'tmiguelcr@howstuffworks.com', 'Female'),
(461, '95-793-5486', 'Alvinia', 'Gathercoal', 'agathercoalcs@sphinn.com', 'Female'),
(462, '01-997-6267', 'Harlin', 'Galland', 'hgallandct@businessweek.com', 'Male'),
(463, '54-835-3081', 'Rolfe', 'Costock', 'rcostockcu@jiathis.com', 'Male'),
(464, '89-633-9314', 'Brendon', 'Ridewood', 'bridewoodcv@e-recht24.de', 'Male'),
(465, '40-413-0429', 'Paige', 'Threlfall', 'pthrelfallcw@t-online.de', 'Female'),
(466, '74-147-5661', 'Rolph', 'Searston', 'rsearstoncx@google.es', 'Male'),
(467, '18-408-7527', 'Jenica', 'Holt', 'jholtcy@imdb.com', 'Female'),
(468, '76-356-6469', 'Anabelle', 'Jakobsson', 'ajakobssoncz@nationalgeographic.com', 'Female'),
(469, '98-820-9050', 'Erin', 'Deary', 'edearyd0@ovh.net', 'Female'),
(470, '14-657-3998', 'Adriana', 'McLese', 'amclesed1@wsj.com', 'Polygender'),
(471, '49-627-2793', 'Moore', 'Poizer', 'mpoizerd2@pbs.org', 'Male'),
(472, '02-636-5481', 'Lilias', 'Entres', 'lentresd3@walmart.com', 'Female'),
(473, '66-759-5017', 'Eugenius', 'Esler', 'eeslerd4@1688.com', 'Male'),
(474, '50-364-2375', 'Dermot', 'Kubecka', 'dkubeckad5@businessweek.com', 'Male'),
(475, '73-584-2510', 'Goran', 'Hounsome', 'ghounsomed6@jiathis.com', 'Agender'),
(476, '24-459-9905', 'Rawley', 'Shatliffe', 'rshatliffed7@hao123.com', 'Male'),
(477, '13-370-2507', 'Carol-jean', 'Covely', 'ccovelyd8@macromedia.com', 'Non-binary'),
(478, '93-318-6181', 'Yorgos', 'Wardell', 'ywardelld9@indiatimes.com', 'Male'),
(479, '46-886-6163', 'Karna', 'Kerwick', 'kkerwickda@walmart.com', 'Agender'),
(480, '32-470-4207', 'Karolina', 'McCafferky', 'kmccafferkydb@de.vu', 'Agender'),
(481, '62-139-5414', 'Benn', 'Ambrogi', 'bambrogidc@google.de', 'Male'),
(482, '65-910-5997', 'Korrie', 'Tisor', 'ktisordd@hubpages.com', 'Female'),
(483, '10-238-4238', 'Hayward', 'Hurche', 'hhurchede@jalbum.net', 'Male'),
(484, '40-462-3770', 'Sim', 'Madgwick', 'smadgwickdf@ihg.com', 'Male'),
(485, '97-985-2272', 'Gherardo', 'Hebble', 'ghebbledg@last.fm', 'Male'),
(486, '16-492-8817', 'Camilla', 'Hassent', 'chassentdh@uol.com.br', 'Female'),
(487, '03-465-1175', 'Iosep', 'Straine', 'istrainedi@omniture.com', 'Male'),
(488, '08-042-7370', 'Ferguson', 'Sitlinton', 'fsitlintondj@e-recht24.de', 'Genderfluid'),
(489, '06-550-6647', 'Filberte', 'Domegan', 'fdomegandk@apple.com', 'Polygender'),
(490, '35-274-5892', 'Sybilla', 'Roskrug', 'sroskrugdl@webs.com', 'Female'),
(491, '42-188-1748', 'Woodrow', 'Standingford', 'wstandingforddm@histats.com', 'Male'),
(492, '90-594-1000', 'Barney', 'Gerdts', 'bgerdtsdn@vinaora.com', 'Male'),
(493, '28-014-1783', 'Ardine', 'Simonini', 'asimoninido@europa.eu', 'Female'),
(494, '92-841-1277', 'Hewet', 'Whitelock', 'hwhitelockdp@shinystat.com', 'Genderfluid'),
(495, '93-591-1391', 'Devan', 'Sarjent', 'dsarjentdq@google.co.jp', 'Female'),
(496, '31-910-8584', 'Ulrike', 'Everit', 'ueveritdr@hud.gov', 'Female'),
(497, '78-862-2998', 'Aurelie', 'Bugbee', 'abugbeeds@yahoo.com', 'Female'),
(498, '80-011-5202', 'Elladine', 'Giannotti', 'egiannottidt@plala.or.jp', 'Female'),
(499, '65-765-9358', 'Betty', 'McGookin', 'bmcgookindu@google.pl', 'Female'),
(500, '92-985-1246', 'Jennee', 'Roncelli', 'jroncellidv@independent.co.uk', 'Female'),
(501, '91-603-5179', 'Lula', 'Cashman', 'lcashmandw@digg.com', 'Female'),
(502, '60-100-1239', 'Nowell', 'Minico', 'nminicodx@paypal.com', 'Male'),
(503, '55-608-0725', 'Sonny', 'Sixsmith', 'ssixsmithdy@dyndns.org', 'Female'),
(504, '41-178-1556', 'Kalila', 'Sambles', 'ksamblesdz@eventbrite.com', 'Agender'),
(505, '63-070-3087', 'Karla', 'Pentland', 'kpentlande0@rediff.com', 'Female'),
(506, '25-462-2178', 'Amabel', 'Donneely', 'adonneelye1@addthis.com', 'Female'),
(507, '07-118-7926', 'Davide', 'Roumier', 'droumiere2@blogspot.com', 'Male'),
(508, '94-669-3166', 'Janine', 'Gibby', 'jgibbye3@pagesperso-orange.fr', 'Female'),
(509, '50-120-0730', 'Lowrance', 'Bate', 'lbatee4@technorati.com', 'Male'),
(510, '15-768-7739', 'Lib', 'Trustram', 'ltrustrame5@reddit.com', 'Genderqueer'),
(511, '49-953-6401', 'Hestia', 'MacDaid', 'hmacdaide6@themeforest.net', 'Female'),
(512, '41-910-4527', 'Isiahi', 'Rabier', 'irabiere7@edublogs.org', 'Male'),
(513, '47-384-4981', 'Tommie', 'Grady', 'tgradye8@infoseek.co.jp', 'Male'),
(514, '34-099-1941', 'Elliott', 'Carpenter', 'ecarpentere9@weather.com', 'Male'),
(515, '73-964-8270', 'Gelya', 'Upston', 'gupstonea@ameblo.jp', 'Female'),
(516, '32-502-4825', 'Odessa', 'Broxton', 'obroxtoneb@vkontakte.ru', 'Female'),
(517, '91-799-9505', 'Emmit', 'Keelinge', 'ekeelingeec@guardian.co.uk', 'Bigender'),
(518, '91-501-2970', 'Gerianna', 'South', 'gsouthed@weather.com', 'Female'),
(519, '37-077-5189', 'Janeva', 'Gregore', 'jgregoreee@pagesperso-orange.fr', 'Female'),
(520, '24-984-1946', 'Reg', 'Sanderson', 'rsandersonef@networkadvertising.org', 'Male'),
(521, '47-721-7414', 'Letizia', 'Jeavon', 'ljeavoneg@blinklist.com', 'Female'),
(522, '56-636-5361', 'Jemmy', 'Spinozzi', 'jspinozzieh@usda.gov', 'Female'),
(523, '01-197-4887', 'Fonsie', 'Chalfain', 'fchalfainei@biglobe.ne.jp', 'Male'),
(524, '46-656-8379', 'Humberto', 'Aitken', 'haitkenej@tripadvisor.com', 'Male'),
(525, '62-930-2362', 'Frans', 'Witherup', 'fwitherupek@ucoz.com', 'Male'),
(526, '94-555-5350', 'Ryon', 'Titman', 'rtitmanel@hp.com', 'Male'),
(527, '54-951-5458', 'Amandi', 'Bumphrey', 'abumphreyem@imgur.com', 'Female'),
(528, '78-911-4130', 'Alisun', 'Sheddan', 'asheddanen@discovery.com', 'Female'),
(529, '13-447-3146', 'Gage', 'Gallemore', 'ggallemoreeo@latimes.com', 'Male'),
(530, '05-071-3641', 'Brittne', 'Moger', 'bmogerep@quantcast.com', 'Female'),
(531, '01-333-6801', 'Harper', 'Flament', 'hflamenteq@google.com.hk', 'Male'),
(532, '25-803-8139', 'Gabie', 'Philippsohn', 'gphilippsohner@qq.com', 'Male'),
(533, '15-937-9286', 'Gayle', 'Abdon', 'gabdones@admin.ch', 'Genderfluid'),
(534, '76-816-0050', 'Merwin', 'Golden of Ireland', 'mgoldenofirelandet@europa.eu', 'Male'),
(535, '03-998-0650', 'Pattie', 'Iglesiaz', 'piglesiazeu@people.com.cn', 'Female'),
(536, '68-018-4157', 'Bunnie', 'Ranfield', 'branfieldev@gizmodo.com', 'Female'),
(537, '88-068-2674', 'Alfy', 'Shwalbe', 'ashwalbeew@bizjournals.com', 'Female'),
(538, '77-610-8599', 'Adiana', 'Dobbing', 'adobbingex@rambler.ru', 'Female'),
(539, '05-984-7980', 'Hetty', 'Baistow', 'hbaistowey@nbcnews.com', 'Female'),
(540, '15-796-9103', 'Thorstein', 'Alldread', 'talldreadez@omniture.com', 'Male'),
(541, '96-221-9064', 'Bebe', 'Benko', 'bbenkof0@blog.com', 'Female'),
(542, '09-368-4639', 'Margaretha', 'Devitt', 'mdevittf1@blinklist.com', 'Agender'),
(543, '64-215-7622', 'Dael', 'Shailer', 'dshailerf2@chicagotribune.com', 'Male'),
(544, '59-724-2504', 'Mandy', 'Luchetti', 'mluchettif3@liveinternet.ru', 'Female'),
(545, '32-098-2628', 'Mechelle', 'Harkins', 'mharkinsf4@java.com', 'Female'),
(546, '43-827-0190', 'Bella', 'Cecil', 'bcecilf5@unicef.org', 'Female'),
(547, '85-762-2298', 'Dorie', 'Oughton', 'doughtonf6@livejournal.com', 'Male'),
(548, '74-831-6822', 'Waldemar', 'Vossing', 'wvossingf7@epa.gov', 'Male'),
(549, '84-131-5915', 'Rozalin', 'Kensley', 'rkensleyf8@lulu.com', 'Female'),
(550, '96-548-1517', 'Fabien', 'Bosomworth', 'fbosomworthf9@youtube.com', 'Male'),
(551, '95-079-8949', 'Kissee', 'Haldon', 'khaldonfa@economist.com', 'Female'),
(552, '23-156-4402', 'Dulce', 'Burgiss', 'dburgissfb@noaa.gov', 'Female'),
(553, '13-919-0931', 'Blanca', 'Manueau', 'bmanueaufc@who.int', 'Female'),
(554, '60-170-6945', 'Haven', 'Yerrington', 'hyerringtonfd@github.com', 'Male'),
(555, '68-931-2069', 'Salvidor', 'Borrill', 'sborrillfe@photobucket.com', 'Male'),
(556, '76-870-2139', 'Judd', 'Hilary', 'jhilaryff@nymag.com', 'Genderqueer'),
(557, '61-557-0328', 'Lorita', 'Toynbee', 'ltoynbeefg@geocities.jp', 'Female'),
(558, '70-798-7761', 'Robbert', 'Selman', 'rselmanfh@discuz.net', 'Male'),
(559, '86-145-5570', 'Ollie', 'Rosin', 'orosinfi@bigcartel.com', 'Genderqueer'),
(560, '74-096-8818', 'Gabriella', 'Ruppert', 'gruppertfj@google.es', 'Genderfluid'),
(561, '68-129-5737', 'Betty', 'McMahon', 'bmcmahonfk@nbcnews.com', 'Female'),
(562, '77-691-6565', 'Baxter', 'Beardon', 'bbeardonfl@seesaa.net', 'Male'),
(563, '75-274-1146', 'Sidoney', 'O\'Donnell', 'sodonnellfm@usda.gov', 'Female'),
(564, '93-834-8183', 'Jordan', 'Waumsley', 'jwaumsleyfn@theglobeandmail.com', 'Bigender'),
(565, '83-849-6037', 'Kiele', 'Boick', 'kboickfo@lulu.com', 'Female'),
(566, '29-088-1755', 'Gilli', 'Toma', 'gtomafp@pen.io', 'Female'),
(567, '11-300-9575', 'Ranna', 'Donoher', 'rdonoherfq@wordpress.com', 'Female'),
(568, '75-492-3556', 'Mady', 'Skrines', 'mskrinesfr@salon.com', 'Female'),
(569, '94-027-3521', 'Bernardina', 'Breeze', 'bbreezefs@php.net', 'Female'),
(570, '44-695-8378', 'Englebert', 'Newbatt', 'enewbattft@bloglines.com', 'Male'),
(571, '64-993-0302', 'Ode', 'De Bell', 'odebellfu@howstuffworks.com', 'Male'),
(572, '41-944-3955', 'Wren', 'McEwen', 'wmcewenfv@furl.net', 'Female'),
(573, '48-242-2073', 'Ammamaria', 'Simeonov', 'asimeonovfw@yellowpages.com', 'Female'),
(574, '98-447-8451', 'Tann', 'Gerhts', 'tgerhtsfx@blog.com', 'Male'),
(575, '21-355-8320', 'Sam', 'Dongate', 'sdongatefy@yahoo.com', 'Female'),
(576, '40-083-9976', 'Alena', 'MacLaughlin', 'amaclaughlinfz@phoca.cz', 'Female'),
(577, '95-937-0549', 'Morris', 'Naismith', 'mnaismithg0@noaa.gov', 'Male'),
(578, '25-632-5336', 'Lark', 'Salliere', 'lsalliereg1@miibeian.gov.cn', 'Polygender'),
(579, '72-801-2307', 'Ashton', 'Taylorson', 'ataylorsong2@nhs.uk', 'Male'),
(580, '63-365-4640', 'Dell', 'Krolle', 'dkrolleg3@economist.com', 'Male'),
(581, '90-893-5035', 'Hermione', 'Bernuzzi', 'hbernuzzig4@statcounter.com', 'Genderqueer'),
(582, '85-688-7533', 'Anica', 'Shrubb', 'ashrubbg5@mashable.com', 'Female'),
(583, '60-495-7127', 'Thorsten', 'Stowte', 'tstowteg6@goo.gl', 'Male'),
(584, '21-080-7934', 'Jo', 'Perrottet', 'jperrottetg7@cbslocal.com', 'Female'),
(585, '55-881-6220', 'Delainey', 'Fermin', 'dferming8@ovh.net', 'Male'),
(586, '07-766-4998', 'Heidi', 'Bwy', 'hbwyg9@reuters.com', 'Female'),
(587, '45-461-9129', 'Vivianne', 'Cranmer', 'vcranmerga@phoca.cz', 'Female'),
(588, '67-689-2819', 'Gael', 'Leitche', 'gleitchegb@xing.com', 'Male'),
(589, '54-078-8038', 'Richart', 'Babst', 'rbabstgc@altervista.org', 'Male'),
(590, '04-490-0775', 'Charmion', 'Dowglass', 'cdowglassgd@dmoz.org', 'Genderfluid'),
(591, '40-718-9622', 'Ambrosius', 'Chicco', 'achiccoge@issuu.com', 'Male'),
(592, '88-487-7301', 'Conrad', 'Werny', 'cwernygf@flavors.me', 'Non-binary'),
(593, '72-245-5927', 'Cello', 'Rappport', 'crappportgg@wufoo.com', 'Male'),
(594, '96-933-5318', 'Annelise', 'Carine', 'acarinegh@soup.io', 'Polygender'),
(595, '39-538-0244', 'Nicoline', 'Wolfart', 'nwolfartgi@go.com', 'Female'),
(596, '48-297-0553', 'Maegan', 'Lampens', 'mlampensgj@ox.ac.uk', 'Female'),
(597, '51-901-8345', 'Basile', 'Daice', 'bdaicegk@github.com', 'Male'),
(598, '98-088-5043', 'Trude', 'todor', 'ttodorgl@kickstarter.com', 'Female'),
(599, '40-553-2334', 'Candi', 'Trathan', 'ctrathangm@multiply.com', 'Female'),
(600, '88-060-4975', 'Gray', 'Gollard', 'ggollardgn@ox.ac.uk', 'Male'),
(601, '59-090-0498', 'Cozmo', 'Verrier', 'cverriergo@elpais.com', 'Male'),
(602, '98-442-2535', 'Tiffani', 'Clooney', 'tclooneygp@canalblog.com', 'Agender'),
(603, '36-444-7311', 'Deb', 'Escoffrey', 'descoffreygq@kickstarter.com', 'Female'),
(604, '39-539-1907', 'Pall', 'Edeson', 'pedesongr@un.org', 'Male'),
(605, '94-384-7941', 'Camey', 'Rabat', 'crabatgs@blog.com', 'Male'),
(606, '09-399-4824', 'Mace', 'Penniall', 'mpenniallgt@shinystat.com', 'Male'),
(607, '86-297-9315', 'Ellerey', 'Dancer', 'edancergu@plala.or.jp', 'Male'),
(608, '09-010-2675', 'Erich', 'Worsell', 'eworsellgv@un.org', 'Genderqueer'),
(609, '07-746-3624', 'Bondon', 'Kivelhan', 'bkivelhangw@epa.gov', 'Male'),
(610, '29-439-2735', 'Valentine', 'Basindale', 'vbasindalegx@51.la', 'Male'),
(611, '20-852-7589', 'Cayla', 'Proud', 'cproudgy@fotki.com', 'Female'),
(612, '14-779-2973', 'Mose', 'Partkya', 'mpartkyagz@facebook.com', 'Male'),
(613, '46-413-0400', 'Xenia', 'Yetman', 'xyetmanh0@cornell.edu', 'Female'),
(614, '76-834-6317', 'Dorree', 'Ravilus', 'dravilush1@house.gov', 'Non-binary'),
(615, '74-261-2815', 'Archambault', 'Bate', 'abateh2@wired.com', 'Male'),
(616, '28-227-6742', 'Cate', 'Meneely', 'cmeneelyh3@marriott.com', 'Genderqueer'),
(617, '12-707-8234', 'Maud', 'Siburn', 'msiburnh4@homestead.com', 'Female'),
(618, '52-337-2358', 'Bruno', 'Milesop', 'bmilesoph5@theatlantic.com', 'Male'),
(619, '03-325-4974', 'Melodee', 'Gallant', 'mgallanth6@tiny.cc', 'Female'),
(620, '62-125-6594', 'Arleen', 'Morcomb', 'amorcombh7@unblog.fr', 'Female'),
(621, '94-886-1307', 'Ddene', 'Hadwin', 'dhadwinh8@quantcast.com', 'Female'),
(622, '21-241-4125', 'Maureen', 'Paolillo', 'mpaolilloh9@google.nl', 'Female'),
(623, '64-245-7644', 'Tamas', 'Calverd', 'tcalverdha@livejournal.com', 'Male'),
(624, '62-985-0267', 'Yul', 'Winchcomb', 'ywinchcombhb@multiply.com', 'Male'),
(625, '64-227-4109', 'Valentia', 'Huebner', 'vhuebnerhc@vkontakte.ru', 'Female'),
(626, '58-466-4058', 'Hilliard', 'Inggall', 'hinggallhd@amazon.de', 'Male'),
(627, '78-391-2066', 'Mendy', 'Shurmer', 'mshurmerhe@histats.com', 'Bigender'),
(628, '83-053-3930', 'Vernor', 'Dillestone', 'vdillestonehf@nationalgeographic.com', 'Male'),
(629, '92-881-0932', 'Andromache', 'Frigout', 'afrigouthg@goo.gl', 'Female'),
(630, '48-350-2400', 'Dorrie', 'Safell', 'dsafellhh@paypal.com', 'Genderfluid'),
(631, '57-835-8068', 'Adamo', 'Dench', 'adenchhi@gov.uk', 'Male'),
(632, '94-443-0656', 'Ernesta', 'Anderl', 'eanderlhj@thetimes.co.uk', 'Agender'),
(633, '24-707-8437', 'Essie', 'Claw', 'eclawhk@51.la', 'Female'),
(634, '63-241-2803', 'Thayne', 'Riping', 'tripinghl@skype.com', 'Male'),
(635, '56-830-2082', 'Kylynn', 'Nares', 'knareshm@bloglovin.com', 'Female'),
(636, '01-256-0606', 'Dasie', 'Brettel', 'dbrettelhn@zimbio.com', 'Female'),
(637, '00-785-7845', 'Way', 'Haughton', 'whaughtonho@a8.net', 'Male'),
(638, '31-968-7036', 'Cassie', 'Rotte', 'crottehp@furl.net', 'Male'),
(639, '83-709-0675', 'Hervey', 'Labrenz', 'hlabrenzhq@un.org', 'Male'),
(640, '21-275-1445', 'Rona', 'Extance', 'rextancehr@bloglines.com', 'Female'),
(641, '98-045-0272', 'Rodney', 'Murrigan', 'rmurriganhs@com.com', 'Genderqueer'),
(642, '68-322-6620', 'Cornela', 'Staunton', 'cstauntonht@squarespace.com', 'Genderfluid'),
(643, '40-535-4524', 'Janessa', 'Parchment', 'jparchmenthu@unc.edu', 'Agender'),
(644, '26-400-2993', 'Deedee', 'Ferroli', 'dferrolihv@tinypic.com', 'Bigender'),
(645, '52-592-6834', 'Natala', 'Batham', 'nbathamhw@npr.org', 'Female'),
(646, '40-597-9324', 'Micky', 'Eilhertsen', 'meilhertsenhx@pbs.org', 'Agender'),
(647, '18-262-2668', 'Darla', 'McCrorie', 'dmccroriehy@chicagotribune.com', 'Female'),
(648, '01-033-0935', 'Nessi', 'Brolechan', 'nbrolechanhz@w3.org', 'Female'),
(649, '49-081-6051', 'Gav', 'Harp', 'gharpi0@springer.com', 'Male'),
(650, '94-847-1665', 'Aili', 'Bengall', 'abengalli1@redcross.org', 'Female'),
(651, '52-414-8036', 'Tull', 'Skea', 'tskeai2@hostgator.com', 'Male'),
(652, '83-637-5480', 'Morlee', 'Kilsby', 'mkilsbyi3@google.es', 'Male'),
(653, '45-042-5007', 'Ruben', 'Klaes', 'rklaesi4@list-manage.com', 'Male'),
(654, '34-505-8141', 'Henrietta', 'MacFadyen', 'hmacfadyeni5@google.fr', 'Female');
INSERT INTO `people` (`id`, `password`, `first_name`, `last_name`, `email`, `gender`) VALUES
(655, '13-208-0053', 'Wendall', 'Netley', 'wnetleyi6@go.com', 'Non-binary'),
(656, '63-271-6991', 'Dimitri', 'Scyner', 'dscyneri7@wordpress.com', 'Male'),
(657, '39-622-8407', 'Thane', 'Dominique', 'tdominiquei8@aol.com', 'Male'),
(658, '79-056-8176', 'Merry', 'Fanton', 'mfantoni9@wiley.com', 'Male'),
(659, '67-151-7191', 'Alida', 'L\'Homme', 'alhommeia@prnewswire.com', 'Female'),
(660, '72-048-2361', 'Merwyn', 'Tickel', 'mtickelib@comsenz.com', 'Male'),
(661, '35-201-4568', 'Ravi', 'Doddridge', 'rdoddridgeic@webmd.com', 'Male'),
(662, '81-412-3251', 'Hubey', 'Mowat', 'hmowatid@usa.gov', 'Male'),
(663, '87-217-5947', 'Ingeborg', 'Cerie', 'icerieie@samsung.com', 'Female'),
(664, '55-625-7646', 'Bink', 'Brazear', 'bbrazearif@posterous.com', 'Male'),
(665, '43-815-1845', 'Godfree', 'Maharry', 'gmaharryig@huffingtonpost.com', 'Male'),
(666, '97-479-5845', 'Rochester', 'O\' Driscoll', 'rodriscollih@creativecommons.org', 'Male'),
(667, '35-266-8249', 'Tomas', 'Brabon', 'tbrabonii@go.com', 'Male'),
(668, '65-656-7259', 'Sharia', 'Al Hirsi', 'salhirsiij@ovh.net', 'Female'),
(669, '42-009-8295', 'Yuri', 'Cove', 'ycoveik@fotki.com', 'Male'),
(670, '05-501-5822', 'Pernell', 'Studdal', 'pstuddalil@bluehost.com', 'Polygender'),
(671, '91-160-5820', 'Fabe', 'Bridgeland', 'fbridgelandim@naver.com', 'Agender'),
(672, '68-961-9170', 'Farlee', 'Wardroper', 'fwardroperin@desdev.cn', 'Male'),
(673, '46-942-8591', 'Fabio', 'Challace', 'fchallaceio@mtv.com', 'Male'),
(674, '95-618-5117', 'Nels', 'Baggett', 'nbaggettip@census.gov', 'Male'),
(675, '26-054-2428', 'Delbert', 'Forster', 'dforsteriq@diigo.com', 'Male'),
(676, '86-152-1883', 'Vicki', 'Aberdalgy', 'vaberdalgyir@theatlantic.com', 'Female'),
(677, '97-269-9963', 'Ronnie', 'Slater', 'rslateris@linkedin.com', 'Male'),
(678, '92-672-3024', 'Athene', 'Spilsbury', 'aspilsburyit@webmd.com', 'Female'),
(679, '12-530-3068', 'Giselle', 'Berston', 'gberstoniu@unicef.org', 'Female'),
(680, '18-980-1211', 'Filip', 'Kauble', 'fkaubleiv@stanford.edu', 'Male'),
(681, '74-204-9683', 'Con', 'Tomasino', 'ctomasinoiw@infoseek.co.jp', 'Female'),
(682, '16-053-7555', 'Michaelina', 'Swain', 'mswainix@yahoo.com', 'Female'),
(683, '68-896-6268', 'Sigvard', 'Christin', 'schristiniy@wikipedia.org', 'Male'),
(684, '21-566-4410', 'Stacey', 'Tanser', 'stanseriz@amazon.co.uk', 'Female'),
(685, '89-065-6441', 'Tonie', 'Puddifer', 'tpuddiferj0@tripod.com', 'Female'),
(686, '01-958-7867', 'Sarette', 'Bachelar', 'sbachelarj1@drupal.org', 'Female'),
(687, '61-792-3624', 'Caresa', 'Edeson', 'cedesonj2@hexun.com', 'Female'),
(688, '42-011-5976', 'Cirilo', 'Gennrich', 'cgennrichj3@dedecms.com', 'Male'),
(689, '94-835-9853', 'Millicent', 'Crewther', 'mcrewtherj4@wikia.com', 'Female'),
(690, '52-370-9716', 'Brier', 'Hearnden', 'bhearndenj5@sbwire.com', 'Bigender'),
(691, '42-827-4045', 'Janis', 'Honacker', 'jhonackerj6@bluehost.com', 'Female'),
(692, '79-321-9097', 'Mandel', 'Innis', 'minnisj7@artisteer.com', 'Male'),
(693, '26-111-8676', 'Dimitri', 'Farge', 'dfargej8@elpais.com', 'Male'),
(694, '38-931-6340', 'Mychal', 'Raiston', 'mraistonj9@twitter.com', 'Male'),
(695, '77-003-8549', 'Herve', 'Bacup', 'hbacupja@reddit.com', 'Male'),
(696, '85-689-7866', 'Brittan', 'Lewsam', 'blewsamjb@people.com.cn', 'Female'),
(697, '98-156-5798', 'Goldarina', 'Dinesen', 'gdinesenjc@amazon.co.uk', 'Female'),
(698, '42-943-8503', 'Sylvan', 'Moughton', 'smoughtonjd@cnet.com', 'Male'),
(699, '53-489-7473', 'Shani', 'Kleisle', 'skleisleje@princeton.edu', 'Female'),
(700, '09-587-4270', 'Adams', 'Braxay', 'abraxayjf@unesco.org', 'Male'),
(701, '81-923-0820', 'Leonidas', 'McCullum', 'lmccullumjg@bbc.co.uk', 'Male'),
(702, '64-403-2890', 'Carina', 'Francombe', 'cfrancombejh@yolasite.com', 'Genderqueer'),
(703, '09-676-6536', 'Janey', 'Paunton', 'jpauntonji@shinystat.com', 'Female'),
(704, '91-712-9716', 'Michel', 'Coursor', 'mcoursorjj@so-net.ne.jp', 'Female'),
(705, '33-865-5743', 'Jarvis', 'Drains', 'jdrainsjk@last.fm', 'Male'),
(706, '35-440-1403', 'Ashton', 'Badland', 'abadlandjl@archive.org', 'Male'),
(707, '69-999-1546', 'Cash', 'Spacy', 'cspacyjm@wsj.com', 'Male'),
(708, '26-913-6867', 'Parrnell', 'Robichon', 'probichonjn@1688.com', 'Male'),
(709, '12-026-5060', 'Odie', 'Ciciari', 'ociciarijo@shop-pro.jp', 'Genderfluid'),
(710, '59-182-5288', 'Cherish', 'Goublier', 'cgoublierjp@chron.com', 'Female'),
(711, '77-959-4486', 'Ferrel', 'Ravens', 'fravensjq@thetimes.co.uk', 'Male'),
(712, '49-729-4705', 'Pauline', 'Smallshaw', 'psmallshawjr@tmall.com', 'Female'),
(713, '44-254-8585', 'Abdul', 'Oswal', 'aoswaljs@home.pl', 'Genderfluid'),
(714, '99-465-0946', 'Valerie', 'Jirzik', 'vjirzikjt@blog.com', 'Female'),
(715, '72-920-0561', 'Sherill', 'Lorman', 'slormanju@princeton.edu', 'Female'),
(716, '11-151-5614', 'Seward', 'Nornasell', 'snornaselljv@a8.net', 'Male'),
(717, '28-510-3645', 'Alana', 'Queenborough', 'aqueenboroughjw@paypal.com', 'Female'),
(718, '62-566-8679', 'Ker', 'Breckenridge', 'kbreckenridgejx@irs.gov', 'Male'),
(719, '08-980-3568', 'Kennan', 'Feehery', 'kfeeheryjy@barnesandnoble.com', 'Male'),
(720, '48-191-0262', 'Darrel', 'Cattemull', 'dcattemulljz@smh.com.au', 'Male'),
(721, '01-061-3392', 'Terrijo', 'Daniello', 'tdaniellok0@census.gov', 'Female'),
(722, '76-955-9822', 'Yardley', 'Akess', 'yakessk1@pen.io', 'Male'),
(723, '99-838-4711', 'Deloris', 'Lillo', 'dlillok2@google.com.hk', 'Female'),
(724, '94-985-4174', 'Benjie', 'Shimman', 'bshimmank3@desdev.cn', 'Male'),
(725, '23-918-8696', 'Margery', 'Kacheler', 'mkachelerk4@tinyurl.com', 'Female'),
(726, '65-326-0746', 'Noel', 'Buxcy', 'nbuxcyk5@histats.com', 'Male'),
(727, '09-703-5882', 'Mirna', 'Clampin', 'mclampink6@nyu.edu', 'Female'),
(728, '61-894-3764', 'Levin', 'Stother', 'lstotherk7@ameblo.jp', 'Male'),
(729, '81-650-5616', 'Olive', 'Mouncher', 'omouncherk8@furl.net', 'Female'),
(730, '38-733-2003', 'Antonella', 'Huyton', 'ahuytonk9@nih.gov', 'Genderqueer'),
(731, '34-489-7925', 'Joanne', 'Lockhart', 'jlockhartka@xing.com', 'Female'),
(732, '81-982-2709', 'Sayers', 'Dafforne', 'sdaffornekb@businesswire.com', 'Male'),
(733, '42-772-5539', 'Florrie', 'Shellard', 'fshellardkc@booking.com', 'Female'),
(734, '94-671-3586', 'Collen', 'MacGillacolm', 'cmacgillacolmkd@fastcompany.com', 'Female'),
(735, '31-843-0686', 'Mallorie', 'Smieton', 'msmietonke@privacy.gov.au', 'Female'),
(736, '62-259-4517', 'Jill', 'Lared', 'jlaredkf@vkontakte.ru', 'Female'),
(737, '19-925-6317', 'Grantley', 'Mohan', 'gmohankg@gov.uk', 'Male'),
(738, '02-510-0269', 'Mandie', 'Kilgrew', 'mkilgrewkh@g.co', 'Female'),
(739, '20-878-9802', 'Pavia', 'Merrigans', 'pmerriganski@msu.edu', 'Female'),
(740, '19-074-0877', 'Aluino', 'Petrasso', 'apetrassokj@rakuten.co.jp', 'Genderqueer'),
(741, '95-097-1650', 'Alleyn', 'Liddell', 'aliddellkk@shutterfly.com', 'Male'),
(742, '97-971-0730', 'Webster', 'Baudinot', 'wbaudinotkl@geocities.com', 'Male'),
(743, '77-271-8006', 'Christopher', 'Ibanez', 'cibanezkm@shareasale.com', 'Male'),
(744, '38-696-7551', 'Theodoric', 'Brave', 'tbravekn@comsenz.com', 'Male'),
(745, '11-539-1928', 'Rosabella', 'Charleston', 'rcharlestonko@yahoo.co.jp', 'Agender'),
(746, '58-161-5690', 'Ignatius', 'Oats', 'ioatskp@virginia.edu', 'Male'),
(747, '18-559-0153', 'Adria', 'Betonia', 'abetoniakq@go.com', 'Female'),
(748, '92-517-5492', 'Maddalena', 'Kuhnel', 'mkuhnelkr@cbsnews.com', 'Female'),
(749, '38-037-4144', 'Bobine', 'Mumbeson', 'bmumbesonks@skype.com', 'Female'),
(750, '46-569-1385', 'Rafaellle', 'Vasenkov', 'rvasenkovkt@hhs.gov', 'Male'),
(751, '66-467-3355', 'Malinde', 'McGillreich', 'mmcgillreichku@nbcnews.com', 'Female'),
(752, '56-946-0424', 'Basilio', 'Loeber', 'bloeberkv@boston.com', 'Male'),
(753, '18-178-9000', 'Alonso', 'Finlan', 'afinlankw@marketwatch.com', 'Male'),
(754, '25-876-4822', 'Maisie', 'Jacobowits', 'mjacobowitskx@freewebs.com', 'Female'),
(755, '51-902-7350', 'Krisha', 'Grammer', 'kgrammerky@ftc.gov', 'Male'),
(756, '19-586-1602', 'Frankie', 'Lambotin', 'flambotinkz@europa.eu', 'Female'),
(757, '29-332-2359', 'Shell', 'Minister', 'sministerl0@cbc.ca', 'Female'),
(758, '14-607-1838', 'Carleton', 'Didball', 'cdidballl1@clickbank.net', 'Male'),
(759, '86-896-6768', 'Stacey', 'Hunston', 'shunstonl2@ycombinator.com', 'Female'),
(760, '40-778-3828', 'Reilly', 'Lenaghen', 'rlenaghenl3@merriam-webster.com', 'Male'),
(761, '77-640-3651', 'Claudine', 'Downse', 'cdownsel4@reuters.com', 'Female'),
(762, '47-755-2637', 'Humphrey', 'Minchinton', 'hminchintonl5@mlb.com', 'Male'),
(763, '93-938-8936', 'Farlee', 'Mc Mechan', 'fmcmechanl6@zimbio.com', 'Male'),
(764, '79-365-8546', 'Winifield', 'Barford', 'wbarfordl7@last.fm', 'Male'),
(765, '00-395-4212', 'Loren', 'Lavalde', 'llavaldel8@hugedomains.com', 'Female'),
(766, '61-161-3926', 'Cathy', 'Tschierse', 'ctschiersel9@java.com', 'Female'),
(767, '42-348-4043', 'Dorey', 'Heale', 'dhealela@imdb.com', 'Agender'),
(768, '60-369-0575', 'Blane', 'Milier', 'bmilierlb@icq.com', 'Male'),
(769, '92-071-6544', 'Lin', 'De Castri', 'ldecastrilc@answers.com', 'Female'),
(770, '34-244-7550', 'Katine', 'Monsey', 'kmonseyld@miibeian.gov.cn', 'Female'),
(771, '53-637-6509', 'Ross', 'Jeaffreson', 'rjeaffresonle@jigsy.com', 'Male'),
(772, '79-870-4014', 'Pippa', 'Poland', 'ppolandlf@nationalgeographic.com', 'Female'),
(773, '07-444-4322', 'Diannne', 'Eary', 'dearylg@prnewswire.com', 'Non-binary'),
(774, '64-846-2513', 'Gloria', 'Capozzi', 'gcapozzilh@a8.net', 'Female'),
(775, '62-242-8403', 'Konstance', 'Redier', 'kredierli@umich.edu', 'Female'),
(776, '32-743-7246', 'Moise', 'Summerbell', 'msummerbelllj@amazonaws.com', 'Male'),
(777, '50-745-0226', 'Guillaume', 'Sex', 'gsexlk@yellowpages.com', 'Male'),
(778, '23-232-1271', 'Lusa', 'Clohessy', 'lclohessyll@economist.com', 'Female'),
(779, '83-635-0522', 'Carey', 'Doiley', 'cdoileylm@usa.gov', 'Male'),
(780, '29-603-2515', 'Gretal', 'Tolan', 'gtolanln@shareasale.com', 'Female'),
(781, '88-730-8073', 'Ted', 'Bocock', 'tbococklo@google.cn', 'Male'),
(782, '68-544-2313', 'Sandro', 'Korfmann', 'skorfmannlp@va.gov', 'Male'),
(783, '15-422-1019', 'Frederico', 'Gerrett', 'fgerrettlq@prweb.com', 'Male'),
(784, '67-426-4936', 'Devonne', 'Priscott', 'dpriscottlr@ycombinator.com', 'Bigender'),
(785, '45-338-0265', 'Padraic', 'Castanos', 'pcastanosls@rakuten.co.jp', 'Male'),
(786, '85-454-9851', 'Stern', 'Choules', 'schouleslt@goodreads.com', 'Bigender'),
(787, '42-699-2989', 'King', 'Curston', 'kcurstonlu@cnbc.com', 'Male'),
(788, '86-505-2371', 'Paola', 'Foulser', 'pfoulserlv@dot.gov', 'Female'),
(789, '17-860-4528', 'Carita', 'Aspall', 'caspalllw@storify.com', 'Female'),
(790, '42-899-8126', 'Merrill', 'Gorrick', 'mgorricklx@statcounter.com', 'Bigender'),
(791, '19-389-4586', 'Riki', 'Blewitt', 'rblewittly@unicef.org', 'Female'),
(792, '92-074-0371', 'Keane', 'Abbison', 'kabbisonlz@topsy.com', 'Male'),
(793, '73-568-0270', 'Junie', 'Aucott', 'jaucottm0@pen.io', 'Female'),
(794, '49-725-3368', 'Cassy', 'Longlands', 'clonglandsm1@rambler.ru', 'Female'),
(795, '01-852-7634', 'Liliane', 'Wagen', 'lwagenm2@sina.com.cn', 'Female'),
(796, '80-569-0154', 'Pip', 'Royden', 'proydenm3@slashdot.org', 'Male'),
(797, '76-142-9201', 'Bette-ann', 'Hariot', 'bhariotm4@npr.org', 'Female'),
(798, '15-823-9375', 'Alyda', 'MacSweeney', 'amacsweeneym5@vk.com', 'Female'),
(799, '10-379-9020', 'Ortensia', 'Arnason', 'oarnasonm6@cbsnews.com', 'Female'),
(800, '12-659-4949', 'Valerie', 'Mc Trusty', 'vmctrustym7@cisco.com', 'Female'),
(801, '20-272-3539', 'Hanni', 'Lansdown', 'hlansdownm8@ocn.ne.jp', 'Female'),
(802, '57-701-8092', 'Augy', 'Eddleston', 'aeddlestonm9@illinois.edu', 'Polygender'),
(803, '39-761-3095', 'Joycelin', 'Jedrych', 'jjedrychma@wisc.edu', 'Female'),
(804, '76-397-7004', 'Luce', 'Maskall', 'lmaskallmb@smugmug.com', 'Polygender'),
(805, '33-236-8967', 'Carlina', 'Whereat', 'cwhereatmc@paypal.com', 'Female'),
(806, '28-642-8394', 'Belvia', 'Melarkey', 'bmelarkeymd@liveinternet.ru', 'Female'),
(807, '09-553-9858', 'Marjie', 'Doby', 'mdobyme@microsoft.com', 'Female'),
(808, '40-229-8301', 'Sada', 'Rudham', 'srudhammf@china.com.cn', 'Female'),
(809, '53-110-1011', 'Nealy', 'Wordsley', 'nwordsleymg@yahoo.com', 'Male'),
(810, '62-455-5557', 'Brandi', 'Algeo', 'balgeomh@noaa.gov', 'Agender'),
(811, '90-004-1902', 'Haskel', 'Steckings', 'hsteckingsmi@microsoft.com', 'Male'),
(812, '28-545-1990', 'Ted', 'Lippitt', 'tlippittmj@vkontakte.ru', 'Female'),
(813, '67-514-7410', 'Inness', 'Byrne', 'ibyrnemk@cloudflare.com', 'Male'),
(814, '34-866-6457', 'Alley', 'Sheahan', 'asheahanml@noaa.gov', 'Male'),
(815, '53-969-8627', 'Fancy', 'Haccleton', 'fhaccletonmm@blinklist.com', 'Female'),
(816, '55-112-1715', 'Trueman', 'Ferrierio', 'tferrieriomn@1688.com', 'Male'),
(817, '03-564-6299', 'Kenny', 'Phelip', 'kphelipmo@e-recht24.de', 'Male'),
(818, '91-596-4330', 'Sofia', 'Pozzi', 'spozzimp@pcworld.com', 'Female'),
(819, '38-195-3262', 'Laney', 'Archdeckne', 'larchdecknemq@loc.gov', 'Female'),
(820, '74-451-0609', 'Aldon', 'Orgee', 'aorgeemr@instagram.com', 'Male'),
(821, '55-138-7874', 'Lorilyn', 'Arter', 'larterms@scribd.com', 'Female'),
(822, '70-188-3752', 'Onfroi', 'Gogin', 'ogoginmt@dmoz.org', 'Male'),
(823, '66-129-9407', 'Caren', 'Heditch', 'cheditchmu@blogger.com', 'Female'),
(824, '14-474-3748', 'Corey', 'McQuillen', 'cmcquillenmv@hp.com', 'Male'),
(825, '34-734-9867', 'Emlyn', 'Bogaert', 'ebogaertmw@angelfire.com', 'Male'),
(826, '70-881-5999', 'Christine', 'De Rechter', 'cderechtermx@vimeo.com', 'Female'),
(827, '52-874-1532', 'Caren', 'Sansome', 'csansomemy@ocn.ne.jp', 'Female'),
(828, '63-658-4216', 'Annamarie', 'Cardillo', 'acardillomz@posterous.com', 'Female'),
(829, '10-294-9494', 'Vikki', 'Eskrigge', 'veskriggen0@europa.eu', 'Female'),
(830, '28-201-9941', 'Evangelina', 'Bastow', 'ebastown1@so-net.ne.jp', 'Female'),
(831, '70-926-9934', 'Onida', 'Pigden', 'opigdenn2@salon.com', 'Female'),
(832, '10-413-0817', 'Jyoti', 'Puvia', 'jpuvian3@ning.com', 'Female'),
(833, '47-894-7416', 'Isac', 'Jacques', 'ijacquesn4@merriam-webster.com', 'Male'),
(834, '00-657-7051', 'Evelyn', 'Exposito', 'eexpositon5@nature.com', 'Non-binary'),
(835, '38-864-1802', 'Tamqrah', 'Marritt', 'tmarrittn6@un.org', 'Genderqueer'),
(836, '36-764-9987', 'Duffie', 'Rivers', 'driversn7@rakuten.co.jp', 'Male'),
(837, '82-078-3736', 'Kaine', 'Matschoss', 'kmatschossn8@livejournal.com', 'Male'),
(838, '35-138-2599', 'Barbey', 'Beales', 'bbealesn9@wsj.com', 'Female'),
(839, '30-465-7705', 'Lilly', 'Orht', 'lorhtna@senate.gov', 'Female'),
(840, '21-642-6514', 'Sanders', 'Wanderschek', 'swanderscheknb@t-online.de', 'Genderqueer'),
(841, '26-352-8061', 'Anna', 'Tombleson', 'atomblesonnc@tiny.cc', 'Female'),
(842, '20-889-4109', 'Giacobo', 'Bedenham', 'gbedenhamnd@va.gov', 'Male'),
(843, '80-509-0424', 'Julietta', 'Spenton', 'jspentonne@salon.com', 'Female'),
(844, '93-667-2203', 'Nealy', 'Mattingley', 'nmattingleynf@yahoo.com', 'Male'),
(845, '06-406-8959', 'Charlena', 'Lourens', 'clourensng@dion.ne.jp', 'Female'),
(846, '76-835-9816', 'Adolpho', 'Blaxlande', 'ablaxlandenh@lulu.com', 'Male'),
(847, '66-352-0718', 'Chrissy', 'Dibden', 'cdibdenni@360.cn', 'Male'),
(848, '26-381-1864', 'Cicily', 'Wilkin', 'cwilkinnj@craigslist.org', 'Female'),
(849, '33-252-8260', 'Julie', 'Lyon', 'jlyonnk@ycombinator.com', 'Male'),
(850, '06-056-8030', 'Ben', 'Hindsberg', 'bhindsbergnl@e-recht24.de', 'Male'),
(851, '20-187-8388', 'Locke', 'Piatkowski', 'lpiatkowskinm@goo.gl', 'Agender'),
(852, '45-195-4779', 'Wernher', 'MacRedmond', 'wmacredmondnn@photobucket.com', 'Male'),
(853, '79-217-2977', 'Quinlan', 'Phayre', 'qphayreno@ftc.gov', 'Bigender'),
(854, '19-302-7415', 'Rahel', 'Isakov', 'risakovnp@auda.org.au', 'Female'),
(855, '79-161-7752', 'Abe', 'Heppenspall', 'aheppenspallnq@devhub.com', 'Male'),
(856, '66-062-5907', 'Dwain', 'Sydes', 'dsydesnr@wiley.com', 'Male'),
(857, '31-676-4125', 'Justina', 'Daniels', 'jdanielsns@hp.com', 'Female'),
(858, '63-695-0809', 'Penelope', 'Gilfoy', 'pgilfoynt@furl.net', 'Female'),
(859, '47-425-8657', 'Cosme', 'Fullstone', 'cfullstonenu@msn.com', 'Male'),
(860, '85-191-5636', 'Horst', 'Preist', 'hpreistnv@pen.io', 'Agender'),
(861, '41-387-5939', 'Allie', 'Jewer', 'ajewernw@newsvine.com', 'Female'),
(862, '60-635-9245', 'D\'arcy', 'Eouzan', 'deouzannx@unblog.fr', 'Male'),
(863, '18-481-0730', 'Angie', 'Toderi', 'atoderiny@shinystat.com', 'Male'),
(864, '42-306-3966', 'Car', 'Willars', 'cwillarsnz@trellian.com', 'Male'),
(865, '70-631-1790', 'Maurine', 'Rippon', 'mrippono0@vk.com', 'Female'),
(866, '49-252-5979', 'Dione', 'Bottrill', 'dbottrillo1@epa.gov', 'Female'),
(867, '26-086-7735', 'Claudina', 'Roelvink', 'croelvinko2@nifty.com', 'Female'),
(868, '07-008-1121', 'Menard', 'Hodjetts', 'mhodjettso3@livejournal.com', 'Male'),
(869, '89-087-0595', 'Benito', 'Hastelow', 'bhastelowo4@feedburner.com', 'Male'),
(870, '05-617-5683', 'Yurik', 'Cianelli', 'ycianellio5@cmu.edu', 'Male'),
(871, '88-001-8047', 'Sherilyn', 'Deschelle', 'sdeschelleo6@businessweek.com', 'Female'),
(872, '20-196-2283', 'Amye', 'Hazelton', 'ahazeltono7@un.org', 'Non-binary'),
(873, '40-927-4914', 'Robbin', 'Scoles', 'rscoleso8@mail.ru', 'Female'),
(874, '69-354-8473', 'Aguie', 'Wildber', 'awildbero9@cyberchimps.com', 'Male'),
(875, '61-800-3998', 'Judy', 'Kwietek', 'jkwietekoa@prnewswire.com', 'Female'),
(876, '65-962-0449', 'Kev', 'Mion', 'kmionob@edublogs.org', 'Male'),
(877, '01-276-9036', 'Al', 'Cobon', 'acobonoc@twitpic.com', 'Male'),
(878, '80-834-4853', 'Shirley', 'Ruckert', 'sruckertod@amazon.de', 'Female'),
(879, '44-356-7480', 'Codi', 'Stopps', 'cstoppsoe@tripod.com', 'Agender'),
(880, '64-079-8660', 'Charley', 'Tonkinson', 'ctonkinsonof@exblog.jp', 'Male'),
(881, '49-667-7092', 'Freida', 'Parcell', 'fparcellog@examiner.com', 'Female'),
(882, '94-213-6935', 'Wyatt', 'Simoneau', 'wsimoneauoh@census.gov', 'Male'),
(883, '06-621-5345', 'Aristotle', 'Totterdill', 'atotterdilloi@wikispaces.com', 'Male'),
(884, '96-606-5571', 'Kristofor', 'Howsego', 'khowsegooj@gravatar.com', 'Male'),
(885, '82-941-4160', 'Addie', 'Featenby', 'afeatenbyok@java.com', 'Female'),
(886, '65-955-3068', 'Anjela', 'Bohea', 'aboheaol@springer.com', 'Female'),
(887, '51-205-6103', 'Barthel', 'Louch', 'blouchom@issuu.com', 'Male'),
(888, '60-151-0613', 'Nellie', 'Newis', 'nnewison@loc.gov', 'Female'),
(889, '67-344-0499', 'Arline', 'Kerrey', 'akerreyoo@technorati.com', 'Non-binary'),
(890, '39-601-3894', 'Lock', 'Ellcome', 'lellcomeop@illinois.edu', 'Male'),
(891, '92-323-2050', 'Gaynor', 'Beedham', 'gbeedhamoq@purevolume.com', 'Female'),
(892, '71-867-9986', 'Hazel', 'Riepel', 'hriepelor@buzzfeed.com', 'Male'),
(893, '90-687-2795', 'Billy', 'Bartelot', 'bbartelotos@gravatar.com', 'Male'),
(894, '14-268-6634', 'Berk', 'Sauven', 'bsauvenot@multiply.com', 'Male'),
(895, '30-456-1574', 'Corry', 'Arzu', 'carzuou@google.com.br', 'Female'),
(896, '73-575-7238', 'Dunc', 'Humpherson', 'dhumphersonov@elegantthemes.com', 'Male'),
(897, '82-427-5889', 'Renault', 'Costanza', 'rcostanzaow@amazon.de', 'Male'),
(898, '97-443-1634', 'Melania', 'Hadeke', 'mhadekeox@dagondesign.com', 'Female'),
(899, '58-145-9732', 'Clarinda', 'Creaney', 'ccreaneyoy@ow.ly', 'Polygender'),
(900, '56-064-9662', 'Othello', 'Ffrench', 'offrenchoz@ed.gov', 'Male'),
(901, '30-039-7639', 'Moishe', 'Westmancoat', 'mwestmancoatp0@histats.com', 'Male'),
(902, '30-997-3732', 'Inness', 'Sollon', 'isollonp1@marriott.com', 'Male'),
(903, '46-155-6341', 'Ely', 'Smogur', 'esmogurp2@quantcast.com', 'Male'),
(904, '91-650-6325', 'Ysabel', 'Whipple', 'ywhipplep3@rakuten.co.jp', 'Female'),
(905, '90-348-1890', 'Gerick', 'Moorerud', 'gmoorerudp4@go.com', 'Polygender'),
(906, '63-307-6707', 'Ashely', 'Stolting', 'astoltingp5@creativecommons.org', 'Female'),
(907, '31-264-6100', 'Arni', 'Hargreaves', 'ahargreavesp6@vinaora.com', 'Male'),
(908, '54-451-8077', 'Jolyn', 'Suston', 'jsustonp7@theguardian.com', 'Female'),
(909, '30-204-7716', 'Roseanne', 'Arias', 'rariasp8@redcross.org', 'Female'),
(910, '89-482-6244', 'Waly', 'Brunsden', 'wbrunsdenp9@apple.com', 'Female'),
(911, '03-946-5136', 'Edlin', 'Romeril', 'eromerilpa@sbwire.com', 'Male'),
(912, '88-792-9125', 'Alvin', 'Valentim', 'avalentimpb@parallels.com', 'Male'),
(913, '92-875-2293', 'Clovis', 'Doodney', 'cdoodneypc@phoca.cz', 'Female'),
(914, '78-290-0040', 'Luciana', 'Auten', 'lautenpd@chicagotribune.com', 'Female'),
(915, '47-122-9612', 'Tyler', 'Domengue', 'tdomenguepe@printfriendly.com', 'Agender'),
(916, '95-358-0762', 'Cole', 'Pimlett', 'cpimlettpf@constantcontact.com', 'Male'),
(917, '69-808-6531', 'Zarah', 'Luciani', 'zlucianipg@google.ca', 'Female'),
(918, '28-666-1596', 'Carson', 'Riepel', 'criepelph@ibm.com', 'Male'),
(919, '70-825-9668', 'Humberto', 'Toby', 'htobypi@kickstarter.com', 'Agender'),
(920, '10-150-6352', 'Raddie', 'Blackleech', 'rblackleechpj@elegantthemes.com', 'Genderqueer'),
(921, '48-821-7942', 'Enrico', 'Brokenshaw', 'ebrokenshawpk@ameblo.jp', 'Male'),
(922, '31-115-3019', 'Tremain', 'Meigh', 'tmeighpl@arstechnica.com', 'Male'),
(923, '20-155-0537', 'Lorrin', 'Standish-Brooks', 'lstandishbrookspm@ucoz.com', 'Female'),
(924, '33-652-4825', 'Nathalie', 'Tapton', 'ntaptonpn@1und1.de', 'Female'),
(925, '46-537-5561', 'Zorine', 'Josefovic', 'zjosefovicpo@zimbio.com', 'Genderqueer'),
(926, '53-950-6408', 'Karolina', 'Bearblock', 'kbearblockpp@ebay.co.uk', 'Female'),
(927, '46-606-8465', 'Manya', 'Brushfield', 'mbrushfieldpq@china.com.cn', 'Female'),
(928, '09-627-0141', 'Cash', 'Lambird', 'clambirdpr@printfriendly.com', 'Male'),
(929, '87-299-1222', 'Clifford', 'Graybeal', 'cgraybealps@princeton.edu', 'Male'),
(930, '53-328-1604', 'Weylin', 'Grangier', 'wgrangierpt@who.int', 'Male'),
(931, '47-631-9507', 'Curry', 'Keedwell', 'ckeedwellpu@bbb.org', 'Genderqueer'),
(932, '19-204-2669', 'Merv', 'Draper', 'mdraperpv@cnbc.com', 'Male'),
(933, '50-386-1373', 'Aldus', 'Chastanet', 'achastanetpw@wired.com', 'Male'),
(934, '84-811-3987', 'Geno', 'Amdohr', 'gamdohrpx@timesonline.co.uk', 'Male'),
(935, '39-851-7678', 'Tristan', 'Ewart', 'tewartpy@feedburner.com', 'Male'),
(936, '71-569-5480', 'Chantal', 'Hazeltine', 'chazeltinepz@earthlink.net', 'Female'),
(937, '65-011-9909', 'Clarisse', 'Penny', 'cpennyq0@google.ca', 'Female'),
(938, '38-729-1696', 'Orv', 'Yeowell', 'oyeowellq1@eventbrite.com', 'Male'),
(939, '34-903-0522', 'Marshall', 'Lehr', 'mlehrq2@indiatimes.com', 'Male'),
(940, '77-865-4249', 'Murielle', 'Dorning', 'mdorningq3@wunderground.com', 'Female'),
(941, '04-420-9320', 'Clementina', 'Tweede', 'ctweedeq4@yelp.com', 'Female'),
(942, '80-595-1569', 'Audre', 'Eyden', 'aeydenq5@canalblog.com', 'Female'),
(943, '57-350-1643', 'Sonni', 'Willstrop', 'swillstropq6@nasa.gov', 'Female'),
(944, '89-947-6111', 'Mord', 'Gasken', 'mgaskenq7@sciencedaily.com', 'Male'),
(945, '06-910-8897', 'Fidelia', 'Hollyland', 'fhollylandq8@wufoo.com', 'Female'),
(946, '62-457-6935', 'Jarvis', 'Yakunchikov', 'jyakunchikovq9@twitter.com', 'Male'),
(947, '54-975-9122', 'Fleur', 'Guilayn', 'fguilaynqa@bandcamp.com', 'Female'),
(948, '46-492-7767', 'Emile', 'Bateup', 'ebateupqb@hibu.com', 'Male'),
(949, '38-836-7355', 'Teresina', 'Meader', 'tmeaderqc@163.com', 'Female'),
(950, '58-251-8371', 'Raphael', 'Francescotti', 'rfrancescottiqd@ucla.edu', 'Male'),
(951, '65-075-0699', 'Devland', 'Humbatch', 'dhumbatchqe@marketwatch.com', 'Male'),
(952, '29-388-6470', 'Axe', 'Orwin', 'aorwinqf@wsj.com', 'Male'),
(953, '02-133-1365', 'Madonna', 'Lichtfoth', 'mlichtfothqg@csmonitor.com', 'Female'),
(954, '62-928-6019', 'Edwina', 'Meese', 'emeeseqh@mashable.com', 'Female'),
(955, '50-787-8068', 'Hermione', 'Hardacre', 'hhardacreqi@ycombinator.com', 'Female'),
(956, '19-891-9040', 'Cathlene', 'Winks', 'cwinksqj@goo.gl', 'Female'),
(957, '67-421-4377', 'Den', 'Realff', 'drealffqk@ameblo.jp', 'Male'),
(958, '48-192-2484', 'Tallia', 'Schachter', 'tschachterql@ask.com', 'Female'),
(959, '74-941-2818', 'Caddric', 'Nickless', 'cnicklessqm@ox.ac.uk', 'Male'),
(960, '75-915-8814', 'Rafe', 'Trickey', 'rtrickeyqn@ustream.tv', 'Agender'),
(961, '63-542-0453', 'Hadleigh', 'Haxell', 'hhaxellqo@theglobeandmail.com', 'Male'),
(962, '45-667-2483', 'Ardelle', 'Morford', 'amorfordqp@taobao.com', 'Non-binary'),
(963, '82-485-5800', 'Cathryn', 'Everett', 'ceverettqq@youku.com', 'Female'),
(964, '69-880-3157', 'Ricky', 'Rivalant', 'rrivalantqr@a8.net', 'Male'),
(965, '89-367-9437', 'Gay', 'Antrobus', 'gantrobusqs@dell.com', 'Male'),
(966, '99-317-7112', 'Roseanne', 'Aizik', 'raizikqt@intel.com', 'Female'),
(967, '92-024-8166', 'Melinde', 'Gutowska', 'mgutowskaqu@springer.com', 'Female'),
(968, '14-558-4616', 'Samara', 'Simpkiss', 'ssimpkissqv@a8.net', 'Female'),
(969, '64-872-2396', 'Shoshanna', 'Habbershon', 'shabbershonqw@gmpg.org', 'Female'),
(970, '74-923-0237', 'Reed', 'Bosdet', 'rbosdetqx@chron.com', 'Male'),
(971, '25-352-2706', 'Maxwell', 'Welman', 'mwelmanqy@sciencedaily.com', 'Male'),
(972, '03-943-9705', 'Salmon', 'Smethurst', 'ssmethurstqz@va.gov', 'Male'),
(973, '15-546-3644', 'Guenna', 'McNutt', 'gmcnuttr0@businessinsider.com', 'Female'),
(974, '89-047-9235', 'Felicdad', 'Meachan', 'fmeachanr1@china.com.cn', 'Female'),
(975, '30-388-5232', 'Nichole', 'Petracchi', 'npetracchir2@bloomberg.com', 'Female'),
(976, '02-499-7517', 'Mayor', 'Lepere', 'mleperer3@simplemachines.org', 'Male'),
(977, '71-771-4708', 'Ralina', 'Fearon', 'rfearonr4@t.co', 'Non-binary'),
(978, '22-840-9589', 'Gerta', 'Mattock', 'gmattockr5@hugedomains.com', 'Female'),
(979, '07-255-5346', 'Inga', 'Baudrey', 'ibaudreyr6@ezinearticles.com', 'Female'),
(980, '06-586-6881', 'Joane', 'Mouncey', 'jmounceyr7@sina.com.cn', 'Female'),
(981, '68-810-9328', 'Noelyn', 'Madders', 'nmaddersr8@nasa.gov', 'Female'),
(982, '64-508-4825', 'Thorsten', 'Hissett', 'thissettr9@wisc.edu', 'Male'),
(983, '76-851-1218', 'Phineas', 'Everson', 'peversonra@howstuffworks.com', 'Male'),
(984, '01-267-9541', 'Rebeca', 'D\'Elia', 'rdeliarb@vimeo.com', 'Female'),
(985, '82-591-9893', 'Wallace', 'Bestiman', 'wbestimanrc@wunderground.com', 'Male'),
(986, '73-046-1193', 'Cobby', 'Mudge', 'cmudgerd@g.co', 'Male'),
(987, '05-128-3170', 'Marcie', 'Rove', 'mrovere@yellowbook.com', 'Female'),
(988, '22-558-1800', 'Aksel', 'Wiggett', 'awiggettrf@un.org', 'Male'),
(989, '03-914-4209', 'Gram', 'Kofax', 'gkofaxrg@umich.edu', 'Male'),
(990, '07-943-9085', 'Wyn', 'Rebichon', 'wrebichonrh@constantcontact.com', 'Male'),
(991, '82-512-9715', 'Clevey', 'Drew', 'cdrewri@google.com.br', 'Male'),
(992, '62-444-9984', 'Joline', 'Bertomeu', 'jbertomeurj@creativecommons.org', 'Female'),
(993, '01-310-0044', 'Ricky', 'Castell', 'rcastellrk@parallels.com', 'Female'),
(994, '33-774-4938', 'Delaney', 'Brach', 'dbrachrl@spiegel.de', 'Male'),
(995, '05-294-4244', 'Kiley', 'Wasling', 'kwaslingrm@omniture.com', 'Female'),
(996, '53-290-3651', 'Lodovico', 'Speechly', 'lspeechlyrn@ftc.gov', 'Male'),
(997, '96-550-5418', 'Tuesday', 'Hedge', 'thedgero@flickr.com', 'Female'),
(998, '80-906-0746', 'Calli', 'Redhead', 'credheadrp@tinypic.com', 'Female'),
(999, '49-405-1994', 'Madella', 'Pinnick', 'mpinnickrq@pcworld.com', 'Female'),
(1000, '87-737-5090', 'Constance', 'Caze', 'ccazerr@hc360.com', 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `specs` text NOT NULL,
  `price` bigint(20) NOT NULL,
  `old_price` bigint(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `image_1` varchar(255) DEFAULT NULL,
  `image_2` varchar(255) DEFAULT NULL,
  `image_3` varchar(255) DEFAULT NULL,
  `category` text DEFAULT NULL,
  `buy_link` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `id_category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `slug`, `title`, `specs`, `price`, `old_price`, `status`, `image_1`, `image_2`, `image_3`, `category`, `buy_link`, `description`, `qr_code`, `created_at`, `id_category`) VALUES
(34, 'macbookair15m2', 'MacBook Air 15 M2', 'Apple M2 Chip (8-Core CPU 10-Core GPU) | 8GB RAM | 512GB SSD | 15.3\" Liquid Retina Display | Office 365', 20715000, 0, 'In Stock', '/Images/1750558213_MacBook Air 15 M2 2.jpg', '/Images/1750558213_MacBook Air 15 M2.jpeg', '', 'Laptop, Laptop By Brand, Laptop M2, Macbook Air, Apple', 'https://www.tokopedia.com/studioponsel/apple-macbook-air-m2-chip-2023-15-inch-512gb-256gb-ram-8gb-apple-256gb-midnight-37413?extParam=ivf%3Dfalse%26keyword%3Dmacbook+air+m2%26search_id%3D20250516074809456EC003EFFE56011WZX%26src%3Dsearch&t_id=1747380994320&t_st=15&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', '15-inch MacBook Air | 35W Dual USB-C Port Compact Power Adapter | USB-C to MagSafe 3 Cable (2m) | 8-Core CPU | 10-Core GPU | 8GB Unified Memory | 256GB/512GB SSD Storage | 16-core Neural Engine | 15.3-inch Liquid Retina display with True Tone | 1080p FaceTime HD camera | MagSafe 3 charging port | Two Thunderbolt/USB 4 ports | Magic Keyboard with Touch ID | Force Touch trackpad | 35W Dual USB-C Port Compact Power Adapter\r\n', '/Images/1750558213_qr MacBook Air 15 M2.png', '2025-06-22 09:10:13', 5),
(37, 'asusvivobookg014e1404fa', 'ASUS Vivobook Go 14 E1404FA', 'AMD Ryzen 5-7520U | AMD Radeon Graphics | 14\" FHD (1920 x 1080), 60 Hz Refresh Rate | 16GB LPDDR5 | Win 11 Home', 7349000, 0, 'In Stock', '/Images/1750559419_(1)ASUS Vivobook Go 14 E1404FA.jpg', '/Images/1750559419_ASUS Vivobook Go 14 E1404FA 2.jpg', '/Images/1750559419_ASUS Vivobook Go 14 E1404FA.jpeg', ' \"Laptop\", \"Laptop By Brand\", \"Laptop By VGA\",       \"Laptop Intel\", \"Laptop Intel Core i7\",       \"Laptop VGA Nvidia RTX\", \"Legion 5\", \"Lenovo\"', 'https://www.tokopedia.com/protechcom/asus-vivobook-go-14-e1404fa-ryzen-5-7520u-16gb-512gb-14-fhd-ohs-w11-ddr5-8gb-87e70?extParam=ivf%3Dfalse%26keyword%3Dasus+vivobook+go+14+e1404fa&src=topads&t_id=1747380994320&t_st=6&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : AMD Ryzen 5 7520U Processor 2.8GHz (6MB Cache, up to 4.3GHz, 4 cores, 8 Threads)|Graphics : AMD Radeon Graphics|Memory : 8GB LPDDR5 on board|Storage : 512GB M.2 NVMe PCIe 3.0 SSD|Display : 14.0-inch FHD (1920 x 1080) 16:9 aspect ratio, IPS-level Panel, 60Hz refresh rate, 250 nits, 45% NTSC color gamut, Anti-glare display|Operating System : Windows 11 Home|Software : Office Home Student 2024 + Microsoft 365 Basic (One Drive + Outlook) (1Year)|Keyboard : Backlit Chiclet Keyboard + FingerPrint (integrated with Touchpad)|Webcam : 720p HD camera With privacy shutter|Audio : SonicMaster Built-in speaker Built-in array microphone|Wireless : Wi-Fi 6E(802.11ax) (Dual band) 2*2 + Bluetooth 5.3 Wireless Card|Ports :|1x USB 2.0 Type-A|1x USB 3.2 Gen 1 Type-A|1x USB 3.2 Gen 1 Type-C|1x HDMI 1.4|1x 3.5mm Combo Audio Jack|1x DC-in\r\n', '/Images/1750559419_qr ASUS Vivobook Go 14 E1404FA.png', '2025-06-22 09:30:19', 4),
(38, 'acernitrov15i9', 'Acer Nitro V15', 'Intel Core i9-13900H | RTX 4060 | 15.6\" FHD (1920 x 1080) IPS, 144 Hz Refresh Rate | 16GB DDR5 | Win 11 + Home & Students 2021', 16599000, 0, 'In Stock', '/Images/1750559762_Acer Nitro V 15 ANV15-41-R99D.png', '/Images/1750559762_Acer Nitro V 15 ANV15-41-R99D 2.png', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Intel, Laptop Intel Core i9, Laptop RTX, Acer Nitro, Acer', 'https://www.tokopedia.com/acer-jakarta/acer-nitro-v-15-anv15-51-901s-rtx4060-intel-core-i9-13900h-16-512ssd-w11-ohs-fhd-ips-144hz-black-1729913490386158740', 'Processor : 13th Gen Intel Core i5-13420H 3.40 GHz [12 MB Cache, Up To 4.60 GHz, Octa Core (4P + 4E) 12 Threads]|Graphics : NVIDIA GeForce RTX 4050 6GB GDDR6 (TGP : 50W, MGP : 65W)|Memory : 2x8GB DDR5 5200MHz, 1 Slot Kosong Max up to 32GB|Storage : 512 GB SSD PCIe NVMe + 1 Slot Kosong Max up to 1TB Per slot|Display : 15.6″ FHD (1920 x 1080) IPS, 165Hz, 45% NTSC|System Operasi : Windows 11 Home|Software : Microsoft Office Home Student|Keyboard : Backlight Single Zone|Webcam : HD 720p with Purifyview AI + TNR|Ports :|3x USB 3.2 Gen 1 Type-A|1x USB 3.2 Gen 2 Type-C (Thunderbolt 4)|1x HDMI 2.1 Port|1x Ethernet (RJ-45)|1x Jack Audio|Battery : 57Wh|Wifi : Wi-Fi6 & Bluetooth 5.1\r\n', '/Images/1750559762_qr ACER Nitro V 15.png', '2025-06-22 09:36:02', 3),
(39, 'axiopongo725', 'Axioo Pongo 725', 'Intel Core i7-12650H | RTX 2050 | 15.6\" FHD (1920x1080), 144hz Refresh Rate | 16GB - 32GB DDR4 | Win 11 Home', 9899000, 0, 'In Stock', '/Images/1750560056_(1)Axio Pongo 725.jpg', '/Images/1750560056_Axio Pongo 725 2.webp', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Intel, Laptop Intel Core i7, Laptop RTX, Axioo Pongo, Axioo', 'https://www.tokopedia.com/gudanglaptopbsd/laptop-gaming-axio-pongo-725-intel-i7-12650h-16gb-1tb-rtx2050-fhd-w11-16gb-512gb-ssd-tanpa-paket-9d6b1?extParam=ivf%3Dfalse%26keyword%3Daxio+pongo+725%26search_id%3D20250516074621E99F3F53DAD4C12D0OG7%26src%3Dsearch&t_id=1747380994320&t_st=7&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Spesifikasi Processor: Intel® Core™ i7-12650H (10 Cores, 16 Threads, TDP:45 W)|Graphic Card: NVIDIA® GeForce RTX ™ 2050 Laptop GPU 4GB GDDR6 Up to 55W|Memory: 16GB DDR4 3200Mhz|Storage: 512 M.2 PCIe Gen. 4×4 NVMe SSD|Display: 15.6″ inch (16:9) 144Hz, FHD (1920 x 1080)|Operating System: Windows 11 PRO|Keyboard: Backlit Keyboard|Camera Front: 1.0M HD|Sound System:|Realtek HD Audio|Sound Blaster™ Studio|Built-in Microphone|Bluetooth 5.2|Speaker: 2 x Speakers|Full Range AC adapter, AC in 100~240V, 50~60Hz, DC output 20V 6A,120W|Embedded 4 cells Polymer battery pack, 54WH|I/O Ports:|1 x USB 2.0 port (Type A)|1 x USB 3.2 Gen 1 port (Type A)|2 x USB 3.2 Gen 2 ports (Type C)|1 x Mini Display port 1.4|1 x HDMI ™ output port (with HDCP)|1 x 2-in-1 Audio Jack (Headphone / Microphone)|1 x Microphone Jack|1 x RJ-45 GigaBit LAN port|1 x DC-in jack|1 x MicroSD Card reader Slot\r\n', '/Images/1750560056_qr Axio Pongo 725.png', '2025-06-22 09:40:56', 2),
(40, 'thinkpade14gen6', 'ThinkPad E14 Gen 6', 'AMD Ryzen 5 7535U | AMD Radeon 660M | 14\" WUXGA (1920x1200) IPS | 1x 8GB SO-DIMM DDR5-4800 | Win 11 Pro', 16100000, 0, 'In Stock', '/Images/1750560386_Laptop ThinkPad E14 Gen 6.webp', '/Images/1750560386_Thinkpad E14 2.webp', '', 'Laptop, Laptop By Brand, Laptop By AMD, Laptop Ryzen, Laptop Ryzen 5, Laptop RTX, Thinkpad', 'https://www.tokopedia.com/lenovo-official/lenovo-thinkpad-e14-gen-6-amd-ryzen-5-7535u-8gb-512gb-ssd-w11-pro-1731081929369355469', 'Processor: Intel Core Ultra 7 155U / 155H / 165U (up to 4.8 GHz) atau AMD Ryzen 5 7535U / 7535HS / Ryzen 7 7735U (up to 4.75 GHz)| \r\nGraphics: Intel Arc Graphics atau AMD Radeon 660M / 680M| \r\nMemory: 16GB DDR5-5600MHz (2x8GB), upgradeable up to 64GB| \r\nStorage: 512GB PCIe Gen 4 NVMe SSD + 1 slot kosong (up to 1TB per slot)| \r\nDisplay: 14\" WUXGA (1920x1200), IPS, anti-glare, 300 nits, 45% NTSC, 60Hz| \r\nOperating System: Windows 11 Home / Pro| \r\nKeyboard: Backlit keyboard dengan TrackPoint dan fingerprint reader (opsional)| \r\nWebcam: FHD 1080p + IR hybrid dengan privacy shutter| \r\nAudio: Dolby Atmos, dual 2W speaker, dual mic array| \r\nWireless: Wi-Fi 6E (802.11ax) + Bluetooth 5.2 / 5.3| \r\nPorts:| \r\n2x USB-A (Gen1 dan Gen2)| \r\n2x USB-C (1x Thunderbolt 4 + 1x USB-C 3.2 Gen 2 PD/DP)| \r\n1x HDMI 2.1| \r\n1x RJ-45 LAN| \r\n1x Audio Combo Jack (3.5mm)| \r\nBattery: 47Wh atau 57Wh, mendukung fast charging via USB-C 65W| \r\nChassis: Full aluminium, sertifikasi MIL-STD-810H| \r\nDimensi: 313 × 219.3 × 17.99 mm| \r\nBerat: ~1.44 kg\r\n', '/Images/1750560386_qr Lenovo ThinkPad E14 Gen 6.png', '2025-06-22 09:46:26', 1),
(43, 'acerliteal114m', 'Acer Lite (AL1-14M) - Metal Cover', 'Intel Core i3-1215U | Intel UHD Graphics | 14.0″ WUXGA 1920 x 120 | 1×8 GB DDR4 | Win 11 + Office Home & Students 2021', 6371000, 0, 'In Stock', '/Images/1750562866_Acer Lite (AL1-14M) - Metal Cover.jpeg', '/Images/1750562866_Acer Lite (AL1-14M) - Metal Cover 2.jpeg', '', ' Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i3, Laptop Intel UHD Graphics, Acer Lite, Acer', 'https://www.tokopedia.com/trendcomputerbdg/acer-lite-al1-14m-3mid-magical-color-metal-cover-intel-core-i3-1215u-8-512gb-14-wuxga-ips-win11-office-1731133430735079127?extParam=ivf%3Dfalse%26keyword%3Dacer+lite+%28al1-14m%29+-+metal+cover%26search_id%3D20250516075910E99F3F53DAD4C1334SBJ%26src%3Dsearch&t_id=1747380994320&t_st=23&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : Intel Core i3-1215U Processor (6 Cores, 4.4 Ghz) | Display : 14.0″ WUXGA 1920 x 1200, IPS Acer ComfyView LED-backlit TFT LCD | Memory : 1×8 GB DDR4 (Upgradeable) | Storage : 512GB SSD NVMe Gen3 | Graphics : Intel UHD Graphics | Keyboard : Backlit | Port : 3x USB 3.2 Gen 1, 1x USB Type-C, 1x HDMI port 1.4 with HDCP support | Wireless : Bluetooth 5.1 & Wi-Fi 5 AC | Camera : FHD Camera | Speaker : Two built-in stereo speakers | Material : Metal Top Cover | Battery : 57 Wh | Free : Bagpack | OS : Windows 11 Home & Office Home & Student 2021\r\n', '/Images/1750562866_qr Acer Lite (AL1-14M) - Metal Cover.png', '2025-06-22 10:27:46', 1),
(44, 'asusrogscar6532lwsi97sd6t', 'ASUS ROG Scar G532LWS-I97SD6T', 'Intel Core i9-10980HK | RTX 2070 | 15.6-inch FHD (1920×1080), 300Hz Refresh Rate | 2X16GB DDR4 | Win 10 Home', 62999000, 0, 'In Stock', '/Images/1750563488_Asus Rog Strix G16 G614J1 (1).jpg', '/Images/1750563488_Asus Rog Strix G16 G614J1 (2).jpg', '', 'Laptop, Laptop By Brand, Laptop Intel, Laptop Intel i9, Laptop RTX, Asus ROG, Asus', 'https://www.tokopedia.com/orbitcomputer/asus-rog-strix-scar-15-g532lws-i97sd6t-intel-core-i9-10980hk-rtx2070s?extParam=ivf%3Dfalse%26keyword%3Dasus+rog+scar+g532lws%26search_id%3D20250516073936D29076102C25EA0E5643%26src%3Dsearch&t_id=1747380994320&t_st=5&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel® Core™ i9‑10980HK (8 cores/16 threads, 2.4 GHz base up to 5.3 GHz, 16 MB cache)| Graphics: NVIDIA® GeForce RTX 2070 SUPER 8 GB GDDR6 (ROG Boost TDP up to ~115 W)| Memory: 32 GB DDR4 (2×16 GB) – dual‑channel, up to 64 GB|Storage: 2×1 TB M.2 PCIe NVMe SSD (total 2 TB)| Display: 15.6″ FHD (1920×1080) IPS-level, 300 Hz, 3 ms, 300 nits, 100 % sRGB|Operating System: Windows 10 Home (upgradeable to Windows 11)| Keyboard: Per-key RGB backlit, ROG Aura Sync, includes Keystone feature|Webcam: (external FHD 1080p @60 FPS included)| Audio: Stereo speakers, ROG-enhanced; combo audio jack (3.5 mm)| Wireless: Wi‑Fi 6 (802.11ax) 2×2 + Bluetooth 5.0 / 5.1|Ports: 3× USB 3.2 Gen 1 Type‑A | 1× USB 3.2 Gen 2 Type‑C (with DisplayPort) | 1× HDMI 2.0 / 2.1 | 1× RJ‑45 Ethernet | 1× 3.5 mm combo jack| Cooling: ROG Intelligent Cooling with Liquid‑Metal thermal compound|Battery: 66 Wh, 4‑cell Li‑ion| Weight & Dimensions: ~2.6 kg (5.7 lbs), ~14.2″ × 10.8″ × 1″| Extras: ROG Keystone II, Easy‑Upgrade design, Gig+ Wi‑Fi 6 + RangeBoost, per-key RGB, external FHD webcam \r\n', '/Images/1750563488_qr ASUS ROG STRIX SCAR 15 G532LWS-I97SD6T.png', '2025-06-22 10:38:08', 2),
(45, 'asusrogzephyrusg14', 'Asus ROG Zephyrus G14', 'AMD Ryzen 9 7940HS | RTX 4060 | 14\" QHD (2560 x 1600, WQXGA), 165Hz Refresh Rate | 16GB DDR5 |Win 11 Home', 23499000, 0, 'In Stock', '/Images/1750563866_ASUS ROG ZEPHYRUS G14 (1).jpg', '/Images/1750563866_ASUS ROG ZEPHYRUS G14 (2).jpg', '', ' Laptop, Laptop By Brand, Laptop By RTX, Laptop Ryzen, Laptop Ryzen 9, Laptop RTX, Asus ROG, Asus', 'https://www.tokopedia.com/gaminglaptopid/asus-rog-zephyrus-g14-ga402xv-ryzen-9-7940-rtx4060-16gb-1tb-w11-14-0qhd-ips-165hz-1731431711017305707?extParam=ivf%3Dtrue%26keyword%3Dasus+rog+zephyrus+g14%26search_id%3D20250516075344BEFF8E657ECC5A170AVG%26src%3Dsearch&t_id=1747380994320&t_st=20&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : AMD Ryzen 9 7940HS Mobile Processor (8-core/16-thread, 16MB L3 cache, up to 5.2 GHz max boost) | Graphics : NVIDIA GeForce RTX 4060 Laptop GPU ROG Boost: 2300MHz* at 125W (2250MHz Boost Clock+50MHz OC, 100W+25W Dynamic Boost)* | Display : ROG Nebula Display 14-inch QHD+ 16:10 (2560 x 1600, WQXGA) IPS-level Anti-glare display DCI-P3:100% Refresh Rate:165Hz Response Time: 3ms G-Sync Pantone Validated MUX Switch + NVIDIA Advanced Optimus | Memory : 16GB DDR5 on board (Max Capacity: 32GB) | Storage : 1TB PCIe 4.0 NVMe M.2 SSD | Keyboard : Backlit Chiclet Keyboard 1-Zone RGB | Camera : 1080P FHD IR Camera for Windows Hello | Network : Wi-Fi 6E(802.11ax) (Triple band) 2*2 + Bluetooth 5.3 Wireless Card | Battery : 76WHrs, 4S1P, 4-cell Li-ion | Power Supply : ø6.0, 240W AC Adapter, Output: 20V DC, 12A, 240W, Input: 100~240C AC 50/60Hz universal | OS : Windows 11 Home', '/Images/1750563866_qr Asus ROG Zephyrus G14.png', '2025-06-22 10:44:26', 3),
(46, 'asuszenbookoled14', 'Asus Zenbook 14 Oled UX3405MA', 'Intel Core Ultra 7 Processor 155H | Intel Arc Graphics | 14\" OLED | 32GB LPDDR5X | Win 11 + Home & Students 2021', 20850000, 0, 'In Stock', '/Images/1751114205_Asus Zenbook 14.png', '/Images/1751114205_zenbook 14 2.webp', '', ' Laptop, Laptop By Brand, Laptop By VGA, Laptop Intel, Laptop Intel Core i7, Laptop Intel Arc Graphics, Zenbook 14, Asus', 'https://www.tokopedia.com/istanakomputermalang/asus-zenbook-14-oled-ux3405ma-ultra-7-155h-32gb-1tb-ssd-w11-ohs-14-3k?extParam=ivf%3Dfalse%26keyword%3Dasus+zenbook+14+oled%26search_id%3D20250516073824359B7C8933E87129F0Z5%26src%3Dsearch&t_id=1747380994320&t_st=3&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Core Ultra 7 Processor 155H 1.4 GHz (24MB Cache, up to 4.8 GHz, 16 cores, 22 Threads) Intel AI Boost NPU |Intel Athena Program: Intel Evo Platform |Integrated GPU: Intel Arc Graphics |Memory: 32GB LPDDR5X on board |Storage: 1TB M.2 NVMe PCIe 4.0 SSD |Display: Non-touch screen 14.0-inch 3K (2880 x 1800) OLED 16:10 aspect ratio 120Hz refresh rate 400nits 100% DCI-P3 color gamut Glossy display |Military grade: US MIL-STD 810H military-grade standard |Operating System: Windows 11 Home |Office: Microsoft Office Home & Student 2021 |\r\nLCD cover-material: Aluminum |Front-facing camera: FHD camera with IR function to support Windows Hello With privacy shutter |I/O ports: 1x USB 3.2 Gen 1 Type-A, 2x Thunderbolt 4 supports display / power delivery, 1x HDMI 2.1 TMDS, 1x 3.5mm Combo Audio Jack |Audio: Smart Amp Technology, Built-in speaker, Built-in array microphone, harman/kardon (Premium) |AC Adapter: TYPE-C, 65W AC Adapter, Output: 20V DC, 3.25A, 65W, Input: 100-240V AC 50/60GHz universal |Battery: 75WHrs, 2S2P, 4-cell Li-ion |Keyboard type: Backlit Chiclet Keyboard Dimension (WxHxD): 31.24 x 22.01 x 1.49 ~ 1.49 cm (12.30″ x 8.67″ x 0.59″ ~ 0.59″) |Weight (with Battery): 1.20 kg (2.65 lbs) |Weight (without Battery): 0.91 kg (2.01 lbs)\r\n', '/Images/1751114205_qr Asus Zenbook 14 Oled UX3405MA.png', '2025-06-28 19:36:45', 4),
(47, 'lenovoloq15irx9', 'LENOVO LOQ 15IRX9 i7', 'Intel Core i7-13650HX | RTX 4060 | 15.6\" FHD (1920x1080), 144Hz Refresh Rate | 12GB SO-DIMM DDR5-4800 | Win 11 + Home & Students 2021', 17260000, 0, 'In Stock', '/Images/1751114443_Legion 5 15IRX9.webp', '/Images/1751114443_Lenovo Legion 7i (2).jpg', '', 'Laptop, Laptop By Brand, Laptop By VGA, Laptop Intel, Laptop Intel Core i7, Laptop RTX, Lenovo LOQ, Lenovo', 'https://www.tokopedia.com/distrilapid/lenovo-loq-15irx9-i7-13650hx-rtx-4060-ram-12gb-512gb-ssd-15-6-ips-144hz-1730864571714996137', 'Processor: Intel Core i7-13650HX, 14C (6P + 8E) / 20T, P-core 2.6 / 4.9GHz, E-core 1.9 / 3.6GHz, 24MB | Display: 15.6\" FHD (1920x1080) IPS 300nits Anti-glare, 100% sRGB, 144Hz, G-SYNC | RAM: 1x 12GB SO-DIMM DDR5-4800, Up to 32GB | Storage: 512GB SSD M.2 2242 PCIe 4.0x4 NVMe, Up to 2x M.2 SSD | Graphics: NVIDIA GeForce RTX 4060 8GB GDDR6, Boost Clock 2370MHz, TGP 115W, 233 AI TOPS | Keyboard: 4-Zone RGB Backlit, English | Wireless: Wi-Fi 6, 11ax 2x2 + BT5.2 | Ports: 3x USB-A (USB 5Gbps / USB 3.2 Gen 1), 1x USB-C (USB 10Gbps / USB 3.2 Gen 2) with PD 140W and DisplayPort 1.4, 1x HDMI 2.1 up to 8K/60Hz, 1x Headphone/microphone combo jack (3.5mm), 1x Ethernet (RJ-45), 1x Power connector | Camera: HD 720p with E-shutter | Audio: Stereo speakers 2W x2, optimized with Nahimic Gaming Audio | Battery: Integrated 60Wh, 170W Slim Tip (3-pin)\r\n', '/Images/1751114443_qr LENOVO LOQ 15IRX9 i7.png', '2025-06-28 19:40:43', 5),
(48, 'acergo14ai', 'ACER Aspire GO 14 AI', 'Intel Core 5 125H | Intel Arc Graphics | 14\" WUXGA (1920 x 1200) | 16GB DDR5 SO-DIMM | Win 11 + Office Home & Students 2024', 10089000, 0, 'In Stock', '/Images/1751114743_ACER Aspire GO 14 AI (1).jpg', '/Images/1751114743_ACER Aspire GO 14 AI (2).jpg', '/Images/1751114743_ACER Aspire GO 14 AI (3).jpg', '', 'https://www.tokopedia.com/acer-jakarta/acer-aspire-go-14-ai-ag14-71m-5471-intel-core-ultra-5-125h-16-512gb-ssd-windows-11-ohs-m365b-14-inch-wuxga-100srgb-ips-grey-1731695088294003860?extParam=ivf%3Dfalse%26keyword%3Dacer+aspire+go+14+ai+ag14+71m+5471+intel+core%E2%84%A2+ultra+5%26search_id%3D202506271300325B8ADD2A5D98B12363AX%26src%3Dsearch&t_id=1751029242384&t_st=1&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Intel Core Ultra 5 125H | Operational Sistem : Microsoft Windows 11 Home Single Language + Microsoft Office Home Student 2024 + Microsoft Office 365 Basic (1 year) | Memory : 16GB DDR5 | Storage : 512GB SSD NVME M.2 | Display : 14.0 inch WUXGA (1920 x 1200), 100sRGB, ComfyView (Matte), In-plane Switching (IPS) Technology | Graphics : Intel ARC Graphics | Ports : 1x USB Port Type C | 2x USB Port Type A | 1x HDMI 2.1 | 1x Audio Jack | 1x Micro SD Card | 1x Ethernet (RJ-45)', '/Images/1751114743_ACER Aspire GO 14 AI (qr).png', '2025-06-28 19:45:43', 5),
(51, 'advanpixwar', 'Advan Pixwar', 'AMD Ryzen 7 6800H | AMD Radeon 680M | 15,6\" (1920 x 1080) | 16 2x DDR5 SO-DIMM | Win 11 Home Original', 7899000, 0, 'In Stock', '/Images/1751115286_Advan Pixwar (1).jpg', '/Images/1751115286_Advan Pixwar (2).jpg', '/Images/1751115286_Advan Pixwar (3).jpg', '', 'https://www.tokopedia.com/advanstore/advan-pixwar-amd-ryzen-7-6800h-16gb-512gb-15-6-inch-ips-fhd-laptop-gaming-wifi-6-free-windows-11-upgradeable-1731488640804882279?extParam=ivf%3Dfalse%26keyword%3Dadvan+pixwar%26search_id%3D20250627132301432ACA3A1E345E134WNG%26src%3Dsearch&t_id=1751029242384&t_st=4&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Size : 359 x 261 x 18.7 mm | Weight : < 1.95 kg | Materials : A/D metal, B/C abs | Hinge Open Angle : 135° | CPU : AMD Ryzen 7 6800H | GPU : AMD Radeon 680M | Display : 15.6\'\' inch 16:9 1920 x 1080 FHD IPS 45% NTSC | RAM : 2x DDR5 SO-DIMM, 16GB 4800Mhz | Memory : 512GB SSD PCIe3.0 | Backlight Keyboard : Support | Connectivity : WiFi 6 802.11 b/g/n/ac/ax | Bluetooth Version : 5.3 | Camera : 2MP 1600 x 1200 | Battery : 11.55V, 5022mAh, 58Wh Smart Battery | Port Variants : 1x USB Type C 3.2 Gen1 (PD/DP/Charger/Data) | 1x USB Type C 3.2 Gen2 (PD/DP/Charger/Data) | 1x USB Type A 3.2 Gen2 | 1x USB Type A 2.0 | 1x USB Type C 3.2 Gen1 | 1x Standard HDMI 2.1 TMDS | 1x Audio Jack Ø3.5mm | 1x Kensington Lock | 1x SD', '/Images/1751115286_Advan Pixwar (qr).png', '2025-06-28 19:54:46', 4),
(52, 'advansoulmateplus', 'ADVAN Soulmate Plus', 'AMD Ryzen 5 3500U | AMD Radeon RX Vega 8 Graphics | 14\" (1366 x 768) | 8GB DDR4 | Win 11 Home Original', 3999000, 0, 'In Stock', '/Images/1751115414_ADVAN Soulmate Plus (1).jpg', '/Images/1751115414_ADVAN Soulmate Plus (2).jpg', '', '', 'https://www.tokopedia.com/advanstore/advan-soulmate-plus-amd-ryzen-5-3500u-8gb-256gb-14-hd-laptop-notebook-free-windows-11-upgradeable-1730584149378565991?extParam=ivf%3Dtrue%26keyword%3Dadvan+soulmate+plus%26search_id%3D2025062713301911B9842E0A271F244AAR%26src%3Dsearch&t_id=1751029242384&t_st=10&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Size : 322.4 x 210.2 x 19.9 mm | Weight : < 1.4 kg | Materials : ABS | CPU : AMD Ryzen 5 3500U | GPU : AMD Radeon RX Vega 8 Graphics | Display : 14\'\' inch 1366 x 768 | RAM : 8GB DDR4 (UPGRADEABLE) | Memory : 256GB SSD (UPGRADEABLE) | WiFi : AC WIFI (8821CE) | Bluetooth : 5.0 | Camera : 2MP 720HD | Battery : 6000 mAH 7.6V | Adapter : DC 19V 3.42A | Port Variants : 1x DC Port | 2x USB 3.2 Gen1 | 1x USB 2.0 | 1x HDMI 1.4 | 1x Audio Jack Ø3.5mm | 1x SD Card | 1x Type-C Full Function | 1x Kensington Lock', '/Images/1751115414_ADVAN Soulmate Plus (qr).png', '2025-06-28 19:56:54', 3),
(55, 'asusexpertbook', 'Asus ExpertBook P1', 'AMD Ryzen 5 7535HS | AMD Radeon Graphics | 14\" FHD (1920 x 1080) | 2x8GB DDR5 | Win 11 Home Original', 7399000, 0, 'In Stock', '/Images/1751116040_Asus ExpertBook P1 (1).jpg', '/Images/1751116040_Asus ExpertBook P1 (2).jpg', '/Images/1751116040_Asus ExpertBook P1 (3).jpg', '', 'https://www.tokopedia.com/agresid/asus-expertbook-p1-pm1403cda-ryzen-5-7535hs-8-16gb-512gb-w11-ohs-14-fhd-1731712803371385923?extParam=ivf%3Dfalse%26keyword%3Dasus+expertbook+p1%26search_id%3D20250627135321320722549D17510EEZ4O%26src%3Dsearch&t_id=1751029242384&t_st=44&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor : AMD Ryzen 5 7535HS Processor 3.3GHz (16MB Cache, up to 4.55 GHz, 6 cores, 12 Threads) | Graphics : AMD Radeon Graphics | Memory : 8/16GB DDR5 SO-DIMM, Memory Max Up to: 64GB | Storage : 512GB M.2 2280 NVMe PCIe 4.0 SSD | Expansion Slots : 2x DDR5 SO-DIMM slots | 1x M.2 2280 PCIe 4.0x4 | 1x M.2 2230 PCIe 4.0x4 | Display : Non-touch screen, 14.0-inch, FHD (1920 x 1080) 16:9, Wide view, Anti-glare display, LED Backlit, 300nits, NTSC: 45%, Screen-to-body ratio: 87% | Operating System : Windows 11 Home | I/O Ports : 2x USB 3.2 Gen 1 Type-A | 2x USB 3.2 Gen 2 Type-C (support display / power delivery) | 1x HDMI 1.4 | 1x 3.5mm Combo Audio Jack | 1x RJ45 Gigabit Ethernet | Keyboard & Touchpad : Chiclet Keyboard, 1.35mm Key-travel, Spill-resistant Keyboard | Battery : 50WHrs, 3S1P, 3-cell Li-ion | Power Supply : TYPE-C, 65W AC Adapter, Output: 20V DC, 3.25A, 65W, Input: 100~240V AC 50/60Hz universal | Dimensions (W x D x H) : 32.45 x 21.44 x 1.97 ~ 1.97 cm (12.78\" x 8.44\" x 0.78\" ~ 0.78\")', '/Images/1751116040_Asus ExpertBook P1 (qr).png', '2025-06-28 20:07:20', 2),
(57, 'axioomybooksaga12', 'Axioo MyBook Saga 12', 'Intel Core i5 1240H | Intel Iris Xe Graphics 80EU | 16\" 2.5K (2560 x 1600) | 8GB DDR4 | Win 11', 7399000, 0, 'In Stock', '/Images/1751116775_Axioo MyBook Saga 12 (1).jpg', '/Images/1751116775_Axioo MyBook Saga 12 (2).jpg', '/Images/1751116775_Axioo MyBook Saga 12 (3).jpg', '', 'https://www.tokopedia.com/axiooslimbook/laptop-axioo-mybook-saga-12-i5-1240p-8gb-256ssd-windows-11-16-inch-promo-8gb-0297a?extParam=ivf%3Dfalse%26keyword%3Daxioo+mybook+saga+12%26search_id%3D2025062714114934ED066DF378EF2CBBFC%26src%3Dsearch&t_id=1751029242384&t_st=49&t_pp=search_result&t_efo=search_pure_goods_card&t_ef=goods_search&t_sm=&t_spt=search_result', 'Processor: Intel Core i5-1240P (12 Cores, 16 Threads, TDP: 28W) | Code Name: Intel Alder Lake | Graphics: Intel Iris Xe G7 80EU (dual channel memory required) | LCD: 16\" 2.5K Resolution IPS Display (16:10) | Display / Resolution: WQXGA 2560×1600 | Memory: 2x SODIMM DDR4 up to 64GB dual channel, 3200MHz (8GB DDR4 Upgradeable, 1 slot free) | Storage: 256GB 2280 M.2 NVMe, Up to PCIe Gen 4 x4, Up to 2TB | OS Support: Windows 11 (64-bit) | Camera: 2.0MP with Digital Mic and Privacy Protection | Audio: HD Audio, Built-in Microphone, 2x Speakers | Ports: 1x USB 3.0 Type C (Display, Power, Data) | 2x USB 3.0 Type A | 1x USB 2.0 Type A | 1x 3.5mm Audio Combo Jack | 1x HDMI 1.4 | 1x DC-in Jack | 1x Micro SD (up to 128GB) | 1x RJ45 LAN (10/100/1000Mb) | Power: AC Adapter 100~240V, 19V 3.42A, 64.98W | Battery: 3-cell Smart Li-ion 53.58Wh, 4700mAh/11.4V | Connectivity: WiFi 802.11 ac/b/g/n | Bluetooth | Security: Kensington Lock, TPM 2.0 | BIOS: AMI | Dimensions: 362 x 242.8 x 23.3 mm | Weight: 1940g', '/Images/1751116775_Axioo MyBook Saga 12 (qr).png', '2025-06-28 20:19:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_tags`
--

CREATE TABLE `product_tags` (
  `id_product` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_tags`
--

INSERT INTO `product_tags` (`id_product`, `id_tag`) VALUES
(18, 2),
(19, 1),
(20, 7),
(21, 7),
(22, 7),
(23, 6),
(24, 5),
(25, 4),
(27, 3),
(28, 2),
(29, 2),
(49, 1),
(53, 1),
(56, 7),
(58, 6);

-- --------------------------------------------------------

--
-- Table structure for table `produk_tersedia`
--

CREATE TABLE `produk_tersedia` (
  `ID` int(11) DEFAULT NULL,
  `Nama` varchar(100) DEFAULT NULL,
  `Harga` decimal(10,2) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk_tersedia`
--

INSERT INTO `produk_tersedia` (`ID`, `Nama`, `Harga`, `Status`) VALUES
(56, 'Asus ROG FLOW Z13', 35999000.00, 'In Stock'),
(28, 'ASUS Zenbook DUO UX8406', 23999000.00, 'In Stock'),
(21, 'Asus TUF A14 FA401UU', 21999000.00, 'In Stock'),
(18, 'MSI Katana 15 B13VFK 1850ID', 20049000.00, 'In Stock'),
(20, 'Lenovo LOQ 15ARP9 J5ID', 14699000.00, 'In Stock'),
(29, 'Lenovo Ideapad Slim 5i', 11369000.00, 'In Stock'),
(49, 'ACER Aspire 7 Pro A715', 10489000.00, 'In Stock'),
(23, 'Acer Nitro V 15 ANV15-41-R99D', 10395000.00, 'In Stock'),
(25, 'MacBook Air 13 2020', 10329000.00, 'In Stock'),
(22, 'MSI Modern 14-C7M-280ID', 8899000.00, 'In Stock'),
(19, 'HP 14S DQ5152TU', 7099000.00, 'In Stock'),
(27, 'Acer Lite (AL1-14M) - Metal Cover', 6371000.00, 'In Stock'),
(24, 'Lenovo V14 G4 AMN V7ID', 5549000.00, 'In Stock'),
(58, 'Axioo MyBook Hype 5', 5299000.00, 'In Stock'),
(53, 'Advan WorkPro Lite', 4599000.00, 'In Stock');

-- --------------------------------------------------------

--
-- Table structure for table `profile_admin`
--

CREATE TABLE `profile_admin` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profile_admin`
--

INSERT INTO `profile_admin` (`id`, `admin_id`, `phone_number`, `address`) VALUES
(1, 1, '08123456789', 'sleman, DIY\r\n'),
(2, 4, '08234567891', 'bintuni, papua barat'),
(3, 5, '0845678923', 'flores, ntt'),
(4, 6, '08126789354', 'batam, sumatera'),
(5, 7, '08125673829', 'palembang');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id_tag` int(11) NOT NULL,
  `name_tag` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id_tag`, `name_tag`) VALUES
(1, 'Intel Core 5'),
(2, 'Intel core 7'),
(3, 'Intel core 3'),
(4, 'M1'),
(5, 'Ryzen 3'),
(6, 'Ryzen 5'),
(7, 'Ryzen 7');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `no_telefon` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `nama`, `password`, `no_telefon`, `email`, `created_at`) VALUES
(1, 'user1', 'rifky danu asmoro', '111111', '0812345678', 'danu@gmail.com', '2025-07-26'),
(2, 'user2', 'vianda retnaningtiyas purbandari karetji', '222222', '0823456789', 'vianda@gmail.com', '2025-07-26'),
(3, 'user3', 'farhan ardiansyah', '333333', '0834567357', 'farhan@gmail.com', '2025-07-26'),
(4, 'user4', 'stefanus arya bayu samudra bataona', '444444', '0856789012', 'arya@gmail.com', '2025-07-26'),
(5, 'user5', 'i made baskara saccid ananda', '555555', '0865789032', 'baskara@gmail.com', '2025-07-26'),
(6, 'user6', 'debi saputra', '666666', '08976543146', 'debi@gmail.com', '2025-07-26');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_all_laptop`
-- (See below for the actual view)
--
CREATE TABLE `vw_all_laptop` (
`id` int(11)
,`slug` varchar(100)
,`title` varchar(255)
,`specs` text
,`price` bigint(20)
,`old_price` bigint(20)
,`status` varchar(50)
,`image_1` varchar(255)
,`image_2` varchar(255)
,`image_3` varchar(255)
,`category` text
,`buy_link` text
,`description` text
,`qr_code` varchar(255)
,`created_at` datetime
,`id_category` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_best_seller_mahal`
-- (See below for the actual view)
--
CREATE TABLE `vw_best_seller_mahal` (
`id` int(11)
,`slug` varchar(100)
,`title` varchar(255)
,`specs` text
,`price` bigint(20)
,`old_price` bigint(20)
,`status` varchar(50)
,`image_1` varchar(255)
,`image_2` varchar(255)
,`image_3` varchar(255)
,`category` text
,`buy_link` text
,`description` text
,`qr_code` varchar(255)
,`created_at` datetime
,`id_category` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_laptop_midrange`
-- (See below for the actual view)
--
CREATE TABLE `vw_laptop_midrange` (
`id` int(11)
,`slug` varchar(100)
,`title` varchar(255)
,`specs` text
,`price` bigint(20)
,`old_price` bigint(20)
,`status` varchar(50)
,`image_1` varchar(255)
,`image_2` varchar(255)
,`image_3` varchar(255)
,`category` text
,`buy_link` text
,`description` text
,`qr_code` varchar(255)
,`created_at` datetime
,`id_category` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_on_sale_simple`
-- (See below for the actual view)
--
CREATE TABLE `vw_on_sale_simple` (
`title` varchar(255)
,`price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_all_laptop`
--
DROP TABLE IF EXISTS `vw_all_laptop`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_all_laptop`  AS SELECT `best_seller`.`id` AS `id`, `best_seller`.`slug` AS `slug`, `best_seller`.`title` AS `title`, `best_seller`.`specs` AS `specs`, `best_seller`.`price` AS `price`, `best_seller`.`old_price` AS `old_price`, `best_seller`.`status` AS `status`, `best_seller`.`image_1` AS `image_1`, `best_seller`.`image_2` AS `image_2`, `best_seller`.`image_3` AS `image_3`, `best_seller`.`category` AS `category`, `best_seller`.`buy_link` AS `buy_link`, `best_seller`.`description` AS `description`, `best_seller`.`qr_code` AS `qr_code`, `best_seller`.`created_at` AS `created_at`, `best_seller`.`id_category` AS `id_category` FROM `best_seller` WHERE `best_seller`.`price` between 3000000 and 10000000 ;

-- --------------------------------------------------------

--
-- Structure for view `vw_best_seller_mahal`
--
DROP TABLE IF EXISTS `vw_best_seller_mahal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_best_seller_mahal`  AS SELECT `best_seller`.`id` AS `id`, `best_seller`.`slug` AS `slug`, `best_seller`.`title` AS `title`, `best_seller`.`specs` AS `specs`, `best_seller`.`price` AS `price`, `best_seller`.`old_price` AS `old_price`, `best_seller`.`status` AS `status`, `best_seller`.`image_1` AS `image_1`, `best_seller`.`image_2` AS `image_2`, `best_seller`.`image_3` AS `image_3`, `best_seller`.`category` AS `category`, `best_seller`.`buy_link` AS `buy_link`, `best_seller`.`description` AS `description`, `best_seller`.`qr_code` AS `qr_code`, `best_seller`.`created_at` AS `created_at`, `best_seller`.`id_category` AS `id_category` FROM `best_seller` WHERE `best_seller`.`price` > 5000000 ;

-- --------------------------------------------------------

--
-- Structure for view `vw_laptop_midrange`
--
DROP TABLE IF EXISTS `vw_laptop_midrange`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_laptop_midrange`  AS SELECT `vw_all_laptop`.`id` AS `id`, `vw_all_laptop`.`slug` AS `slug`, `vw_all_laptop`.`title` AS `title`, `vw_all_laptop`.`specs` AS `specs`, `vw_all_laptop`.`price` AS `price`, `vw_all_laptop`.`old_price` AS `old_price`, `vw_all_laptop`.`status` AS `status`, `vw_all_laptop`.`image_1` AS `image_1`, `vw_all_laptop`.`image_2` AS `image_2`, `vw_all_laptop`.`image_3` AS `image_3`, `vw_all_laptop`.`category` AS `category`, `vw_all_laptop`.`buy_link` AS `buy_link`, `vw_all_laptop`.`description` AS `description`, `vw_all_laptop`.`qr_code` AS `qr_code`, `vw_all_laptop`.`created_at` AS `created_at`, `vw_all_laptop`.`id_category` AS `id_category` FROM `vw_all_laptop` WHERE `vw_all_laptop`.`price` <= 7000000WITH CASCADEDCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vw_on_sale_simple`
--
DROP TABLE IF EXISTS `vw_on_sale_simple`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_on_sale_simple`  AS SELECT `on_sale`.`title` AS `title`, `on_sale`.`price` AS `price` FROM `on_sale` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `best_seller`
--
ALTER TABLE `best_seller`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `fk_category` (`id_category`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id_category`);

--
-- Indexes for table `log_aktivitas_produk`
--
ALTER TABLE `log_aktivitas_produk`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `on_sale`
--
ALTER TABLE `on_sale`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `wk_category` (`id_category`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD KEY `idx_name_gender` (`first_name`,`gender`),
  ADD KEY `idx_name_address` (`first_name`,`email`),
  ADD KEY `idx_lastname_gender` (`last_name`,`gender`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `ak_category` (`id_category`);

--
-- Indexes for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD PRIMARY KEY (`id_product`,`id_tag`),
  ADD KEY `id_tag` (`id_tag`);

--
-- Indexes for table `profile_admin`
--
ALTER TABLE `profile_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_id` (`admin_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id_tag`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `best_seller`
--
ALTER TABLE `best_seller`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT for table `log_aktivitas_produk`
--
ALTER TABLE `log_aktivitas_produk`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `on_sale`
--
ALTER TABLE `on_sale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id_tag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `best_seller`
--
ALTER TABLE `best_seller`
  ADD CONSTRAINT `fk_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`);

--
-- Constraints for table `on_sale`
--
ALTER TABLE `on_sale`
  ADD CONSTRAINT `wk_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `ak_category` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`);

--
-- Constraints for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD CONSTRAINT `product_tags_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `best_seller` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_tags_ibfk_2` FOREIGN KEY (`id_tag`) REFERENCES `tags` (`id_tag`) ON DELETE CASCADE;

--
-- Constraints for table `profile_admin`
--
ALTER TABLE `profile_admin`
  ADD CONSTRAINT `fk_admin` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- =============================================
-- EVOTIX.ID - Database Schema
-- Jalankan di phpMyAdmin XAMPP
-- =============================================

CREATE DATABASE IF NOT EXISTS evotix_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE evotix_db;

-- Tabel Users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    no_hp VARCHAR(20),
    role ENUM('user','admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Films
CREATE TABLE films (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    genre VARCHAR(100),
    durasi INT COMMENT 'dalam menit',
    rating VARCHAR(10),
    sinopsis TEXT,
    poster VARCHAR(255),
    status ENUM('tayang','akan_datang','selesai') DEFAULT 'tayang',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Schedules (Jadwal Tayang)
CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    studio VARCHAR(50),
    tanggal DATE NOT NULL,
    jam TIME NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES films(id) ON DELETE CASCADE
);

-- Tabel Seats (Kursi)
CREATE TABLE seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    nomor_kursi VARCHAR(10) NOT NULL,
    status ENUM('available','locked','booked') DEFAULT 'available',
    locked_until TIMESTAMP NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE CASCADE
);

-- Tabel Bookings (Pemesanan)
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    schedule_id INT NOT NULL,
    kode_booking VARCHAR(20) UNIQUE NOT NULL,
    total_harga DECIMAL(10,2) NOT NULL,
    status ENUM('pending','paid','cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

-- Tabel Booking Detail (kursi yang dipesan)
CREATE TABLE booking_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES seats(id)
);

-- Tabel Transactions
CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    metode_bayar ENUM('transfer','qris','ewallet') NOT NULL,
    status ENUM('pending','paid','failed') DEFAULT 'pending',
    bukti_bayar VARCHAR(255),
    paid_at TIMESTAMP NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- =============================================
-- DATA DUMMY
-- =============================================

-- Admin & User dummy
INSERT INTO users (nama, email, password, role) VALUES
('Admin EVOTIX', 'admin@evotix.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Budi Santoso', 'budi@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user');
-- password: password

-- Film dummy
INSERT INTO films (judul, genre, durasi, rating, sinopsis, poster, status) VALUES
('Garuda Sakti', 'Action, Drama', 120, 'R13+', 'Kisah seorang pejuang muda yang berjuang mempertahankan tanah airnya dari ancaman musuh yang datang dari dalam negeri sendiri.', 'garuda.jpg', 'tayang'),
('Cinta di Ujung Galaksi', 'Romance, Sci-Fi', 105, 'SU', 'Dua jiwa yang terpisah oleh dimensi waktu bertemu dalam sebuah misi luar angkasa yang mengubah segalanya.', 'cinta.jpg', 'tayang'),
('Hantu Kamar 13', 'Horror', 98, 'D17+', 'Sebuah hotel tua menyimpan misteri gelap di kamar 13. Siapa yang berani masuk, tidak pernah kembali.', 'hantu.jpg', 'tayang'),
('Petualangan Si Kancil', 'Animasi, Family', 85, 'SU', 'Si Kancil yang cerdik kembali hadir dalam petualangan seru bersama teman-teman barunya di hutan ajaib.', 'kancil.jpg', 'tayang'),
('Langit Merah Jakarta', 'Thriller, Action', 135, 'D17+', 'Detektif Arya harus memecahkan kasus pembunuhan berantai yang mengguncang ibu kota.', 'langit.jpg', 'akan_datang');

-- Jadwal dummy
INSERT INTO schedules (film_id, studio, tanggal, jam, harga) VALUES
(1, 'Studio 1', CURDATE(), '10:00:00', 50000),
(1, 'Studio 1', CURDATE(), '13:00:00', 50000),
(1, 'Studio 2', CURDATE(), '16:00:00', 75000),
(2, 'Studio 2', CURDATE(), '11:00:00', 50000),
(2, 'Studio 3', CURDATE(), '14:30:00', 75000),
(3, 'Studio 1', CURDATE(), '19:00:00', 75000),
(3, 'Studio 2', CURDATE(), '21:00:00', 75000),
(4, 'Studio 3', CURDATE(), '09:00:00', 45000),
(4, 'Studio 3', CURDATE(), '11:30:00', 45000);

-- Generate kursi untuk schedule 1 (Studio 1, 5 baris x 8 kursi)
INSERT INTO seats (schedule_id, nomor_kursi, status) VALUES
(1,'A1','available'),(1,'A2','available'),(1,'A3','booked'),(1,'A4','booked'),
(1,'A5','available'),(1,'A6','available'),(1,'A7','available'),(1,'A8','available'),
(1,'B1','available'),(1,'B2','booked'),(1,'B3','booked'),(1,'B4','booked'),
(1,'B5','available'),(1,'B6','available'),(1,'B7','booked'),(1,'B8','available'),
(1,'C1','available'),(1,'C2','available'),(1,'C3','available'),(1,'C4','available'),
(1,'C5','available'),(1,'C6','available'),(1,'C7','available'),(1,'C8','available'),
(1,'D1','available'),(1,'D2','available'),(1,'D3','available'),(1,'D4','available'),
(1,'D5','available'),(1,'D6','booked'),(1,'D7','available'),(1,'D8','available'),
(1,'E1','available'),(1,'E2','available'),(1,'E3','available'),(1,'E4','available'),
(1,'E5','available'),(1,'E6','available'),(1,'E7','available'),(1,'E8','available');

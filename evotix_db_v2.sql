-- =============================================
-- EVOTIX.ID v2 — Database Update
-- Jalankan di phpMyAdmin (tab SQL)
-- =============================================

USE evotix_db;

-- =============================================
-- TABEL BARU: Wilayah Bioskop
-- =============================================
CREATE TABLE IF NOT EXISTS wilayah (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kota VARCHAR(100) NOT NULL,
    nama_bioskop VARCHAR(150) NOT NULL,
    alamat TEXT,
    maps_url VARCHAR(500),
    telepon VARCHAR(30)
);

-- =============================================
-- TABEL BARU: Menu Makanan
-- =============================================
CREATE TABLE IF NOT EXISTS menu_makanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    kategori ENUM('makanan','minuman','combo','snack') DEFAULT 'makanan',
    harga DECIMAL(10,2) NOT NULL,
    deskripsi TEXT,
    tersedia TINYINT(1) DEFAULT 1
);

-- =============================================
-- TABEL BARU: Order Makanan (link ke booking)
-- =============================================
CREATE TABLE IF NOT EXISTS order_makanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    menu_id INT NOT NULL,
    jumlah INT NOT NULL DEFAULT 1,
    subtotal DECIMAL(10,2) NOT NULL,
    catatan TEXT,
    FOREIGN KEY (menu_id) REFERENCES menu_makanan(id)
);

-- =============================================
-- DATA: Wilayah Bioskop
-- =============================================
INSERT INTO wilayah (nama_kota, nama_bioskop, alamat, maps_url, telepon) VALUES
('Surabaya', 'EVOTIX Surabaya Grand City', 'Grand City Mall Lt.5, Jl. Gubeng Pojok No.1, Surabaya', 'https://maps.google.com/?q=Grand+City+Mall+Surabaya', '(031) 555-0101'),
('Surabaya', 'EVOTIX Surabaya Galaxy Mall', 'Galaxy Mall Lt.3, Jl. Dharmahusada Indah Tim., Surabaya', 'https://maps.google.com/?q=Galaxy+Mall+Surabaya', '(031) 555-0102'),
('Jakarta', 'EVOTIX Jakarta Grand Indonesia', 'Grand Indonesia Shopping Town, Jl. MH Thamrin No.1, Jakarta', 'https://maps.google.com/?q=Grand+Indonesia+Jakarta', '(021) 555-0201'),
('Jakarta', 'EVOTIX Jakarta Senayan City', 'Senayan City Lt.4, Jl. Asia Afrika Lot.19, Jakarta', 'https://maps.google.com/?q=Senayan+City+Jakarta', '(021) 555-0202'),
('Bandung', 'EVOTIX Bandung Paris Van Java', 'Paris Van Java Mall, Jl. Sukajadi No.137-139, Bandung', 'https://maps.google.com/?q=Paris+Van+Java+Bandung', '(022) 555-0301'),
('Yogyakarta', 'EVOTIX Yogyakarta Ambarrukmo', 'Ambarrukmo Plaza Lt.4, Jl. Laksda Adisucipto No.180, Yogyakarta', 'https://maps.google.com/?q=Ambarrukmo+Plaza+Yogyakarta', '(0274) 555-401'),
('Malang', 'EVOTIX Malang Matos', 'Malang Town Square Lt.3, Jl. Veteran No.2, Malang', 'https://maps.google.com/?q=Malang+Town+Square', '(0341) 555-501'),
('Bali', 'EVOTIX Bali Discovery', 'Bali Discovery Shopping Mall, Jl. Kartika Plaza, Kuta, Bali', 'https://maps.google.com/?q=Bali+Discovery+Mall+Kuta', '(0361) 555-601');

-- =============================================
-- DATA: Menu Makanan
-- =============================================
INSERT INTO menu_makanan (nama, kategori, harga, deskripsi) VALUES
-- Makanan
('Popcorn Caramel Large', 'snack', 45000, 'Popcorn manis karamel ukuran jumbo, renyah dan gurih'),
('Popcorn Asin Large', 'snack', 40000, 'Popcorn asin klasik ukuran jumbo dengan butter melimpah'),
('Popcorn Mix (Caramel+Asin)', 'snack', 50000, 'Kombinasi popcorn caramel dan asin dalam satu bucket besar'),
('Hotdog Spesial', 'makanan', 55000, 'Hotdog jumbo dengan saus BBQ, mustard, dan bawang crispy'),
('Nachos + Cheese Sauce', 'makanan', 48000, 'Nachos renyah dengan saus keju cheddar panas, + jalapeño'),
('Pizza Slice (2 pcs)', 'makanan', 52000, 'Dua potong pizza mozarella dengan topping pilihan'),
('Chicken Nugget (8 pcs)', 'makanan', 45000, '8 nugget ayam crispy dengan saus tomat & mayonaise'),
('Burger Cinema', 'makanan', 65000, 'Burger double beef patty dengan keju, selada, dan saus spesial'),
-- Minuman
('Pepsi Large', 'minuman', 30000, 'Pepsi cola dingin ukuran besar dengan es penuh'),
('7UP / Mirinda Large', 'minuman', 30000, 'Pilihan 7UP atau Mirinda, segar dan dingin'),
('Air Mineral', 'minuman', 15000, 'Aqua botol 600ml, hidrasi sepanjang film'),
('Teh Manis Dingin', 'minuman', 20000, 'Teh manis dingin segar, minuman favorit bioskop'),
-- Combo
('COMBO COUPLE', 'combo', 110000, '2x Popcorn Large + 2x Pepsi Large — hemat Rp 20.000'),
('COMBO FAMILY', 'combo', 185000, '3x Popcorn Mix + 4x Minuman pilihan — hemat Rp 35.000'),
('COMBO SOLO', 'combo', 75000, '1x Popcorn Large + 1x Pepsi + 1x Nachos — hemat Rp 15.000');

-- =============================================
-- HAPUS FILM LAMA & TAMBAH 10 FILM BARU
-- =============================================
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM booking_details;
DELETE FROM bookings;
DELETE FROM transactions;
DELETE FROM seats;
DELETE FROM schedules;
DELETE FROM films;
SET FOREIGN_KEY_CHECKS=1;

INSERT INTO films (judul, genre, durasi, rating, sinopsis, status) VALUES
('Garuda Sakti', 'Action, Drama', 127, 'R13+', 'Seorang prajurit muda bernama Arya mewarisi kekuatan mistis leluhurnya dan harus berjuang melawan konspirasi besar yang mengancam keutuhan bangsa dari dalam.', 'tayang'),
('Cinta di Ujung Galaksi', 'Romance, Sci-Fi', 108, 'SU', 'Dua jiwa yang terpisah dimensi waktu bertemu dalam misi luar angkasa. Di antara bintang-bintang, mereka menemukan bahwa cinta melampaui ruang dan waktu.', 'tayang'),
('Hantu Kamar 13', 'Horror, Mystery', 95, 'D17+', 'Hotel tua menyimpan teror di kamar 13. Setiap tamu yang menginap tidak pernah kembali — sampai seorang detektif pemberani memutuskan untuk mengungkap kebenarannya.', 'tayang'),
('Petualangan Si Kancil 2', 'Animasi, Family', 88, 'SU', 'Si Kancil yang cerdik kembali dalam petualangan epik melintasi hutan ajaib bersama teman-teman barunya untuk menyelamatkan kerajaan binatang dari ancaman gelap.', 'tayang'),
('Langit Merah Jakarta', 'Thriller, Action', 138, 'D17+', 'Detektif Arya menemukan pola tersembunyi di balik serangkaian pembunuhan elite Jakarta. Semakin dalam ia menyelidiki, semakin berbahaya hidupnya.', 'tayang'),
('Senyum Terakhir Maya', 'Drama, Romance', 112, 'R13+', 'Maya, pianis berbakat yang didiagnosis penyakit langka, memilih menghabiskan sisa waktunya berkeliling Indonesia — dan jatuh cinta di tempat yang tidak ia duga.', 'tayang'),
('Bajak Laut Nusantara', 'Adventure, Action', 142, 'R13+', 'Di abad ke-17, kapten bajak laut legendaris Raden Harimau memimpin armadanya melawan penjajah kolonial yang merampas laut Nusantara dengan api dan pedang.', 'tayang'),
('Anomali', 'Sci-Fi, Thriller', 118, 'D17+', 'Seorang ilmuwan membangun mesin waktu dan secara tidak sengaja membuka portal ke dimensi paralel. Kini ia harus memilih: selamatkan keluarganya atau selamatkan dunia.', 'tayang'),
('Juragan Muda', 'Comedy, Drama', 100, 'R13+', 'Seorang pemuda desa nekat merantau ke Jakarta dengan modal Rp 50.000 dan mimpi besar. Kisah jatuh bangun yang penuh tawa, haru, dan inspirasi.', 'tayang'),
('Pasar Malam Terlarang', 'Horror, Fantasy', 105, 'D17+', 'Setiap malam tertentu, sebuah pasar malam misterius muncul di tengah kota. Mereka yang masuk tidak pernah sama lagi — jika berhasil keluar.', 'akan_datang');

-- =============================================
-- JADWAL untuk semua film tayang
-- =============================================
INSERT INTO schedules (film_id, studio, tanggal, jam, harga) VALUES
(1,'Studio 1',CURDATE(),'10:00:00',55000),
(1,'Studio 2',CURDATE(),'13:30:00',55000),
(1,'Studio IMAX',CURDATE(),'19:00:00',90000),
(2,'Studio 1',CURDATE(),'11:00:00',50000),
(2,'Studio 3',CURDATE(),'14:00:00',75000),
(3,'Studio 2',CURDATE(),'20:00:00',75000),
(3,'Studio 3',CURDATE(),'22:30:00',75000),
(4,'Studio 1',CURDATE(),'09:00:00',45000),
(4,'Studio 3',CURDATE(),'11:30:00',45000),
(5,'Studio IMAX',CURDATE(),'15:00:00',90000),
(5,'Studio 2',CURDATE(),'18:00:00',75000),
(6,'Studio 1',CURDATE(),'13:00:00',50000),
(7,'Studio IMAX',CURDATE(),'16:30:00',90000),
(8,'Studio 2',CURDATE(),'21:00:00',75000),
(9,'Studio 3',CURDATE(),'12:00:00',50000),
(9,'Studio 1',CURDATE(),'16:00:00',50000);

-- =============================================
-- KURSI: 30 kursi per jadwal (baris A-E, 6 kursi)
-- Fungsi: generate kursi untuk semua schedules
-- =============================================
DROP PROCEDURE IF EXISTS generate_seats;
DELIMITER $$
CREATE PROCEDURE generate_seats()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE sid INT;
    DECLARE baris CHAR(1);
    DECLARE nomor INT;
    DECLARE rows_array VARCHAR(12) DEFAULT 'ABCDE';
    
    -- Loop tiap schedule
    SELECT MIN(id) INTO sid FROM schedules;
    
    WHILE sid IS NOT NULL DO
        SET i = 1;
        WHILE i <= 5 DO -- 5 baris
            SET baris = SUBSTRING(rows_array, i, 1);
            SET nomor = 1;
            WHILE nomor <= 6 DO -- 6 kursi per baris = 30 total
                -- Random beberapa kursi jadi 'booked' untuk realisme
                IF (i = 1 AND nomor IN (2,4)) OR (i = 2 AND nomor IN (1,3,5)) THEN
                    INSERT INTO seats (schedule_id, nomor_kursi, status) VALUES (sid, CONCAT(baris, nomor), 'booked');
                ELSE
                    INSERT INTO seats (schedule_id, nomor_kursi, status) VALUES (sid, CONCAT(baris, nomor), 'available');
                END IF;
                SET nomor = nomor + 1;
            END WHILE;
            SET i = i + 1;
        END WHILE;
        
        -- Next schedule id
        SELECT MIN(id) INTO sid FROM schedules WHERE id > sid;
    END WHILE;
END$$
DELIMITER ;

CALL generate_seats();
DROP PROCEDURE IF EXISTS generate_seats;

-- =============================================
-- DATA USER DEMO
-- =============================================
INSERT IGNORE INTO users (nama, email, password, role) VALUES
('Admin EVOTIX', 'admin@evotix.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Budi Santoso', 'budi@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user');

SELECT 'Database v2 berhasil diimport!' as Status;
SELECT COUNT(*) as total_film FROM films;
SELECT COUNT(*) as total_kursi FROM seats;
SELECT COUNT(*) as total_menu FROM menu_makanan;
SELECT COUNT(*) as total_wilayah FROM wilayah;

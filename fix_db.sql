SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS order_makanan;
DROP TABLE IF EXISTS menu_makanan;
DROP TABLE IF EXISTS wilayah;
DROP TABLE IF EXISTS booking_details;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS schedules;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    no_hp VARCHAR(20),
    role ENUM('user','admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE films (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    genre VARCHAR(100),
    durasi INT,
    rating VARCHAR(10),
    sinopsis TEXT,
    poster VARCHAR(255),
    status ENUM('tayang','akan_datang','selesai') DEFAULT 'tayang',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    studio VARCHAR(50),
    tanggal DATE NOT NULL,
    jam TIME NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    nomor_kursi VARCHAR(10) NOT NULL,
    status ENUM('available','locked','booked') DEFAULT 'available',
    locked_until TIMESTAMP NULL,
    FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE CASCADE
);

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

CREATE TABLE booking_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES seats(id)
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    metode_bayar ENUM('transfer','qris','ewallet') NOT NULL,
    status ENUM('pending','paid','failed') DEFAULT 'pending',
    bukti_bayar VARCHAR(255),
    paid_at TIMESTAMP NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

CREATE TABLE wilayah (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kota VARCHAR(100) NOT NULL,
    nama_bioskop VARCHAR(150) NOT NULL,
    alamat TEXT,
    maps_url VARCHAR(500),
    telepon VARCHAR(30)
);

CREATE TABLE menu_makanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    kategori ENUM('makanan','minuman','combo','snack') DEFAULT 'makanan',
    harga DECIMAL(10,2) NOT NULL,
    deskripsi TEXT,
    tersedia TINYINT(1) DEFAULT 1
);

CREATE TABLE order_makanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    menu_id INT NOT NULL,
    jumlah INT NOT NULL DEFAULT 1,
    subtotal DECIMAL(10,2) NOT NULL,
    catatan TEXT,
    FOREIGN KEY (menu_id) REFERENCES menu_makanan(id)
);

INSERT INTO users (nama, email, password, role) VALUES
('Admin EVOTIX', 'admin@evotix.id', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Budi Santoso', 'budi@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user');

INSERT INTO films (judul, genre, durasi, rating, sinopsis, status) VALUES
('Garuda Sakti', 'Action, Drama', 127, 'R13+', 'Seorang prajurit muda mewarisi kekuatan mistis leluhurnya dan berjuang melawan konspirasi besar yang mengancam keutuhan bangsa dari dalam.', 'tayang'),
('Cinta di Ujung Galaksi', 'Romance, Sci-Fi', 108, 'SU', 'Dua jiwa terpisah dimensi waktu bertemu dalam misi luar angkasa. Di antara bintang-bintang, mereka temukan cinta melampaui ruang dan waktu.', 'tayang'),
('Hantu Kamar 13', 'Horror, Mystery', 95, 'D17+', 'Hotel tua menyimpan teror di kamar 13. Setiap tamu tidak pernah kembali sampai seorang detektif memutuskan mengungkap kebenarannya.', 'tayang'),
('Petualangan Si Kancil 2', 'Animasi, Family', 88, 'SU', 'Si Kancil kembali dalam petualangan epik melintasi hutan ajaib untuk menyelamatkan kerajaan binatang dari ancaman gelap.', 'tayang'),
('Langit Merah Jakarta', 'Thriller, Action', 138, 'D17+', 'Detektif Arya menemukan pola tersembunyi di balik pembunuhan elite Jakarta. Semakin dalam menyelidiki, semakin berbahaya hidupnya.', 'tayang'),
('Senyum Terakhir Maya', 'Drama, Romance', 112, 'R13+', 'Maya, pianis berbakat yang didiagnosis penyakit langka, memilih menghabiskan sisa waktunya berkeliling Indonesia dan jatuh cinta.', 'tayang'),
('Bajak Laut Nusantara', 'Adventure, Action', 142, 'R13+', 'Di abad ke-17, kapten bajak laut legendaris Raden Harimau memimpin armadanya melawan penjajah kolonial yang merampas laut Nusantara.', 'tayang'),
('Anomali', 'Sci-Fi, Thriller', 118, 'D17+', 'Seorang ilmuwan membuka portal ke dimensi paralel. Ia harus memilih: selamatkan keluarganya atau selamatkan dunia.', 'tayang'),
('Juragan Muda', 'Comedy, Drama', 100, 'R13+', 'Pemuda desa nekat merantau ke Jakarta dengan modal Rp 50.000 dan mimpi besar. Kisah jatuh bangun penuh tawa dan inspirasi.', 'tayang'),
('Pasar Malam Terlarang', 'Horror, Fantasy', 105, 'D17+', 'Setiap malam tertentu, pasar malam misterius muncul di tengah kota. Mereka yang masuk tidak pernah sama lagi.', 'akan_datang');

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

INSERT INTO seats (schedule_id, nomor_kursi, status)
SELECT s.id, CONCAT(r.baris, k.nomor),
  CASE WHEN (r.baris='A' AND k.nomor IN (2,4)) OR (r.baris='B' AND k.nomor IN (1,3,5)) THEN 'booked' ELSE 'available' END
FROM schedules s
JOIN (SELECT 'A' baris UNION SELECT 'B' UNION SELECT 'C' UNION SELECT 'D' UNION SELECT 'E') r
JOIN (SELECT 1 nomor UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) k;

INSERT INTO wilayah (nama_kota, nama_bioskop, alamat, maps_url, telepon) VALUES
('Surabaya','EVOTIX Surabaya Grand City','Grand City Mall Lt.5, Jl. Gubeng Pojok No.1, Surabaya','https://maps.google.com/?q=Grand+City+Mall+Surabaya','(031) 555-0101'),
('Surabaya','EVOTIX Surabaya Galaxy Mall','Galaxy Mall Lt.3, Jl. Dharmahusada Indah Tim., Surabaya','https://maps.google.com/?q=Galaxy+Mall+Surabaya','(031) 555-0102'),
('Jakarta','EVOTIX Jakarta Grand Indonesia','Grand Indonesia Shopping Town, Jl. MH Thamrin No.1, Jakarta','https://maps.google.com/?q=Grand+Indonesia+Jakarta','(021) 555-0201'),
('Jakarta','EVOTIX Jakarta Senayan City','Senayan City Lt.4, Jl. Asia Afrika Lot.19, Jakarta','https://maps.google.com/?q=Senayan+City+Jakarta','(021) 555-0202'),
('Bandung','EVOTIX Bandung Paris Van Java','Paris Van Java Mall, Jl. Sukajadi No.137-139, Bandung','https://maps.google.com/?q=Paris+Van+Java+Bandung','(022) 555-0301'),
('Yogyakarta','EVOTIX Yogyakarta Ambarrukmo','Ambarrukmo Plaza Lt.4, Jl. Laksda Adisucipto No.180, Yogyakarta','https://maps.google.com/?q=Ambarrukmo+Plaza+Yogyakarta','(0274) 555-401'),
('Malang','EVOTIX Malang Matos','Malang Town Square Lt.3, Jl. Veteran No.2, Malang','https://maps.google.com/?q=Malang+Town+Square','(0341) 555-501'),
('Bali','EVOTIX Bali Discovery','Bali Discovery Shopping Mall, Jl. Kartika Plaza, Kuta, Bali','https://maps.google.com/?q=Bali+Discovery+Mall+Kuta','(0361) 555-601');

INSERT INTO menu_makanan (nama, kategori, harga, deskripsi) VALUES
('Popcorn Caramel Large','snack',45000,'Popcorn manis karamel ukuran jumbo, renyah dan gurih'),
('Popcorn Asin Large','snack',40000,'Popcorn asin klasik ukuran jumbo dengan butter melimpah'),
('Popcorn Mix (Caramel+Asin)','snack',50000,'Kombinasi popcorn caramel dan asin dalam satu bucket besar'),
('Hotdog Spesial','makanan',55000,'Hotdog jumbo dengan saus BBQ, mustard, dan bawang crispy'),
('Nachos + Cheese Sauce','makanan',48000,'Nachos renyah dengan saus keju cheddar panas dan jalapeño'),
('Pizza Slice (2 pcs)','makanan',52000,'Dua potong pizza mozarella dengan topping pilihan'),
('Chicken Nugget (8 pcs)','makanan',45000,'8 nugget ayam crispy dengan saus tomat dan mayonaise'),
('Burger Cinema','makanan',65000,'Burger double beef patty dengan keju, selada, dan saus spesial'),
('Pepsi Large','minuman',30000,'Pepsi cola dingin ukuran besar dengan es penuh'),
('7UP / Mirinda Large','minuman',30000,'Pilihan 7UP atau Mirinda, segar dan dingin'),
('Air Mineral','minuman',15000,'Aqua botol 600ml'),
('Teh Manis Dingin','minuman',20000,'Teh manis dingin segar'),
('COMBO COUPLE','combo',110000,'2x Popcorn Large + 2x Pepsi Large — hemat Rp 20.000'),
('COMBO FAMILY','combo',185000,'3x Popcorn Mix + 4x Minuman pilihan — hemat Rp 35.000'),
('COMBO SOLO','combo',75000,'1x Popcorn Large + 1x Pepsi + 1x Nachos — hemat Rp 15.000');

SELECT 'BERHASIL! Database v2 siap.' as Status;
SELECT COUNT(*) as total_film FROM films;
SELECT COUNT(*) as total_kursi FROM seats;
SELECT COUNT(*) as total_menu FROM menu_makanan;
SELECT COUNT(*) as total_wilayah FROM wilayah;

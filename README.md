# EVOTIX.ID — Panduan Setup XAMPP

## 📁 Struktur Folder
```
evotix/
├── index.php              ← Halaman Beranda
├── includes/
│   ├── config.php         ← Koneksi DB + fungsi helper
│   ├── header.php         ← Navbar (include di semua halaman)
│   └── footer.php         ← Footer
├── css/
│   └── style.css          ← Semua styling (palette On Fire)
├── js/
│   └── main.js            ← JavaScript (seat picker, dll)
├── pages/
│   ├── login.php          ← Halaman login
│   ├── register.php       ← Halaman daftar akun
│   ├── logout.php         ← Proses logout
│   ├── detail.php         ← Detail film & pilih jadwal
│   ├── kursi.php          ← Pilih kursi interaktif
│   ├── booking.php        ← Ringkasan & pembayaran
│   ├── proses_bayar.php   ← Konfirmasi + e-ticket
│   ├── riwayat.php        ← Riwayat tiket user
│   └── admin/
│       ├── dashboard.php  ← Dashboard admin
│       └── films.php      ← CRUD film (tambah/edit/hapus)
└── evotix_db.sql          ← Script database (import ke phpMyAdmin)
```

## 🚀 Cara Install

### 1. Pindahkan ke htdocs
Salin folder `evotix/` ke:
```
C:\xampp\htdocs\evotix\
```

### 2. Start XAMPP
- Buka XAMPP Control Panel
- Start **Apache** dan **MySQL**

### 3. Buat Database
- Buka browser → http://localhost/phpmyadmin
- Klik **"New"** di sidebar kiri
- Buat database: `evotix_db`
- Klik tab **SQL** → paste isi file `evotix_db.sql` → klik **Go**

### 4. Cek Konfigurasi
Edit file `includes/config.php`:
```php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');    // default XAMPP
define('DB_PASS', '');        // default: kosong
define('DB_NAME', 'evotix_db');
define('SITE_URL', 'http://localhost/evotix');
```

### 5. Akses Website
Buka browser → **http://localhost/evotix**

---

## 👤 Akun Demo
| Role  | Email             | Password  |
|-------|-------------------|-----------|
| Admin | admin@evotix.id   | password  |
| User  | budi@gmail.com    | password  |

---

## 🎯 Fitur yang Diimplementasikan

### Pengguna (User)
- ✅ Register / Login / Logout
- ✅ Beranda — daftar film tayang
- ✅ Detail film — info + pilih jadwal
- ✅ Pilih kursi — interaktif, real-time lock 10 menit
- ✅ Pembayaran — pilih metode, countdown timer
- ✅ E-Ticket — kode booking + QR code
- ✅ Riwayat tiket

### Admin
- ✅ Dashboard — statistik penjualan
- ✅ CRUD Film — tambah, edit, hapus
- ✅ Lihat pesanan terbaru

## 🗄️ Operasi CRUD
| Halaman     | Operasi  | SQL Query                                          |
|-------------|----------|----------------------------------------------------|
| Register    | CREATE   | INSERT INTO users                                  |
| Login       | READ     | SELECT FROM users WHERE email=?                    |
| Pilih Kursi | READ     | SELECT FROM seats WHERE status='available'         |
| Klik Kursi  | UPDATE   | UPDATE seats SET status='locked'                   |
| Bayar       | CREATE   | INSERT INTO bookings & transactions                |
| Bayar Sukses| UPDATE   | UPDATE bookings SET status='paid'                  |
| Admin Delete| DELETE   | DELETE FROM films WHERE id=?                       |

## 🎨 Warna Palette "On Fire"
- `#FFFB97` — Kuning api (aksen terang)
- `#FE7F42` — Oranye api (warna utama)
- `#B32C1A` — Merah bara (tombol, badge)
- `#7A4B47` — Mauve (elemen sekunder)
- `#2A1617` — Hitam gelap (background)

# 🎬 EVOTIX.ID — Marketplace Tiket Bioskop Online

> Proyek Pemrograman Web | Website dinamis menggunakan PHP, MySQL, dan XAMPP

---

## 👥 Tim Pengembang

| Anggota | Role | Tanggung Jawab |
|---------|------|----------------|
| **Anggota 1** | Project Lead + Backend | Setup XAMPP, database, login/register, integrasi Midtrans |
| **Anggota 2** | Frontend | Desain UI, halaman film, kursi, e-ticket |
| **Anggota 3** | Frontend | Halaman makanan, wilayah, beranda |
| **Anggota 4** | Backend | Admin panel, CRUD film, jadwal |

---

## 🚀 Cara Menjalankan Proyek

### Persyaratan
- XAMPP (Apache + MySQL)
- Browser modern (Chrome / Edge / Firefox)

### Langkah Install

**1. Clone / Download proyek**
```bash
git clone https://github.com/username/evotix-id.git
# atau download ZIP dari GitHub
```

**2. Pindahkan ke htdocs**
```
C:\xampp\htdocs\evotix\
```

**3. Import database**
- Buka phpMyAdmin → `http://localhost/phpmyadmin`
- Buat database baru: `evotix_db`
- Import file: `evotix_db.sql`

**4. Konfigurasi (opsional)**

Edit `includes/config.php` jika diperlukan:
```php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'evotix_db');
define('SITE_URL', 'http://localhost/evotix');
```

**5. Jalankan**
```
http://localhost/evotix
```

---

## 🗂️ Struktur Folder

```
evotix/
├── index.php                  ← Beranda
├── includes/
│   ├── config.php             ← Koneksi DB + helper functions
│   ├── header.php             ← Navbar
│   └── footer.php             ← Footer
├── css/
│   └── style.css              ← Semua styling
├── js/
│   └── main.js                ← JavaScript interaktif
├── pages/
│   ├── login.php              ← Autentikasi login
│   ├── register.php           ← Registrasi akun
│   ├── logout.php             ← Logout + hapus session
│   ├── films.php              ← Daftar semua film
│   ├── detail.php             ← Detail film + jadwal
│   ├── kursi.php              ← Pilih kursi (max 1)
│   ├── booking.php            ← Konfirmasi pesanan
│   ├── pembayaran_midtrans.php ← Integrasi Midtrans Sandbox
│   ├── get_snap_token.php     ← Generate Snap Token API
│   ├── konfirmasi_midtrans.php ← Callback sukses bayar
│   ├── makanan.php            ← Pesan makanan
│   ├── wilayah.php            ← Lokasi bioskop Surabaya
│   ├── riwayat.php            ← Riwayat tiket user
│   └── admin/
│       ├── dashboard.php      ← Dashboard admin
│       └── films.php          ← CRUD film
└── evotix_db.sql              ← Schema + data dummy
```

---

## 🗄️ Database Schema

### Tabel Utama

| Tabel | Fungsi |
|-------|--------|
| `users` | Data pengguna + role (user/admin) |
| `films` | Data film (judul, genre, durasi, rating, sinopsis) |
| `schedules` | Jadwal tayang (film, studio, tanggal, jam, harga) |
| `seats` | Kursi per jadwal (available/locked/booked) |
| `bookings` | Data pemesanan tiket |
| `booking_details` | Relasi booking ↔ kursi |
| `transactions` | Data transaksi pembayaran |
| `menu_makanan` | Menu makanan & minuman |
| `order_makanan` | Pesanan makanan per booking |
| `wilayah` | Lokasi bioskop |

---

## ⚙️ Operasi CRUD

| Halaman | Operasi | Query SQL |
|---------|---------|-----------|
| Register | **CREATE** | `INSERT INTO users` |
| Login | **READ** | `SELECT FROM users WHERE email=?` |
| Pilih Kursi | **READ** | `SELECT FROM seats WHERE status='available'` |
| Klik Kursi | **UPDATE** | `UPDATE seats SET status='locked'` |
| Bayar | **CREATE** | `INSERT INTO bookings, transactions` |
| Bayar Sukses | **UPDATE** | `UPDATE bookings SET status='paid'` |
| Admin Hapus Film | **DELETE** | `DELETE FROM films WHERE id=?` |

---

## 💳 Integrasi Midtrans Sandbox

EVOTIX.ID menggunakan **Midtrans Sandbox** untuk simulasi pembayaran.

### Cara Setup Midtrans
1. Daftar di [sandbox.midtrans.com](https://sandbox.midtrans.com)
2. Dapatkan **Server Key** dan **Client Key** dari Settings → Access Keys
3. Ganti key di `pages/get_snap_token.php`:
```php
$server_key = 'SB-Mid-server-XXXXX'; // ganti ini
```
4. Ganti di `pages/pembayaran_midtrans.php`:
```php
define('MIDTRANS_CLIENT_KEY', 'SB-Mid-client-XXXXX'); // ganti ini
```

### Kartu Test Sandbox
| Field | Nilai |
|-------|-------|
| Nomor Kartu | `4811 1111 1111 1114` |
| CVV | `123` |
| Expired | `01/25` |
| OTP | `112233` |

### Metode Pembayaran yang Didukung
- 📱 **QRIS** — Scan QR code
- 🏦 **Transfer Bank** — Virtual Account BCA, BNI, Mandiri, BRI
- 💚 **E-Wallet** — GoPay, OVO, Dana, ShopeePay

---

## 🔐 Autentikasi & Keamanan

- Password di-hash menggunakan `password_hash()` dengan algoritma **bcrypt**
- Session PHP untuk manajemen login
- Input sanitasi dengan `htmlspecialchars()` dan `mysqli_real_escape_string()`
- Prepared statements untuk mencegah SQL Injection
- Role-based access control (user / admin)

---

## 🎨 Teknologi

| Layer | Teknologi |
|-------|-----------|
| Frontend | HTML5, CSS3, JavaScript (Vanilla) |
| Backend | PHP 8.x |
| Database | MySQL (via XAMPP) |
| Payment | Midtrans Sandbox (Snap.js) |
| Font | Bebas Neue, DM Sans, DM Mono |
| Version Control | Git + GitHub |

---

## 👤 Akun Demo

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@evotix.id | password |
| User | budi@gmail.com | password |

---

## 📝 Lisensi

Proyek ini dibuat untuk keperluan tugas akademik **Mata Kuliah Pemrograman Web**.

© 2025 Tim EVOTIX.ID

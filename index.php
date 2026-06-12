<?php
require_once 'includes/config.php';
$pageTitle = 'Beranda';

$films_tayang = $conn->query("SELECT * FROM films WHERE status='tayang' ORDER BY id DESC")->fetch_all(MYSQLI_ASSOC);
$films_coming = $conn->query("SELECT * FROM films WHERE status='akan_datang' LIMIT 4")->fetch_all(MYSQLI_ASSOC);

function getPosterEmoji($genre) {
    if (str_contains($genre,'Horror'))    return '👻';
    if (str_contains($genre,'Action'))    return '⚔️';
    if (str_contains($genre,'Romance'))   return '💫';
    if (str_contains($genre,'Animasi'))   return '🦊';
    if (str_contains($genre,'Comedy'))    return '😂';
    if (str_contains($genre,'Thriller'))  return '🔍';
    if (str_contains($genre,'Sci-Fi'))    return '🚀';
    if (str_contains($genre,'Drama'))     return '🎭';
    if (str_contains($genre,'Adventure')) return '🗺️';
    if (str_contains($genre,'Fantasy'))   return '✨';
    return '🎬';
}
?>
<?php include 'includes/header.php'; ?>

<style>
/* ── HERO ─────────────────────────────────── */
.hero-v2 {
    position: relative;
    min-height: 88vh;
    display: flex;
    align-items: center;
    overflow: hidden;
    padding: 0 40px;
}
.hero-v2::before {
    content:'';
    position:absolute;inset:0;
    background:
        radial-gradient(ellipse 60% 70% at 70% 50%, rgba(254,127,66,0.13) 0%, transparent 60%),
        radial-gradient(ellipse 40% 50% at 10% 80%, rgba(179,44,26,0.18) 0%, transparent 55%),
        radial-gradient(ellipse 30% 40% at 90% 10%, rgba(255,251,151,0.07) 0%, transparent 50%);
    pointer-events:none;
}
/* Decorative film strip right side */
.hero-strip {
    position:absolute;
    right:-10px; top:0; bottom:0;
    width:80px;
    display:flex;
    flex-direction:column;
    gap:0;
    opacity:0.08;
    pointer-events:none;
}
.hero-strip-cell {
    flex:1;
    border:2px solid var(--fire-orange);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:24px;
}
/* Floating accent shapes */
.hero-shape {
    position:absolute;
    border-radius:50%;
    border:1px solid rgba(254,127,66,0.15);
    pointer-events:none;
}

.hero-left { position:relative;z-index:2;max-width:640px; }

.hero-eyebrow {
    display:inline-flex;
    align-items:center;
    gap:8px;
    background:rgba(179,44,26,0.15);
    border:1px solid rgba(254,127,66,0.3);
    color:var(--fire-orange);
    padding:6px 18px;
    border-radius:4px;
    font-size:11px;
    font-weight:700;
    letter-spacing:3px;
    text-transform:uppercase;
    margin-bottom:28px;
}
.hero-eyebrow::before { content:''; width:6px;height:6px;border-radius:50%;background:var(--fire-orange);animation:blink 1.5s infinite;flex-shrink:0; }
@keyframes blink { 0%,100%{opacity:1}50%{opacity:0.2} }

.hero-v2 h1 {
    font-family:var(--font-display);
    font-size: clamp(52px, 9vw, 96px);
    line-height:0.88;
    letter-spacing:3px;
    margin-bottom:28px;
}
.hero-v2 h1 .w1 { display:block; color:var(--text-primary); }
.hero-v2 h1 .w2 {
    display:block;
    color:transparent;
    -webkit-text-stroke:2px var(--fire-orange);
}
.hero-v2 h1 .w3 { display:block; color:var(--fire-orange); }

.hero-tagline {
    font-size:16px;
    color:var(--text-muted);
    line-height:1.8;
    max-width:440px;
    margin-bottom:36px;
    border-left:3px solid var(--fire-red);
    padding-left:16px;
}

.hero-cta-row { display:flex; gap:14px; flex-wrap:wrap; align-items:center; }
.cta-fire {
    display:inline-flex;
    align-items:center;
    gap:10px;
    background:var(--fire-red);
    color:white;
    padding:15px 32px;
    border-radius:4px;
    font-family:var(--font-display);
    font-size:18px;
    letter-spacing:2px;
    transition:all 0.25s;
    border:2px solid var(--fire-red);
}
.cta-fire:hover { background:transparent; color:var(--fire-red); }
.cta-ghost {
    display:inline-flex;
    align-items:center;
    gap:8px;
    color:var(--text-muted);
    font-size:14px;
    font-weight:600;
    letter-spacing:1px;
    border-bottom:1px solid transparent;
    transition:all 0.2s;
}
.cta-ghost:hover { color:var(--fire-orange); border-color:var(--fire-orange); }

.hero-stats {
    display:flex;
    gap:32px;
    margin-top:48px;
    padding-top:32px;
    border-top:1px solid rgba(254,127,66,0.15);
    flex-wrap:wrap;
}
.hero-stat-num {
    font-family:var(--font-display);
    font-size:36px;
    color:var(--fire-orange);
    letter-spacing:1px;
    line-height:1;
}
.hero-stat-label {
    font-size:12px;
    color:var(--text-muted);
    margin-top:4px;
    letter-spacing:1px;
    text-transform:uppercase;
}

/* ── TICKER ───────────────────────────────── */
.ticker-wrap {
    overflow:hidden;
    background:var(--fire-red);
    padding:10px 0;
    margin:0;
}
.ticker-inner {
    display:flex;
    gap:60px;
    animation:ticker 25s linear infinite;
    width:max-content;
}
@keyframes ticker { from{transform:translateX(0)} to{transform:translateX(-50%)} }
.ticker-item {
    font-family:var(--font-display);
    font-size:14px;
    letter-spacing:3px;
    color:rgba(255,255,255,0.9);
    white-space:nowrap;
    flex-shrink:0;
}
.ticker-dot { color:var(--fire-yellow); margin:0 8px; }

/* ── FITUR CARDS ──────────────────────────── */
.fitur-grid {
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:2px;
    background:rgba(254,127,66,0.1);
    border:1px solid rgba(254,127,66,0.1);
    border-radius:var(--radius-lg);
    overflow:hidden;
    margin-bottom:0;
}
@media(max-width:768px){.fitur-grid{grid-template-columns:1fr 1fr;}}
@media(max-width:480px){.fitur-grid{grid-template-columns:1fr;}}

.fitur-item {
    background:var(--fire-dark2);
    padding:32px 28px;
    text-decoration:none;
    transition:all 0.25s;
    display:flex;
    flex-direction:column;
    gap:10px;
    position:relative;
    overflow:hidden;
}
.fitur-item::after {
    content:'';
    position:absolute;
    bottom:0;left:0;right:0;
    height:2px;
    background:linear-gradient(90deg,var(--fire-red),var(--fire-orange));
    transform:scaleX(0);
    transform-origin:left;
    transition:transform 0.3s;
}
.fitur-item:hover::after { transform:scaleX(1); }
.fitur-item:hover { background:var(--fire-mid); }
.fitur-icon { font-size:32px; }
.fitur-name {
    font-family:var(--font-display);
    font-size:18px;
    letter-spacing:1px;
    color:var(--text-primary);
}
.fitur-desc { font-size:13px; color:var(--text-muted); line-height:1.6; flex:1; }
.fitur-arrow {
    font-size:12px;
    color:var(--fire-orange);
    font-weight:700;
    letter-spacing:1px;
    margin-top:4px;
}

/* ── SECTION LABEL ────────────────────────── */
.section-label {
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:24px;
}
.section-label::before {
    content:'';
    width:32px;height:2px;
    background:var(--fire-red);
    flex-shrink:0;
}
.section-label span {
    font-family:var(--font-display);
    font-size:32px;
    letter-spacing:2px;
    color:var(--text-primary);
}
.section-label span em {
    font-style:normal;
    color:var(--fire-orange);
}
.section-label a {
    margin-left:auto;
    font-size:13px;
    color:var(--text-muted);
    font-weight:600;
    letter-spacing:0.5px;
}
.section-label a:hover { color:var(--fire-orange); }

/* film card hover glow */
.film-card:hover {
    box-shadow:0 0 0 1px var(--fire-orange), 0 16px 48px rgba(179,44,26,0.25);
}
</style>

<!-- HERO -->
<section class="hero-v2">
    <!-- Decorative -->
    <div class="hero-strip">
        <?php for($i=0;$i<20;$i++) echo '<div class="hero-strip-cell">▢</div>'; ?>
    </div>
    <div class="hero-shape" style="width:400px;height:400px;right:-100px;top:-100px;"></div>
    <div class="hero-shape" style="width:200px;height:200px;left:60%;bottom:10%;"></div>

    <div class="hero-left">
        <div class="hero-eyebrow">✦ Now Live in Surabaya</div>
        <h1>
            <span class="w1">YOUR MOVIE.</span>
            <span class="w2">YOUR SEAT.</span>
            <span class="w3">YOUR WAY.</span>
        </h1>
        <p class="hero-tagline">
            No more queues. Book your seat online, pay in seconds — dan nikmati pengalaman bioskop yang lebih <em style="font-style:normal;color:var(--fire-yellow);">personal</em> dari sebelumnya.
        </p>
        <div class="hero-cta-row">
            <a href="pages/films.php" class="cta-fire">Book Now →</a>
            <a href="pages/cari.php" class="cta-ghost">🔍 Cari Film</a>
        </div>
        <div class="hero-stats">
            <div>
                <div class="hero-stat-num">9</div>
                <div class="hero-stat-label">Movies Playing</div>
            </div>
            <div>
                <div class="hero-stat-num">30</div>
                <div class="hero-stat-label">Seats / Studio</div>
            </div>
            <div>
                <div class="hero-stat-num">15</div>
                <div class="hero-stat-label">Food Menu</div>
            </div>
            <div>
                <div class="hero-stat-num">2</div>
                <div class="hero-stat-label">Lokasi Surabaya</div>
            </div>
        </div>
    </div>
</section>

<!-- TICKER -->
<div class="ticker-wrap">
    <div class="ticker-inner">
        <?php
        $items = ['GARUDA SAKTI','CINTA DI UJUNG GALAKSI','HANTU KAMAR 13','PETUALANGAN SI KANCIL 2','LANGIT MERAH JAKARTA','SENYUM TERAKHIR MAYA','BAJAK LAUT NUSANTARA','ANOMALI','JURAGAN MUDA'];
        $all = array_merge($items,$items);
        foreach($all as $it) echo '<span class="ticker-item">'.$it.'<span class="ticker-dot">✦</span></span>';
        ?>
    </div>
</div>

<!-- FITUR -->
<section class="section" style="padding-top:48px;">
    <div class="section-label" style="margin-bottom:20px;">
        <span>What can you <em>do</em> here</span>
    </div>
    <div class="fitur-grid">
        <a href="pages/films.php" class="fitur-item">
            <div class="fitur-icon">🎬</div>
            <div class="fitur-name">PILIH FILM</div>
            <div class="fitur-desc">9 film sedang tayang, dari action hingga horror. Lihat jadwal dan pilih yang kamu mau.</div>
            <div class="fitur-arrow">LIHAT FILM →</div>
        </a>
        <a href="pages/films.php" class="fitur-item">
            <div class="fitur-icon">🪑</div>
            <div class="fitur-name">PILIH KURSI</div>
            <div class="fitur-desc">30 kursi per studio. Pilih posisi favoritmu secara real-time — 1 kursi per transaksi.</div>
            <div class="fitur-arrow">PESAN SEKARANG →</div>
        </a>
        <a href="pages/makanan.php" class="fitur-item">
            <div class="fitur-icon">🍿</div>
            <div class="fitur-name">PESAN MAKANAN</div>
            <div class="fitur-desc">Popcorn, burger, nachos, minuman & paket combo. Diantar langsung ke kursimu.</div>
            <div class="fitur-arrow">LIHAT MENU →</div>
        </a>
        <a href="pages/wilayah.php" class="fitur-item">
            <div class="fitur-icon">📍</div>
            <div class="fitur-name">LOKASI SURABAYA</div>
            <div class="fitur-desc">Grand City Mall & Galaxy Mall. Dua lokasi strategis di jantung Surabaya.</div>
            <div class="fitur-arrow">CEK LOKASI →</div>
        </a>
        <a href="<?= isLogin()?'pages/riwayat.php':'pages/login.php' ?>" class="fitur-item">
            <div class="fitur-icon">🎟</div>
            <div class="fitur-name">E-TICKET</div>
            <div class="fitur-desc">Tiket digital langsung ke emailmu. Tunjukkan QR code di pintu masuk — tanpa cetak.</div>
            <div class="fitur-arrow">TIKET SAYA →</div>
        </a>
        <a href="pages/register.php" class="fitur-item">
            <div class="fitur-icon">⚡</div>
            <div class="fitur-name">DAFTAR GRATIS</div>
            <div class="fitur-desc">Buat akun dalam 30 detik dan langsung bisa pesan tiket. Tidak ada biaya pendaftaran.</div>
            <div class="fitur-arrow">DAFTAR →</div>
        </a>
    </div>
</section>

<!-- FILM SEDANG TAYANG -->
<section class="section" id="nowplaying">
    <div class="section-label">
        <span>Now <em>Playing</em></span>
        <a href="pages/films.php">See All →</a>
    </div>
    <?php if(empty($films_tayang)): ?>
        <div class="empty-state"><div class="icon">🎬</div><h3>Belum Ada Film</h3></div>
    <?php else: ?>
    <div class="films-grid">
        <?php foreach($films_tayang as $film): ?>
        <div class="film-card" onclick="window.location='pages/detail.php?id=<?= $film['id'] ?>'">
            <div class="film-poster">
                <?php
                $ppath = $_SERVER['DOCUMENT_ROOT'] . '/evotix/images/posters/' . ($film['poster'] ?? '');
                if (!empty($film['poster']) && file_exists($ppath)): ?>
                    <img src="<?= SITE_URL ?>/images/posters/<?= htmlspecialchars($film['poster']) ?>"
                         alt="<?= htmlspecialchars($film['judul']) ?>"
                         style="width:100%;height:100%;object-fit:cover;position:absolute;inset:0;">
                <?php else: ?>
                <div class="film-poster-placeholder">
                    <?= getPosterEmoji($film['genre']) ?>
                    <span><?= htmlspecialchars($film['judul']) ?></span>
                </div>
                <?php endif; ?>
                <span class="film-badge">TAYANG</span>
            </div>
            <div class="film-info">
                <div class="film-title"><?= htmlspecialchars($film['judul']) ?></div>
                <div class="film-genre"><?= htmlspecialchars($film['genre']) ?></div>
                <div class="film-meta">
                    <span class="film-duration">⏱ <?= $film['durasi'] ?> menit</span>
                    <span class="film-rating"><?= $film['rating'] ?></span>
                </div>
            </div>
            <div class="film-card-footer">
                <a href="pages/detail.php?id=<?= $film['id'] ?>" class="btn-pesan">Pilih Jadwal →</a>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <?php endif; ?>
</section>

<!-- FILM AKAN DATANG -->
<?php if(!empty($films_coming)): ?>
<section class="section">
    <div class="section-label">
        <span>Coming <em>Soon</em></span>
    </div>
    <div class="films-grid">
        <?php foreach($films_coming as $film): ?>
        <div class="film-card">
            <div class="film-poster">
                <div class="film-poster-placeholder">
                    <?= getPosterEmoji($film['genre']) ?>
                    <span><?= htmlspecialchars($film['judul']) ?></span>
                </div>
                <span class="film-badge coming">SEGERA</span>
            </div>
            <div class="film-info">
                <div class="film-title"><?= htmlspecialchars($film['judul']) ?></div>
                <div class="film-genre"><?= htmlspecialchars($film['genre']) ?></div>
                <div class="film-meta">
                    <span class="film-duration">⏱ <?= $film['durasi'] ?> menit</span>
                    <span class="film-rating"><?= $film['rating'] ?></span>
                </div>
            </div>
            <div class="film-card-footer">
                <span class="btn-pesan disabled">Segera Hadir</span>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
</section>
<?php endif; ?>

<!-- CTA BOTTOM -->
<section style="margin:20px 0 60px;padding:60px 40px;text-align:center;border-top:1px solid rgba(254,127,66,0.1);">
    <div style="font-size:12px;letter-spacing:4px;color:var(--fire-orange);font-weight:700;margin-bottom:12px;">— READY TO WATCH? —</div>
    <div style="font-family:var(--font-display);font-size:clamp(28px,5vw,56px);letter-spacing:3px;margin-bottom:12px;">
        GET YOUR TICKET NOW
    </div>
    <p style="color:var(--text-muted);margin-bottom:28px;font-size:15px;">Ribuan penonton sudah menikmati kemudahan EVOTIX.ID — sekarang giliran kamu.</p>
    <a href="pages/films.php" class="cta-fire" style="display:inline-flex;">Book a Seat →</a>
</section>

<?php include 'includes/footer.php'; ?>

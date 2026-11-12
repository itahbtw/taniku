# Taniku (Android)

Aplikasi Android untuk manajemen usahatani sederhana. Tampilan dan logika
berada di `index.html` yang dibungkus WebView native agar berjalan offline
sebagai APK.

APK release tersedia di halaman
[Releases](https://github.com/itahbtw/taniku/releases/latest).

## Fitur

- Home: musim aktif, biaya, total panen, laba, dan aktivitas terbaru
- Lahan dan musim tanam
- Catatan aktivitas dan biaya produksi
- Catatan panen dan penjualan
- Laporan laba-rugi (bisa dicetak lewat dialog print Android)
- Ekspor dan impor cadangan data (file JSON) lewat tombol cadangan di pojok
  kanan atas header
- Data tersimpan lokal di WebView (`localStorage`), tanpa akun
- Saat pertama dipasang, aplikasi dimulai tanpa data; pengguna menambahkan
  lahan dan musim tanam sendiri

## Kebutuhan

- JDK 17+ (sistem ini memakai JDK 21)
- Android SDK: platform 36, build-tools 36.0.0, platform-tools

## Build

```bash
git clone https://github.com/itahbtw/taniku.git
cd taniku
./gradlew assembleDebug
```

APK dihasilkan di:

```
app/build/outputs/apk/debug/app-debug.apk
```

## Build release (bertanda tangan)

Build release memakai keystore lokal yang tidak di-commit:

- `keystore/taniku-release.jks`
- `keystore.properties` (berisi path, alias, dan password)

Keduanya wajib dicadangkan. Jika hilang, APK dengan `applicationId` yang sama
tidak bisa diperbarui lagi.

```bash
./gradlew assembleRelease
```

Hasil:

```
app/build/outputs/apk/release/app-release.apk
```

APK release ditandatangani dengan skema v2.

## Pasang ke perangkat

```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```

## Mengubah tampilan

Edit `index.html` di folder ini, lalu build ulang. Task `syncWebAssets`
otomatis menyalin `index.html` dan `chart.umd.min.js` ke
`app/src/main/assets/` sebelum build, jadi tidak perlu menyalin manual.

Chart.js dimuat terpisah dan baru diambil saat halaman Laporan dibuka, sehingga
proses start aplikasi tidak perlu mem-parse seluruh bundle grafik.

## Catatan

- `local.properties` berisi lokasi Android SDK dan tidak perlu di-commit.
- Menghapus data aplikasi akan menghapus seluruh data Taniku di perangkat.
  Gunakan tombol **Cadangan Data** di pojok kanan atas header secara berkala
  dan simpan file JSON di tempat aman.
- Aplikasi sepenuhnya lokal: tidak ada akun, login, atau sinkronisasi server.
- Build release memakai R8 (minify + resource shrink) dan tanpa izin jaringan.
- Kunci JavaScript bridge (`TanikuAndroid`) dijaga lewat
  `app/proguard-rules.pro` agar tetap bisa dipanggil setelah minifikasi.

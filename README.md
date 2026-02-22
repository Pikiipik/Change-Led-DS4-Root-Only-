🎮 Change-Led-DS4-Root-Only
Script sederhana untuk mengubah warna LED pada kontroler DualShock 4 langsung dari HP Android. Penting: Perangkat kamu wajib sudah dalam keadaan ROOT.
📋 Persyaratan
Perangkat Android yang sudah di-Root.
Aplikasi Termux (disarankan unduh dari F-Droid).
Kontroler DualShock 4 yang sudah terhubung ke Android (via Bluetooth atau kabel OTG).
🚀 Cara Penggunaan
Ikuti langkah-langkah berikut di dalam terminal Termux:
1. Persiapan Awal
Pastikan package git sudah terinstall:
bash
pkg update && pkg upgrade
pkg install git -y
Gunakan kode dengan hati-hati.

2. Clone Repositori
Unduh script ini ke penyimpanan lokal Termux:
bash
git clone https://github.com
cd Change-Led-DS4-Root-Only-
Gunakan kode dengan hati-hati.

3. Memberikan Izin Eksekusi
Berikan izin agar script bisa dijalankan:
bash
chmod +x ds4_led.sh
Gunakan kode dengan hati-hati.

4. Menjalankan Script dengan Akses Root
Karena script ini memodifikasi file sistem untuk mengubah warna LED, kamu harus menjalankannya dengan perintah su (SuperUser):
bash
tsu  # Jika menggunakan package 'tsu'
# atau gunakan perintah standar root:
su -c "./ds4_led.sh"
Gunakan kode dengan hati-hati.

💡 Catatan
Script ini bekerja dengan mengakses direktori /sys/class/leds/. Jika kontroler tidak terdeteksi, pastikan koneksi Bluetooth/OTG stabil.
Gunakan dengan bijak, segala resiko ditanggung pengguna. 

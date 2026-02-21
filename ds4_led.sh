#!/system/bin/sh
# ==========================================
#        DS4 LED CONTROLLER MENU v2.7
#           SC BY VIKIDWS 🎮
# ==========================================

R=$(ls -d /sys/class/leds/*:red/brightness 2>/dev/null | head -n 1)
G=$(ls -d /sys/class/leds/*:green/brightness 2>/dev/null | head -n 1)
B=$(ls -d /sys/class/leds/*:blue/brightness 2>/dev/null | head -n 1)
BAT=$(ls -d /sys/class/power_supply/sony_controller_battery_*/capacity 2>/dev/null | head -n 1)

if [ -z "$R" ]; then echo "STIK TIDAK TERDETEKSI! ❌"; exit 1; fi

# TRAP agar CTRL+C kembali ke menu tanpa error
trap 'main_menu' INT

# FUNGSI SUPER SMOOTH FADE
# Menggunakan step 1 agar transisi tidak melompat
smooth_fade() {
    val=0
    while [ $val -le 255 ]; do
        echo $val > $1          # Warna baru naik perlahan
        echo $((255-val)) > $2  # Warna lama turun perlahan
        val=$((val+1))          # Step 1 untuk kehalusan maksimal
        usleep 4000             # Jeda 4ms agar transisi tampak mengalir
    done
}

main_menu() {
    while true; do
        clear
        [ -f "$BAT" ] && STATUS_BAT="$(cat $BAT)%" || STATUS_BAT="-"
        
        echo "=========================================="
        echo "      DS4 LED CONTROLLER MENU v2.7      "
        echo "          SC BY VIKIDWS 🎮              "
        echo "------------------------------------------"
        echo " [🔋] STATUS BATERAI: $STATUS_BAT "
        echo "=========================================="
        echo " 1. Mode Standar (Biru) 🔵 "
        echo " 2. Mode RGB 1 (Normal) 🌈 "
        echo " 3. Mode RGB 2 (Ultra Smooth +) ✨ "
        echo " 4. Mode Polisi 🚨 "
        echo " 5. Matikan Lampu (Off) ⚫ "
        echo " 6. [?] Mystery Link 🔗 "
        echo " 7. Keluar 🚪 "
        echo "=========================================="
        printf " Pilih mode (1-7): "
        read pilihan

        case $pilihan in
            1) echo 0 > $R; echo 0 > $G; echo 255 > $B; sleep 1 ;;
            2) echo "\n[✔] Running RGB 1... (CTRL+C untuk Menu)"
               while true; do
                   echo 255 > $R; echo 0 > $G; echo 0 > $B; sleep 0.8
                   echo 0 > $R; echo 255 > $G; echo 0 > $B; sleep 0.8
                   echo 0 > $R; echo 0 > $G; echo 255 > $B; sleep 0.8
               done ;;
            3) echo "\n[✔] Running RGB 2... (CTRL+C untuk Menu)"
               # Reset ke Merah Nyala sebelum mulai loop smooth
               echo 255 > $R; echo 0 > $G; echo 0 > $B
               while true; do
                   smooth_fade $G $R  # Merah ke Hijau
                   smooth_fade $B $G  # Hijau ke Biru
                   smooth_fade $R $B  # Biru ke Merah
               done ;;
            4) echo "\n[✔] Running Polisi... (CTRL+C untuk Menu)"
               while true; do
                   echo 255 > $R; echo 0 > $B; sleep 0.2
                   echo 0 > $R; echo 255 > $B; sleep 0.2
               done ;;
            5) echo 0 > $R; echo 0 > $G; echo 0 > $B; sleep 1 ;;
            6) echo "\nIG: https://www.instagram.com/vikidw"; read dummy ;;
            7) exit 0 ;;
        esac
    done
}

main_menu

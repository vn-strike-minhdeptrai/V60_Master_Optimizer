#!/system/bin/sh
ACTION=$1

MODDIR="$(dirname $0)"
HOSTS_ADBLOCK="$MODDIR/hosts.adblock"
URL_GLOBAL="https://cdn.jsdelivr.net/gh/StevenBlack/hosts@master/hosts"
URL_VN="https://cdn.jsdelivr.net/gh/bigdargon/hostsVN@master/hosts"

case "$ACTION" in
    "game")
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $cpu 2>/dev/null; done
        echo "🔥 Đã kích hoạt chế độ Gaming!"
        ;;
    "save")
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "schedutil" > $cpu 2>/dev/null; done
        echo "🍃 Đã kích hoạt chế độ Tiết kiệm pin!"
        ;;
    "adblock")
        # Dùng nsenter để check trạng thái ở ngoài phòng khách
        if nsenter -t 1 -m grep -q "StevenBlack" /system/etc/hosts 2>/dev/null; then
            # Đang Bật -> Dùng nsenter lột mặt nạ Toàn cục
            nsenter -t 1 -m umount /system/etc/hosts 2>/dev/null
            echo "🔓 Đã TẮT chặn quảng cáo! (Mẹo: Bật/Tắt Máy bay để reset mạng)"
        else
            if [ ! -s "$HOSTS_ADBLOCK" ]; then
                echo "⏳ Đang dung hợp Siêu bộ lọc Global + VN..."
                curl -sL -k "$URL_GLOBAL" -o "$MODDIR/hosts.global" || /data/adb/ap/bin/busybox wget -qO "$MODDIR/hosts.global" "$URL_GLOBAL"
                curl -sL -k "$URL_VN" -o "$MODDIR/hosts.vn" || /data/adb/ap/bin/busybox wget -qO "$MODDIR/hosts.vn" "$URL_VN"
                
                echo "127.0.0.1 localhost" > "$HOSTS_ADBLOCK"
                echo "::1 localhost" >> "$HOSTS_ADBLOCK"
                cat "$MODDIR/hosts.global" "$MODDIR/hosts.vn" | grep "^0.0.0.0" | sort -u >> "$HOSTS_ADBLOCK"
                rm -f "$MODDIR/hosts.global" "$MODDIR/hosts.vn"
                chmod 644 "$HOSTS_ADBLOCK"
            fi

            if [ -s "$HOSTS_ADBLOCK" ]; then
                # Ép mặt nạ Toàn cục bằng nsenter
                nsenter -t 1 -m mount --bind "$HOSTS_ADBLOCK" /system/etc/hosts
                echo "🛡️ Đã BẬT chặn QC Toàn Cục! (Hãy Reset mạng)"
            else
                echo "⚠️ Lỗi: Không thể tải Data. Kiểm tra lại mạng!"
                rm -f "$HOSTS_ADBLOCK"
            fi
        fi
        ;;
    "ram")
        sync; echo 3 > /proc/sys/vm/drop_caches
        echo "🚀 Đã giải phóng RAM!"
        ;;
    "info")
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
        TEMP_C=$((TEMP / 1000))
        FREQ=$(cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq 2>/dev/null)
        FREQ_MHZ=$((FREQ / 1000))
        echo "${TEMP_C}|${FREQ_MHZ}"
        ;;
esac

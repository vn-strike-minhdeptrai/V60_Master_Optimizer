#!/system/bin/sh
MODDIR="/data/adb/modules/lg_v60_ea_optimizer"

# 1. KHỞI TỘNG WEBUI NGAY LẬP TỨC (Không chờ đợi)
killall httpd 2>/dev/null
busybox httpd -p 8080 -h "$MODDIR/webui"

# 2. CHỜ HỆ THỐNG ỔN ĐỊNH (Giảm xuống 30 giây)
sleep 30
setenforce 0

echo "balance" > /data/local/tmp/v60_current_mode

if grep -q "stevenblack" /system/etc/hosts; then
    echo "ON" > /data/local/tmp/v60_adblock_status
else
    echo "OFF" > /data/local/tmp/v60_adblock_status
fi

echo 512 > /sys/block/sda/queue/read_ahead_kb
echo 512 > /sys/block/sdb/queue/read_ahead_kb
echo lz4 > /sys/block/zram0/comp_algorithm 2>/dev/null || echo zstd > /sys/block/zram0/comp_algorithm 2>/dev/null
echo 60 > /proc/sys/vm/swappiness

echo "0-3" > /dev/cpuset/background/cpus
echo "0-3" > /dev/cpuset/system-background/cpus

settings put global device_idle_constants "inactive_to=60000,sensing_to=0,locating_to=0,location_accuracy=20.0,motion_inactive_to=0,idle_after_inactive_to=0,idle_pending_to=30000,max_idle_pending_to=60000,idle_pending_factor=2.0,quick_doze_delay=60000,idle_to=900000,max_idle_to=3600000,idle_factor=2.0,min_time_to_alarm=60000"

safe_freeze() { pm disable-user "$1" >/dev/null 2>&1; }
safe_freeze com.lge.dualscreen
safe_freeze com.lge.dualscreen.settings
safe_freeze com.lge.dualscreen.tool
safe_freeze com.lge.mlt
safe_freeze com.lge.smartdoctor.weapon
safe_freeze com.lge.gcu
safe_freeze com.lge.intelligence
safe_freeze com.lge.cloud.server
safe_freeze com.lge.ia.task.styler
safe_freeze com.facebook.system
safe_freeze com.facebook.appmanager
safe_freeze com.facebook.services
safe_freeze com.microsoft.skydrive
safe_freeze com.google.android.apps.socratic
safe_freeze com.google.android.videos
safe_freeze com.google.android.apps.tachyon
safe_freeze com.google.android.apps.youtube.music
safe_freeze com.google.android.apps.subscriptions.red
safe_freeze com.google.android.apps.podcasts

# Chạy cấu hình Balance mặc định
sh "$MODDIR/webui/cgi-bin/balance.sh" >/dev/null 2>&1

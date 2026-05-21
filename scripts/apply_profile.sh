#!/system/bin/sh
# apply_profile.sh - Core profile switcher

PROFILE=$1
MODDIR=$(dirname $0)/..

case "$PROFILE" in
  game)
    echo "[Game] Applying high performance + cooling..."
    # CPU Governor
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo schedutil > $cpu 2>/dev/null || true
    done
    # GPU performance
    echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor 2>/dev/null || true
    settings put global animator_duration_scale 0.5
    echo "Game profile applied" >> $MODDIR/logs/profile.log
    ;;
  battery)
    echo "[Battery] Aggressive saving..."
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo powersave > $cpu 2>/dev/null || true
    done
    settings put global animator_duration_scale 0.3
    # More Doze later
    echo "Battery Saver applied" >> $MODDIR/logs/profile.log
    ;;
  balanced|*)
    echo "[Balanced] Smooth + efficient..."
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo schedutil > $cpu 2>/dev/null || true
    done
    settings put global animator_duration_scale 0.7
    echo "Balanced applied" >> $MODDIR/logs/profile.log
    ;;
esac

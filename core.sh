#!/system/bin/sh
MODE=$1
LOG=/data/adb/V60.log

case $MODE in
    game)
        echo "=== GAME MODE (Mạnh + Mát) ==="
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "performance" > $cpu 2>/dev/null; done
        echo 1 > /sys/class/kgpu/kgpu/boost 2>/dev/null || true
        echo "performance" > /sys/class/kgpu/kgpu/governor 2>/dev/null || true
        # Thermal guard
        echo 45 > /sys/class/thermal/thermal_zone*/trip_point_*_temp 2>/dev/null || true
        settings put global window_animation_scale 0.5
        settings put global transition_animation_scale 0.5
        settings put global animator_duration_scale 0.5
        echo "Game mode: Max perf + thermal control" >> $LOG
        echo "🔥 Game mode activated!"
        ;;

    battery)
        echo "=== BATTERY SAVER ==="
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "powersave" > $cpu 2>/dev/null; done
        settings put global window_animation_scale 0
        settings put global transition_animation_scale 0
        am set-inactive --user 0 com.google.android.gms 2>/dev/null
        echo 100 > /proc/sys/vm/swappiness
        echo "Battery mode - Pin trâu max" >> $LOG
        echo "🍃 Battery Saver activated!"
        ;;

    balanced|*)
        echo "=== BALANCED (Mượt + Đa nhiệm) ==="
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "schedutil" > $cpu 2>/dev/null; done
        settings put global window_animation_scale 0.75
        settings put global transition_animation_scale 0.75
        settings put global animator_duration_scale 0.75
        echo "Balanced mode - Mượt + đa nhiệm tốt" >> $LOG
        echo "⚖️ Balanced mode activated!"
        ;;
esac
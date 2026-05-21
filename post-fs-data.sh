#!/system/bin/sh
MODDIR=${0%/*}

# System props tối ưu
resetprop debug.sf.hw 1
resetprop debug.egl.hw 1
resetprop debug.hwui.renderer skiavk
resetprop ro.surface_flinger.running_without_sync_framework 0

# VM tweaks
echo 60 > /proc/sys/vm/vfs_cache_pressure
echo 0 > /proc/sys/vm/oom_kill_allocating_task

# Thermal & Scheduler base
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null

echo "[V60 Optimizer] Post-fs-data done" >> /data/adb/V60.log
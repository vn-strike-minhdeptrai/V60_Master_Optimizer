#!/system/bin/sh
echo "Content-type: text/plain"; echo ""

echo conservative > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null
echo conservative > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor 2>/dev/null
echo conservative > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor 2>/dev/null
echo "0-4" > /dev/cpuset/top-app/cpus 2>/dev/null

echo "eco" > /data/local/tmp/v60_current_mode
echo "OK"

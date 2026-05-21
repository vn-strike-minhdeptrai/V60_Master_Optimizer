#!/system/bin/sh
echo "Content-type: text/plain"; echo ""

echo schedutil > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null
echo performance > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor 2>/dev/null
echo performance > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor 2>/dev/null
echo "4-7" > /dev/cpuset/top-app/cpus 2>/dev/null

echo "gaming" > /data/local/tmp/v60_current_mode
echo "OK"

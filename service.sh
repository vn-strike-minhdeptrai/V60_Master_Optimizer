#!/system/bin/sh
MODDIR=${0%/*}

sleep 30

dumpsys deviceidle force-idle

for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo "schedutil" > $cpu; done
echo 1000 > /sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
echo 5000 > /sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
echo 0 > /sys/module/printk/parameters/console_suspend

settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
setprop sys.lmk.minfree_levels 18432:0,23040:100,27648:200,32256:250,55296:900,80640:950

JUNK_APPS="
com.tmobile.pr.adapt
com.tmobile.pr.mytmobile
com.att.myWireless
com.vzw.hss.myverizon
com.nttdocomo.android.dhome
com.nttdocomo.android.applicationmanager
com.sprint.w.preloads
com.google.android.apps.wellbeing
com.google.android.videos
com.google.android.music
com.facebook.services
com.facebook.system
com.facebook.appmanager
com.lge.bnr
com.lge.sizechangable.weather
com.lge.sizechangable.weather.platform
com.lge.appbox.client
com.lge.lgdmsclient
com.lge.abba
com.lge.ia.task.smartsetting
com.lge.phonemanagement
com.lge.phonemanagement.AppCleanupService
com.lge.pickme
com.lge.cic.eden.service
com.lge.ellievision
"
for app in $JUNK_APPS; do
    if [ ! -z "$app" ] && [ "${app:0:1}" != "#" ]; then
        if [ "$app" != "com.lge.hiddenmenu" ] && [ "$app" != "com.qualcomm.qti.autosimlockservice" ]; then
            pm disable "$app" > /dev/null 2>&1
        fi
    fi
done

if [ -s "$MODDIR/hosts.adblock" ]; then
    nsenter -t 1 -m mount --bind "$MODDIR/hosts.adblock" /system/etc/hosts
fi

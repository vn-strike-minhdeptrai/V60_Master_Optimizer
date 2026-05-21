#!/system/bin/sh
# V60_Master_Optimizer - post-fs-data
# Early tweaks

MODDIR=${0%/*}

# Default Balanced animation scale on boot
settings put global animator_duration_scale 0.7
settings put global transition_animation_scale 0.7
settings put global window_animation_scale 0.7

# Log
 echo "[$(date)] Post-fs-data applied - Default Balanced animation" >> $MODDIR/logs/boot.log

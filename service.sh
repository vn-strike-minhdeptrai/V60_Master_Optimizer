#!/system/bin/sh
# V60_Master_Optimizer - service.sh
# Late start, apply last profile or default

MODDIR=${0%/*}

# Wait for boot complete
while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done

# Apply last used profile or Balanced
echo "[$(date)] Service started - Applying profile..." >> $MODDIR/logs/service.log

# TODO: read current_profile and apply
sh $MODDIR/scripts/apply_profile.sh balanced

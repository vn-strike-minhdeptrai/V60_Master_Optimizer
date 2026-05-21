#!/system/bin/sh
MODDIR=${0%/*}

sleep 25

# Default Balanced mode
sh $MODDIR/core.sh balanced

# Adblock nếu có
if [ -f $MODDIR/hosts.adblock ]; then
    nsenter -t 1 -m mount --bind $MODDIR/hosts.adblock /system/etc/hosts 2>/dev/null || true
fi

echo "[V60 Optimizer] Service started - Balanced mode" >> /data/adb/V60.log
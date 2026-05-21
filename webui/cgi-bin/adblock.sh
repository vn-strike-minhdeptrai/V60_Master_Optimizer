#!/system/bin/sh
echo "Content-type: text/plain"; echo ""

STATUS=$(cat /data/local/tmp/v60_adblock_status 2>/dev/null || echo "ON")

if [ "$STATUS" = "ON" ]; then
    # Tạo file trắng và đè lên để vô hiệu hóa chặn QC
    echo "127.0.0.1 localhost" > /data/local/tmp/clean_hosts
    echo "::1 localhost" >> /data/local/tmp/clean_hosts
    mount -o bind /data/local/tmp/clean_hosts /system/etc/hosts 2>/dev/null
    echo "OFF" > /data/local/tmp/v60_adblock_status
else
    # Gỡ mount file trắng để lộ file hosts của module (Kích hoạt lại)
    umount /system/etc/hosts 2>/dev/null
    echo "ON" > /data/local/tmp/v60_adblock_status
fi
echo "OK"

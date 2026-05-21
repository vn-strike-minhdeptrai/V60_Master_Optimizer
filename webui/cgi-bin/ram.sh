#!/system/bin/sh
echo "Content-type: text/plain"; echo ""

sync
echo 3 > /proc/sys/vm/drop_caches 2>/dev/null

echo "OK"

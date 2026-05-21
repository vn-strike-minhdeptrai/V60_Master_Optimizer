#!/system/bin/sh
echo "Content-type: text/plain"; echo ""

MODE=$(cat /data/local/tmp/v60_current_mode 2>/dev/null || echo "balance")
AD=$(cat /data/local/tmp/v60_adblock_status 2>/dev/null || echo "ON")

echo "${MODE}|${AD}"

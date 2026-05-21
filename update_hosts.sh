#!/bin/bash
echo "Đang tải bộ lọc từ StevenBlack (Quốc tế)..."
curl -s https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts > hosts_global.txt

echo "Đang tải bộ lọc từ HostsVN (Việt Nam)..."
curl -s https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts > hosts_vn.txt

echo "Đang tiến hành gộp và loại bỏ các tên miền trùng lặp..."
cat hosts_global.txt hosts_vn.txt | grep -v "^#" | grep -v "^$" | sort -u > hosts_merged.txt

echo "127.0.0.1 localhost" > system/etc/hosts
echo "::1 localhost" >> system/etc/hosts

cat hosts_merged.txt >> system/etc/hosts

rm hosts_global.txt hosts_vn.txt hosts_merged.txt
echo "Đã tạo xong file hosts tổng hợp siêu mạnh!"

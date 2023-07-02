#!/bin/sh

cpu_freq=$(cat /proc/cpuinfo | grep "cpu MHz" | head -n 1 | awk '{printf "%.2f", $4/1000}')
mem_size=$(free -m | awk 'NR==2 {print $2}')
disk_size=$(df -h | awk '$NF == "/" {print $2}')

output_file="/home/dbuser/hardware.txt"

echo "CPU Frequency: ${cpu_freq} MHz" > "${output_file}"
echo "Memory Size: ${mem_size} MB" >> "${output_file}"
echo "Disk Size: ${disk_size}" >> "${output_file}"
cat "${output_file}"






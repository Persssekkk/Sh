#!/bin/sh

apk add ethtool

interface_count=$(ip -o link show | wc -l)


output_file="/home/dbuser/network.txt"
echo "Number of Interfaces: ${interface_count}" > "${output_file}"
echo "" >> "${output_file}"


for interface in $(ip -o link show | awk -F': ' '{print $2}')
do
    echo "Interface: ${interface}" >> "${output_file}"
    echo "-------------------------" >> "${output_file}"
    
   
    speed=$(doas ethtool "${interface}" | awk '/Speed:/ {print $2}')
    echo "Speed: ${speed}" >> "${output_file}"
    
    
    ip_addresses=$(ip addr show "${interface}" | awk '/inet / {print $2}')
    echo "IP Addresses and Masks:" >> "${output_file}"
    echo "${ip_addresses}" >> "${output_file}"
    
    
    mac_address=$(ip addr show "${interface}" | awk '/link\/ether/ {print $2}')
    echo "MAC Address: ${mac_address}" >> "${output_file}"
    
    
    default_gateway=$(ip route show default | awk '/default/ {print $3}')
    echo "Default Gateway: ${default_gateway}" >> "${output_file}"
    
    
    dns_servers=$(cat /etc/resolv.conf | awk '/nameserver/ {print $2}')
    echo "DNS Servers:" >> "${output_file}"
    echo "${dns_servers}" >> "${output_file}"
    
    echo "" >> "${output_file}"
done


cat "${output_file}"



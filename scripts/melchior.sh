#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update -y && apt-get install -y iptables netcat-traditional || apt-get install -y netcat-openbsd

killall nc 2>/dev/null

# Listener Port 80 & 5000 di background
while true; do nc -l -n -p 5000 > /root/melchior_5000.log 2>&1 &
echo "Melchior Listener Active on Port 5000"
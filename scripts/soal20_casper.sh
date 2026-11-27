#!/bin/sh
set -e

printf "nameserver 8.8.8.8\nnameserver 1.1.1.1\n" > /etc/resolv.conf

# Reset & pasang firewall stealth Casper (Soal 11)
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

# Hentikan listener lama agar tidak dobel, lalu jalankan ulang
pkill -f "nc -l -n -p 5000" 2>/dev/null || true
while true; do nc -l -n -p 5000 >> /root/casper_5000.log 2>&1; done &

echo "[OK] Magi-Casper dipulihkan (stealth firewall + TCP 5000)."
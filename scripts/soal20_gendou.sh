#!/bin/sh
set -e

# Aktifkan IP forwarding
sysctl -w net.ipv4.ip_forward=1 >/dev/null

# Reset rule iptables & set policy aman dulu sebelum rebuild
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# NAT MASQUERADE untuk traffic internal keluar ke internet lewat eth0
iptables -t nat -A POSTROUTING -s 192.232.0.0/16 ! -d 192.232.0.0/16 -o eth0 -j MASQUERADE

# Firewall dasar (Soal 5)
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p udp --sport 67 --dport 68 -i eth0 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -s 192.232.0.0/16 ! -d 192.232.0.0/16 -o eth0 -j ACCEPT
iptables -A FORWARD -s 192.232.0.0/16 -d 192.232.0.0/16 -j ACCEPT
iptables -A INPUT -s 192.232.0.0/16 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Pulihkan rute statis cabang secara idempoten (replace agar tidak dobel)
ip route replace 192.232.4.56/29 via 192.232.4.162
ip route replace 192.232.4.164/30 via 192.232.4.162
ip route replace 192.232.4.80/29 via 192.232.4.162
ip route replace 192.232.4.168/30 via 192.232.4.162
ip route replace 192.232.3.192/27 via 192.232.4.162

ip route replace 192.232.4.88/29 via 192.232.4.154
ip route replace 192.232.4.156/30 via 192.232.4.154
ip route replace 192.232.4.72/29 via 192.232.4.154

ip route replace 192.232.4.64/29 via 192.232.4.150
ip route replace 192.232.4.100/30 via 192.232.4.146

ip route replace 192.232.4.136/30 via 192.232.4.133
ip route replace 192.232.3.128/26 via 192.232.4.133
ip route replace 192.232.4.140/30 via 192.232.4.133
ip route replace 192.232.4.48/29 via 192.232.4.133
ip route replace 192.232.4.96/30 via 192.232.4.133

ip route replace 192.232.2.0/24 via 192.232.4.126
ip route replace 192.232.4.128/30 via 192.232.4.126
ip route replace 192.232.3.0/25 via 192.232.4.126
ip route replace 192.232.3.224/27 via 192.232.4.126

ip route replace 192.232.4.112/30 via 192.232.4.110
ip route replace 192.232.4.0/27 via 192.232.4.110
ip route replace 192.232.4.116/30 via 192.232.4.110
ip route replace 192.232.0.0/23 via 192.232.4.110
ip route replace 192.232.4.120/30 via 192.232.4.110
ip route replace 192.232.4.32/28 via 192.232.4.110

echo "[OK] Gendou dipulihkan (iptables + NAT + static routes)."
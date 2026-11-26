#!/bin/sh
TERMINAL=192.232.4.56/29      # subnet Switch-Terminal
ARMISAEL=192.232.4.90         # Armisael

[ "$(id -u)" = 0 ] || { echo "Harus dijalankan sebagai root"; exit 1; }

sysctl -w net.ipv4.ip_forward=1 >/dev/null

if ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables
fi

UPIF=$(ip route show default | sed -n 's/.* dev \([^ ]*\).*/\1/p' | head -1)
[ -n "$UPIF" ] || { echo "Default route belum ada, perbaiki rute ke Gendo dulu."; exit 1; }

iptables -F FORWARD
iptables -P FORWARD ACCEPT

# Nomor 19: isolasi Armisael (harus paling atas)
iptables -A FORWARD -s $ARMISAEL -j DROP
iptables -A FORWARD -d $ARMISAEL -j DROP

# Nomor 18: gerbang zona sensitif
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i $UPIF -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i $UPIF -j DROP

# Nomor 19: Armisael ke gateway (Shigeru sendiri)
iptables -C INPUT -s $ARMISAEL -j DROP 2>/dev/null || iptables -I INPUT 1 -s $ARMISAEL -j DROP
iptables -C OUTPUT -d $ARMISAEL -j DROP 2>/dev/null || iptables -I OUTPUT 1 -d $ARMISAEL -j DROP

echo "Shigeru siap. Interface menghadap Gendo: $UPIF"
iptables -L FORWARD -n -v --line-numbers
iptables -L INPUT -n -v --line-numbers
iptables -L OUTPUT -n -v --line-numbers
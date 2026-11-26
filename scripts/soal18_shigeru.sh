#!/bin/sh
TERMINAL=192.232.4.56/29      # subnet Switch-Terminal

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

iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i $UPIF -s $TERMINAL -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i $UPIF -j DROP

echo "Gerbang zona aktif. Interface menghadap Gendo: $UPIF"
iptables -L FORWARD -n -v --line-numbers
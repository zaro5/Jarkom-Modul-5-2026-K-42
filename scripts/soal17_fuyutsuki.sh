#!/bin/sh
CASPER=192.232.4.57       # Magi-Casper
ZERUEL=192.232.4.89       # Zeruel
PENPEN=192.232.3.193      # Pen-Pen

[ "$(id -u)" = 0 ] || { echo "Harus dijalankan sebagai root"; exit 1; }

sysctl -w net.ipv4.ip_forward=1 >/dev/null

if ! command -v iptables >/dev/null 2>&1 || ! command -v conntrack >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables conntrack
fi

iptables -t nat -C PREROUTING -s $CASPER -d $ZERUEL -p tcp -j DNAT --to-destination $PENPEN 2>/dev/null || \
iptables -t nat -A PREROUTING -s $CASPER -d $ZERUEL -p tcp -j DNAT --to-destination $PENPEN

echo "DNAT aktif."
iptables -t nat -L PREROUTING -n -v --line-numbers
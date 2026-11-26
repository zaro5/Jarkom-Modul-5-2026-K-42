#!/bin/sh
ARMISAEL=192.232.4.90

[ "$(id -u)" = 0 ] || { echo "Harus dijalankan sebagai root"; exit 1; }

if ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables
fi

iptables -C INPUT -s $ARMISAEL -j DROP 2>/dev/null || iptables -I INPUT 1 -s $ARMISAEL -j DROP
iptables -C OUTPUT -d $ARMISAEL -j DROP 2>/dev/null || iptables -I OUTPUT 1 -d $ARMISAEL -j DROP

echo "Zeruel siap."
iptables -L INPUT -n -v --line-numbers
iptables -L OUTPUT -n -v --line-numbers
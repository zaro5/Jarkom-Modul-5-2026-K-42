#!/bin/sh
set -e

printf "nameserver 8.8.8.8\nnameserver 1.1.1.1\n" > /etc/resolv.conf

# Pulihkan default route Lilith ke gateway LAN A29 (192.232.4.86) secara idempoten
ip route replace default via 192.232.4.86

# Jika ada rule iptables tersimpan sebelumnya, pulihkan dari /root/lilith.rules bila tersedia
if [ -f /root/lilith.rules ]; then
    iptables-restore < /root/lilith.rules
fi

echo "[OK] Lilith dipulihkan (default route + DNS + iptables)."
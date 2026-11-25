#!/bin/sh
RATE=5/second
BURST=5

[ "$(id -u)" = 0 ] || { echo "Harus dijalankan sebagai root"; exit 1; }

grep -q nameserver /etc/resolv.conf 2>/dev/null || echo "nameserver 8.8.8.8" > /etc/resolv.conf

if ! command -v iptables >/dev/null 2>&1 || ! dpkg -s netcat-traditional >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1

# ===== Firewall: batas ping masuk =====
iptables -F INPUT
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit $RATE --limit-burst $BURST -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# ===== Listener port 80 dan 8080 =====
cat > /root/tokyo3core-80.sh <<'EOF'
#!/bin/sh
while true; do
  echo "Welcome to $(hostname)" | nc -l -p 80 -q 1 >/dev/null 2>&1
done
EOF
cat > /root/tokyo3core-8080.sh <<'EOF'
#!/bin/sh
while true; do
  echo "syifa imutz" | nc -l -p 8080 -q 1 >/dev/null 2>&1
done
EOF
chmod +x /root/tokyo3core-80.sh /root/tokyo3core-8080.sh

pkill -f tokyo3core-80.sh 2>/dev/null
pkill -f tokyo3core-8080.sh 2>/dev/null
pkill -x nc 2>/dev/null
sleep 1
nohup /root/tokyo3core-80.sh >/dev/null 2>&1 &
nohup /root/tokyo3core-8080.sh >/dev/null 2>&1 &

echo "Tokyo3-Core siap."
iptables -L INPUT -n -v --line-numbers
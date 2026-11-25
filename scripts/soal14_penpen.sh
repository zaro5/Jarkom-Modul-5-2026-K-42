#!/bin/sh
# ===== Jadwal (UTC = WIB - 7 jam). Ubah nilai ini untuk menguji. =====
PILOT_START=01:00
PILOT_STOP=09:00
PILOT_DAYS=Mon,Tue,Wed,Thu,Fri
STAF_START=10:00
STAF_STOP=16:00

# ===== Daftar IP (sesuaikan kalau alokasi berubah) =====
PILOT_IPS="192.232.4.65,192.232.4.66,192.232.4.67,192.232.3.129"   # Unit-01, Unit-02, Unit-00, Sachiel
STAF_IPS="192.232.4.81,192.232.4.82"                               # Lilith, Adam
DUMMY_IPS="192.232.4.49,192.232.4.50,192.232.4.101"                # Entry-Plug, Dummy-Plug, Spy

[ "$(id -u)" = 0 ] || { echo "Harus dijalankan sebagai root"; exit 1; }

# ===== Pasang paket kalau belum ada =====
if ! command -v iptables >/dev/null 2>&1 || ! dpkg -s netcat-traditional >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1

# ===== Firewall jadwal kunjungan (hanya ping dan TCP 80 ke Pen-Pen) =====
iptables -F INPUT

apply() {   # $1 = selector paket, $2 = aksi untuk yang ditolak
  iptables -A INPUT $1 -s $PILOT_IPS -m time --timestart $PILOT_START --timestop $PILOT_STOP --weekdays $PILOT_DAYS -j ACCEPT
  iptables -A INPUT $1 -s $STAF_IPS -m time --timestart $STAF_START --timestop $STAF_STOP -j ACCEPT
  iptables -A INPUT $1 -s $PILOT_IPS,$STAF_IPS,$DUMMY_IPS $2
}
apply "-p icmp --icmp-type echo-request" "-j DROP"
apply "-p tcp --dport 80" "-j REJECT --reject-with tcp-reset"

# ===== Listener port 80: jawab "Welcome to {hostname}" =====
cat > /root/penpen-listener.sh <<'EOF'
#!/bin/sh
while true; do
  echo "Welcome to $(hostname)" | nc -l -p 80 -q 1 >/dev/null 2>&1
done
EOF
chmod +x /root/penpen-listener.sh

pkill -f penpen-listener.sh 2>/dev/null
pkill -x nc 2>/dev/null
sleep 1
nohup /root/penpen-listener.sh >/dev/null 2>&1 &

echo "Pen-Pen siap. Waktu UTC sekarang: $(date -u)"
iptables -L INPUT -n -v --line-numbers
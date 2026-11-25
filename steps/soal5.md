# Soal 5

pada soal 5, diminta untuk membuat aturan `firewall`. Yakni; semua lalu lintas di `INPUT` dan `FORWARD` akan ditolak, hanya mengizinkan paket balasan dari internet yang koneksinya diinisiasi oleh host internal, hanya mengizinkan subnet internal mengirim koneksi keluar melalui `FORWARD`, mengizinkan seluruh subnet untuk komunikasi di `FORWARD`, mengizinkan subnet internal menghubungi Gendou dengan `INPUT`, dan mengizinkan interface `lo` serta DHXP pada eth0.

## Script

Pada soal ini, diperlulkan sebuah script di router `Gendou`.

```bash
#!/bin/sh

# 1. Aktifkan IP Forwarding
sysctl -w net.ipv4.ip_forward=1

# 2. Reset/Flush Rule & NAT Lama
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# 3. Set Policy Default menjadi DROP pada INPUT dan FORWARD (OUTPUT tetap ACCEPT)
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# -------------------------------------------------------------
# RULE FILTERING (TABLE FILTER)
# -------------------------------------------------------------

# (a) Izinkan Loopback Interface
iptables -A INPUT -i lo -j ACCEPT

# (b) Izinkan DHCP dari NAT1 (eth0) agar Gendou tetap dapat IP DHCP
iptables -A INPUT -i eth0 -p udp --dport 68 --sport 67 -j ACCEPT

# (c) Poin (a): Izinkan Balasan Koneksi yang Sudah Ada (ESTABLISHED, RELATED)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# (d) Poin (d): Izinkan Traffic dari Jaringan Internal (192.232.0.0/21) ke Gendou Sendiri
iptables -A INPUT -s 192.232.0.0/21 -j ACCEPT

# (e) Poin (b): Izinkan Traffic dari Jaringan Internal ke Internet via eth0
iptables -A FORWARD -s 192.232.0.0/21 -o eth0 -j ACCEPT

# (f) Poin (c): Izinkan Traffic Antar-LAN Internal
iptables -A FORWARD -s 192.232.0.0/21 -d 192.232.0.0/21 -j ACCEPT

# -------------------------------------------------------------
# RULE NAT (SOAL 4)
# -------------------------------------------------------------
# Masquerade traffic dari internal yang keluar via eth0
iptables -t nat -A POSTROUTING -s 192.232.0.0/21 -o eth0 -j MASQUERADE
```

## Pengujian

Untuk menguji soal 5, uji coba ping ke `8.8.8.8` dari Armisael dan juga jalankan iptables -S pada Gendou.

```bash
iptables -S
```

# Soal 2

## Konfigurasi per Router

### Gendou

```bash
# Set IP Interface
ip link set dev eth0 up
dhclient eth0

ip addr add 192.232.4.93/30 dev eth1    # Link A1 ke Yui
ip addr add 192.232.4.109/30 dev eth2   # Link A9 ke Hikari
ip addr add 192.232.4.117/30 dev eth3   # Link A13 ke Asuka
ip addr add 192.232.4.129/30 dev eth4   # Link A19 ke Kaji
ip addr add 192.232.4.133/30 dev eth5   # Link A21 ke Misato
ip addr add 192.232.4.138/30 dev eth6   # Link A23 ke Shigeru
ip addr add 192.232.4.146/30 dev eth7   # Link A27 ke Fuyutsuki
ip addr add 192.232.4.90/30 dev eth8    # LAN A33 (Switch-Cmd)

ip link set dev eth1 up
ip link set dev eth2 up
ip link set dev eth3 up
ip link set dev eth4 up
ip link set dev eth5 up
ip link set dev eth6 up
ip link set dev eth7 up
ip link set dev eth8 up

# Aktifkan IP Forwarding
sysctl -w net.ipv4.ip_forward=1
```

### Yui

```bash
ip addr add 192.232.4.94/30 dev eth0    # Link A1 ke Gendou
ip addr add 192.232.4.97/30 dev eth1    # Link A2 ke Shinji
ip addr add 192.232.4.101/30 dev eth2   # Link A4 ke Rei
ip addr add 192.232.4.105/30 dev eth3   # Link A6 ke Mari
ip addr add 192.232.3.126/25 dev eth4     # LAN A8 (Switch-Hangar)

ip link set dev eth0 up
ip link set dev eth1 up
ip link set dev eth2 up
ip link set dev eth3 up
ip link set dev eth4 up

sysctl -w net.ipv4.ip_forward=1
```

### Rei

```bash
ip addr add 192.232.4.102/30 dev eth0   # Link A4 ke Yui
ip addr add 192.232.1.254/23 dev eth1     # LAN A5 (Switch-Quarters)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Shinji

```bash
ip addr add 192.232.4.98/30 dev eth0    # Link A2 ke Yui
ip addr add 192.232.4.14/28 dev eth1     # LAN A3 (Switch-Garden)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Mari

```bash
ip addr add 192.232.4.106/30 dev eth0   # Link A6 ke Yui
ip addr add 192.232.4.30/28 dev eth1    # LAN A7 (Switch-Dock)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Hikari

```bash
ip addr add 192.232.4.110/30 dev eth0   # Link A9 ke Gendou
ip addr add 192.232.4.113/30 dev eth1   # Link A10 ke Kaworu
ip addr add 192.232.2.254/24 dev eth2     # LAN A12 (Switch-Comm)

ip link set dev eth0 up
ip link set dev eth1 up
ip link set dev eth2 up

sysctl -w net.ipv4.ip_forward=1
```

### Kaworu

```bash
ip addr add 192.232.4.114/30 dev eth0   # Link A10 ke Hikari
ip addr add 192.232.3.224/27 dev eth1   # LAN A11 (Switch-Relay)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Asuka

```bash
ip addr add 192.232.4.118/30 dev eth0   # Link A13 ke Gendou
ip addr add 192.232.4.121/30 dev eth1   # Link A14 ke Kensuke
ip addr add 192.232.4.125/30 dev eth2   # Link A16 ke Ritsuko
ip addr add 192.232.4.82/30 dev eth3    # LAN A18 (Switch-Archive)

ip link set dev eth0 up
ip link set dev eth1 up
ip link set dev eth2 up
ip link set dev eth3 up

sysctl -w net.ipv4.ip_forward=1
```

### Kensuke

```bash
ip addr add 192.232.4.122/30 dev eth0   # Link A14 ke Asuka
ip addr add 192.232.3.190/26 dev eth1   # LAN A15 (Switch-Bunker)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Ritsuko

```bash
ip addr add 192.232.4.126/30 dev eth0   # Link A16 ke Asuka
ip addr add 192.232.4.38/29 dev eth1    # LAN A17 (Switch-Lab)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Kaji

```bash
ip addr add 192.232.4.130/30 dev eth0   # Link A19 ke Gendou
ip addr add 192.232.4.86/30 dev eth1    # LAN A20 (Switch-Intel)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Misato

```bash
ip addr add 192.232.4.134/30 dev eth0   # Link A21 ke Gendou
ip addr add 192.232.4.54/29 dev eth1    # LAN A22 (Switch-Cage)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Shigeru

```bash
ip addr add 192.232.4.137/30 dev eth0   # Link A23 ke Gendou
ip addr add 192.232.4.141/30 dev eth1   # Link A24 ke Makoto
ip addr add 192.232.4.75/29 dev eth2    # LAN A26 (Switch-Monolith)

ip link set dev eth0 up
ip link set dev eth1 up
ip link set dev eth2 up

sysctl -w net.ipv4.ip_forward=1
```

### Makoto

```bash
ip addr add 192.232.4.142/30 dev eth0   # Link A24 ke Shigeru
ip addr add 192.232.4.62/29 dev eth1    # LAN A25 (Switch-Radar)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Toji

```bash
ip addr add 192.232.4.150/30 dev eth0   # Link A28 ke Fuyutsuki
ip addr add 192.232.4.67/29 dev eth1    # LAN A29 (Switch-Dogma)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

### Fuyutsuki

```bash
ip addr add 192.232.4.145/30 dev eth0   # Link A27 ke Gendou
ip addr add 192.232.4.149/30 dev eth1   # Link A28 ke Toji
ip addr add 192.232.4.154/30 dev eth2   # Link A30 ke Maya
ip addr add 192.232.4.46/29 dev eth3    # LAN A32 (Switch-Terminal)

ip link set dev eth0 up
ip link set dev eth1 up
ip link set dev eth2 up
ip link set dev eth3 up

sysctl -w net.ipv4.ip_forward=1
```

### Maya

```bash
ip addr add 192.232.4.153/30 dev eth0   # Link A30 ke Fuyutsuki
ip addr add 192.232.3.222/27 dev eth1   # LAN A31 (Switch-Medic)

ip link set dev eth0 up
ip link set dev eth1 up

sysctl -w net.ipv4.ip_forward=1
```

## Verifikasi Koneksi

Jalankan perintah `ip -br a` di setiap router.

```bash
ip -br a
```

Kemudian jalankan ping ke router lain dengan menggunakan `ping <IP_ADDRESS>`.
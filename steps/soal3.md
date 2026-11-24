# Soal 2

## Konfigurasi per Router

Pada soal nomor 3, lengkapi untuk konfigurasi di setiap router. Lihat pada bagian masing-masing configurasi, akan ada `up ip route add ....`. Inilah yang harus ditambahkan di soal nomor 3.

### Gendou

```bash
auto lo
iface lo inet loopback

# Interface ke NAT1 (DHCP)
auto eth0
iface eth0 inet dhcp
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A33 (Switch-Cmd / Tokyo3-Core)
auto eth1
iface eth1 inet static
    address 192.232.4.90
    netmask 255.255.255.252
    up ip link set dev eth1 up

# Link A27 ke Router Fuyutsuki
auto eth2
iface eth2 inet static
    address 192.232.4.146
    netmask 255.255.255.252
    up ip link set dev eth2 up
    
    # Rute ke Cabang Fuyutsuki
    up ip route add 192.232.3.192/27 via 192.232.4.145
    up ip route add 192.232.4.40/29 via 192.232.4.145
    up ip route add 192.232.4.64/29 via 192.232.4.145
    up ip route add 192.232.4.148/30 via 192.232.4.145
    up ip route add 192.232.4.152/30 via 192.232.4.145

# Link A23 ke Router Shigeru
auto eth3
iface eth3 inet static
    address 192.232.4.138
    netmask 255.255.255.252
    up ip link set dev eth3 up    
    
    # Rute ke Cabang Shigeru
    up ip route add 192.232.4.56/29 via 192.232.4.137
    up ip route add 192.232.4.72/29 via 192.232.4.137
    up ip route add 192.232.4.140/30 via 192.232.4.137

# Link A21 ke Router Misato
auto eth4
iface eth4 inet static
    address 192.232.4.133
    netmask 255.255.255.252
    up ip link set dev eth4 up
    
    # Rute ke Cabang Misato
    up ip route add 192.232.4.48/29 via 192.232.4.134

# Link A19 ke Router Kaji
auto eth5
iface eth5 inet static
    address 192.232.4.129
    netmask 255.255.255.252
    up ip link set dev eth5 up

    # Rute ke Cabang Kaji
    up ip route add 192.232.4.84/30 via 192.232.4.130

# Link A13 ke Router Asuka
auto eth6
iface eth6 inet static
    address 192.232.4.117
    netmask 255.255.255.252
    up ip link set dev eth6 up
    
    # Rute ke Cabang Asuka
    up ip route add 192.232.3.128/26 via 192.232.4.118
    up ip route add 192.232.4.32/29 via 192.232.4.118
    up ip route add 192.232.4.80/30 via 192.232.4.118
    up ip route add 192.232.4.120/30 via 192.232.4.118
    up ip route add 192.232.4.124/30 via 192.232.4.118

# Link A9 ke Router Hikari
auto eth7
iface eth7 inet static
    address 192.232.4.109
    netmask 255.255.255.252
    up ip link set dev eth7 up

    # Rute ke Cabang Hikari
    up ip route add 192.232.2.0/24 via 192.232.4.110
    up ip route add 192.232.3.224/27 via 192.232.4.110
    up ip route add 192.232.4.112/30 via 192.232.4.110

# Link A1 ke Router Yui
auto eth8
iface eth8 inet static
    address 192.232.4.93
    netmask 255.255.255.252
    up ip link set dev eth8 up
    
    # Rute ke Cabang Yui
    up ip route add 192.232.0.0/23 via 192.232.4.94
    up ip route add 192.232.3.0/25 via 192.232.4.94
    up ip route add 192.232.4.0/28 via 192.232.4.94
    up ip route add 192.232.4.16/28 via 192.232.4.94
    up ip route add 192.232.4.96/30 via 192.232.4.94
    up ip route add 192.232.4.100/30 via 192.232.4.94
    up ip route add 192.232.4.104/30 via 192.232.4.94
```

### Yui

```bash
auto lo
iface lo inet loopback

# Link A1 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.94
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.93
    up ip route add 192.232.4.0/28 via 192.232.4.98
    up ip route add 192.232.4.14/28 via 192.232.4.98
    up ip route add 192.232.1.254/23 via 192.232.4.102
    up ip route add 192.232.4.30/28 via 192.232.4.106

# LAN A8 (Switch-Hangar / Hangar-Crew)
auto eth1
iface eth1 inet static
    address 192.232.3.126
    netmask 255.255.255.128
    up ip link set dev eth1 up

# Link A6 ke Router Mari
auto eth2
iface eth2 inet static
    address 192.232.4.105
    netmask 255.255.255.252
    up ip link set dev eth2 up

# Link A4 ke Router Rei
auto eth3
iface eth3 inet static
    address 192.232.4.101
    netmask 255.255.255.252
    up ip link set dev eth3 up

# Link A2 ke Router Shinji
auto eth4
iface eth4 inet static
    address 192.232.4.97
    netmask 255.255.255.252
    up ip link set dev eth4 up
```

### Rei

```bash
auto lo
iface lo inet loopback

# Link A4 ke Router Yui
auto eth0
iface eth0 inet static
    address 192.232.4.102
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.101

# LAN A5 (Switch-Quarters / Quarters)
auto eth1
iface eth1 inet static
    address 192.232.1.254
    netmask 255.255.254.0
    up ip link set dev eth1 up
```

### Shinji

```bash
auto lo
iface lo inet loopback

# Link A2 ke Router Yui
auto eth0
iface eth0 inet static
    address 192.232.4.98
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.97

# LAN A3 (Switch-Garden / Garden-Staff)
auto eth1
iface eth1 inet static
    address 192.232.4.14
    netmask 255.255.255.240
    up ip link set dev eth1 up
```

### Mari

```bash
auto lo
iface lo inet loopback

# Link A6 ke Router Yui
auto eth0
iface eth0 inet static
    address 192.232.4.106
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.105

# LAN A7 (Switch-Dock / Dock-Crew)
auto eth1
iface eth1 inet static
    address 192.232.4.30
    netmask 255.255.255.240
    up ip link set dev eth1 up
```

### Hikari

```bash
auto lo
iface lo inet loopback

# Link A9 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.110
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.109
    up ip route add 192.232.3.224/27 via 192.232.4.114

# LAN A12 (Switch-Comm / Comm-Net)
auto eth1
iface eth1 inet static
    address 192.232.2.254
    netmask 255.255.255.0
    up ip link set dev eth1 up

# Link A10 ke Router Kaworu
auto eth2
iface eth2 inet static
    address 192.232.4.113
    netmask 255.255.255.252
    up ip link set dev eth2 up
```

### Kaworu

```bash
auto lo
iface lo inet loopback

# Link A10 ke Router Hikari
auto eth0
iface eth0 inet static
    address 192.232.4.114
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.113

# LAN A11 (Switch-Relay / Relay-Node)
auto eth1
iface eth1 inet static
    address 192.232.3.254
    netmask 255.255.255.224
    up ip link set dev eth1 up
```

### Asuka

```bash
auto lo
iface lo inet loopback

# Link A13 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.118
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.117
    up ip route add 192.232.3.128/26 via 192.232.4.122
    up ip route add 192.232.4.32/29 via 192.232.4.126
    

# LAN A18 (Switch-Archive / Archive-Vault)
auto eth1
iface eth1 inet static
    address 192.232.4.82
    netmask 255.255.255.252
    up ip link set dev eth1 up

# Link A16 ke Router Ritsuko
auto eth2
iface eth2 inet static
    address 192.232.4.125
    netmask 255.255.255.252
    up ip link set dev eth2 up

# Link A14 ke Router Kensuke
auto eth3
iface eth3 inet static
    address 192.232.4.121
    netmask 255.255.255.252
    up ip link set dev eth3 up
```

### Kensuke

```bash
auto lo
iface lo inet loopback

# Link A14 ke Router Asuka
auto eth0
iface eth0 inet static
    address 192.232.4.122
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.121

# LAN A15 (Switch-Bunker / Sachiel)
auto eth1
iface eth1 inet static
    address 192.232.3.190
    netmask 255.255.255.192
    up ip link set dev eth1 up
```

### Ritsuko

```bash
auto lo
iface lo inet loopback

# Link A16 ke Router Asuka
auto eth0
iface eth0 inet static
    address 192.232.4.126
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.125

# LAN A17 (Switch-Lab / Entry-Plug, Dummy-Plug)
auto eth1
iface eth1 inet static
    address 192.232.4.38
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Kaji

```bash
auto lo
iface lo inet loopback

# Link A19 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.130
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.129

# LAN A20 (Switch-Intel / Spy)
auto eth1
iface eth1 inet static
    address 192.232.4.86
    netmask 255.255.255.252
    up ip link set dev eth1 up
```

### Misato

```bash
auto lo
iface lo inet loopback

# Link A21 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.134
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.133

# LAN A22 (Switch-Cage / Unit-01, Unit-02, Unit-00)
auto eth1
iface eth1 inet static
    address 192.232.4.54
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Shigeru

```bash
auto lo
iface lo inet loopback

# Link A23 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.137
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.138
    up ip route add 192.232.4.56/29 via 192.232.4.142

# LAN A26 (Switch-Monolith / Zeruel, Armisael)
auto eth1
iface eth1 inet static
    address 192.232.4.75
    netmask 255.255.255.248
    up ip link set dev eth1 up

# Link A24 ke Router Makoto
auto eth2
iface eth2 inet static
    address 192.232.4.141
    netmask 255.255.255.252
    up ip link set dev eth2 up
```

### Makoto

```bash
auto lo
iface lo inet loopback

# Link A24 ke Router Shigeru
auto eth0
iface eth0 inet static
    address 192.232.4.142
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.141

# LAN A25 (Switch-Radar / Radar-Array)
auto eth1
iface eth1 inet static
    address 192.232.4.62
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Toji

```bash
auto lo
iface lo inet loopback

# Link A28 ke Router Fuyutsuki
auto eth0
iface eth0 inet static
    address 192.232.4.150
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.149

# LAN A29 (Switch-Dogma / Lilith, Adam)
auto eth1
iface eth1 inet static
    address 192.232.4.67
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Fuyutsuki

```bash
auto lo
iface lo inet loopback

# Link A27 ke Router Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.145
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.146
    up ip route add 192.232.4.64/29 via 192.232.4.150
    up ip route add 192.232.3.192/27 via 192.232.4.153

# LAN A32 (Switch-Terminal / Magi-Casper, Magi-Balthasar, Magi-Melchior)
auto eth1
iface eth1 inet static
    address 192.232.4.46
    netmask 255.255.255.248
    up ip link set dev eth1 up

# Link A30 ke Router Maya
auto eth2
iface eth2 inet static
    address 192.232.4.154
    netmask 255.255.255.252
    up ip link set dev eth2 up

# Link A28 ke Router Toji
auto eth3
iface eth3 inet static
    address 192.232.4.149
    netmask 255.255.255.252
    up ip link set dev eth3 up
```

### Maya

```bash
auto lo
iface lo inet loopback

# Link A30 ke Router Fuyutsuki
auto eth0
iface eth0 inet static
    address 192.232.4.153
    netmask 255.255.255.252
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up ip route add default via 192.232.4.154

# LAN A31 (Switch-Medic / Pen-Pen, Medic-Bay)
auto eth1
iface eth1 inet static
    address 192.232.3.222
    netmask 255.255.255.224
    up ip link set dev eth1 up
```

### Verifikasi Koneksi

Jalankan ping ke router lain dengan menggunakan `ping <IP_ADDRESS>`.

## Pemberian IP dan Gateway sementara

Karena IP akan diberikan secara sementara, maka semua ini dijalankan di terminal dan TIDAK dimasukkan ke konfigurasi.

### Pada Armisael

```bash
ip addr add 192.232.4.73/29 dev eth0
ip link set dev eth0 up
ip route add default via 192.232.4.75
```

### Pada Lilith

```bash
ip addr add 192.232.4.66/29 dev eth0
ip link set dev eth0 up
ip route add default via 192.232.4.67
```

### Pada Sachiel

```bash
ip addr add 192.232.3.129/26 dev eth0
ip link set dev eth0 up
ip route add default via 192.232.3.190
```

### Pada Com-Net

```bash
ip addr add 192.232.2.1/24 dev eth0
ip link set dev eth0 up
ip route add default via 192.232.2.254
```

Selanjutnya, perlu juga untuk menambahkan jalur agar router lain dapat terhubung.

### Router Gendou

```bash
# Rute ke Comm-Net (LAN A12) via Router Hikari
ip route add 192.232.2.0/24 via 192.232.4.110

# Rute ke Sachiel (LAN A15) via Router Asuka
ip route add 192.232.3.128/26 via 192.232.4.118

# Rute ke Armisael (LAN A26) via Router Shigeru
ip route add 192.232.4.72/29 via 192.232.4.137

# Rute ke Lilith (LAN A29) via Router Fuyutsuki
ip route add 192.232.4.64/29 via 192.232.4.145
```

### Router Hikari

```bash
# Default route naik ke Gendou
ip route add default via 192.232.4.109
```

### Router Asuka

```bash
# Default route naik ke Gendou
ip route add default via 192.232.4.117

# Rute turun ke LAN Sachiel via Router Kensuke
ip route add 192.232.3.128/26 via 192.232.4.122
```

### Router Kensuke

```bash
# Default route naik ke Asuka
ip route add default via 192.232.4.121
```

### Router Shigeru

```bash
# Default route naik ke Gendou
ip route add default via 192.232.4.138
```

### Router Fuyutsuki

```bash
# Default route naik ke Gendou
ip route add default via 192.232.4.146

# Rute turun ke LAN Lilith via Router Toji
ip route add 192.232.4.64/29 via 192.232.4.150
```

### Router Toji

```bash
# Default route naik ke Fuyutsuki
ip route add default via 192.232.4.149
```
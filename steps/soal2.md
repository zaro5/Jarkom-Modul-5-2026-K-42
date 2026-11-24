# Soal 2

## Konfigurasi per Router

### Gendou

```bash
auto lo
iface lo inet loopback

# Interface ke NAT1 (DHCP + aktifkan IP forwarding)
auto eth0
iface eth0 inet dhcp
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# Link A33 ke Switch-Cmd / Tokyo3-Core
auto eth1
iface eth1 inet static
    address 192.232.4.106
    netmask 255.255.255.252
    up ip link set dev eth1 up

# Link A27 ke Router Fuyutsuki
auto eth2
iface eth2 inet static
    address 192.232.4.161
    netmask 255.255.255.252
    up ip link set dev eth2 up
    
# Link A23 ke Router Shigeru
auto eth3
iface eth3 inet static
    address 192.232.4.153
    netmask 255.255.255.252
    up ip link set dev eth3 up
    
# Link A21 ke Router Misato
auto eth4
iface eth4 inet static
    address 192.232.4.149
    netmask 255.255.255.252
    up ip link set dev eth4 up
    
# Link A19 ke Router Kaji
auto eth5
iface eth5 inet static
    address 192.232.4.145
    netmask 255.255.255.252
    up ip link set dev eth5 up
    
# Link A13 ke Router Asuka
auto eth6
iface eth6 inet static
    address 192.232.4.134
    netmask 255.255.255.252
    up ip link set dev eth6 up
    
# Link A9 ke Router Hikari
auto eth7
iface eth7 inet static
    address 192.232.4.125
    netmask 255.255.255.252
    up ip link set dev eth7 up
    
# Link A1 ke Router Yui
auto eth8
iface eth8 inet static
    address 192.232.4.109
    netmask 255.255.255.252
    up ip link set dev eth8 up
    
```

### Yui

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.110
    netmask 255.255.255.252
    gateway 192.232.4.109
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A8 (Switch-Hangar / Hangar-Crew)
auto eth1
iface eth1 inet static
    address 192.232.3.126
    netmask 255.255.255.128
    up ip link set dev eth1 up

# Link A6 ke Mari
auto eth2
iface eth2 inet static
    address 192.232.4.121
    netmask 255.255.255.252
    up ip link set dev eth2 up
    up ip route add 192.232.4.32/28 via 192.232.4.122

# Link A4 ke Rei
auto eth3
iface eth3 inet static
    address 192.232.4.117
    netmask 255.255.255.252
    up ip link set dev eth3 up
    up ip route add 192.232.0.0/23 via 192.232.4.118

# Link A2 ke Shinji
auto eth4
iface eth4 inet static
    address 192.232.4.113
    netmask 255.255.255.252
    up ip link set dev eth4 up
    up ip route add 192.232.4.0/27 via 192.232.4.114
```

### Rei

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.118
    netmask 255.255.255.252
    gateway 192.232.4.117
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

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

auto eth0
iface eth0 inet static
    address 192.232.4.114
    netmask 255.255.255.252
    gateway 192.232.4.113
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A3 (Switch-Garden / Garden-Staff)
auto eth1
iface eth1 inet static
    address 192.232.4.30
    netmask 255.255.255.224
    up ip link set dev eth1 up
```

### Mari

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.122
    netmask 255.255.255.252
    gateway 192.232.4.121
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A7 (Switch-Dock / Dock-Crew)
auto eth1
iface eth1 inet static
    address 192.232.4.46
    netmask 255.255.255.240
    up ip link set dev eth1 up
```

### Hikari

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.126
    netmask 255.255.255.252
    gateway 192.232.4.125
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A12 (Switch-Comm / Comm-Net)
auto eth1
iface eth1 inet static
    address 192.232.2.254
    netmask 255.255.255.0
    up ip link set dev eth1 up

# Link A10 ke Kaworu
auto eth2
iface eth2 inet static
    address 192.232.4.129
    netmask 255.255.255.252
    up ip link set dev eth2 up
    
```

### Kaworu

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.130
    netmask 255.255.255.252
    gateway 192.232.4.129
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A11 (Switch-Hangar / Hangar-Crew)
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

auto eth0
iface eth0 inet static
    address 192.232.4.133
    netmask 255.255.255.252
    gateway 192.232.4.134
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# Link A14 ke Kensuke
auto eth1
iface eth1 inet static
    address 192.232.4.98
    netmask 255.255.255.252
    up ip link set dev eth1 up
    
# Link A16 ke Ritsuko
auto eth2
iface eth2 inet static
    address 192.232.4.141
    netmask 255.255.255.252
    up ip link set dev eth2 up
    
# Link A18 ke Archive-Vault
auto eth3
iface eth3 inet static
    address 192.232.4.137
    netmask 255.255.255.252
    up ip link set dev eth3 up
```

### Kensuke

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.138
    netmask 255.255.255.252
    gateway 192.232.4.137
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

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

auto eth0
iface eth0 inet static
    address 192.232.4.142
    netmask 255.255.255.252
    gateway 192.232.4.141
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A17 (Switch-Lab / Entry-Plug)
auto eth1
iface eth1 inet static
    address 192.232.4.54
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Kaji

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.146
    netmask 255.255.255.252
    gateway 192.232.4.145
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# Link A20 ke Spy
auto eth1
iface eth1 inet static
    address 192.232.4.102
    netmask 255.255.255.252
    up ip link set dev eth1 up
```

### Misato

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.150
    netmask 255.255.255.252
    gateway 192.232.4.149
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A22 (Switch-Cage / Unit-01, Unit-02, Unit-00)
auto eth1
iface eth1 inet static
    address 192.232.4.70
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Shigeru

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.154
    netmask 255.255.255.252
    gateway 192.232.4.153
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A26 (Switch-Monolith / Zeruel & Armisael)
auto eth1
iface eth1 inet static
    address 192.232.4.94
    netmask 255.255.255.248
    up ip link set dev eth1 up

# Link A24 ke Makoto
auto eth2
iface eth2 inet static
    address 192.232.4.157
    netmask 255.255.255.252
    up ip link set dev eth2 up
```

### Makoto

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.158
    netmask 255.255.255.252
    gateway 192.232.4.157
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A25 (Switch-Radar / Radar-Array)
auto eth1
iface eth1 inet static
    address 192.232.4.78
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Toji

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.166
    netmask 255.255.255.252
    gateway 192.232.4.165
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A29 (Switch-Dogma / Lilith)
auto eth1
iface eth1 inet static
    address 192.232.4.86
    netmask 255.255.255.248
    up ip link set dev eth1 up
```

### Fuyutsuki

```bash
auto lo
iface lo inet loopback

# Link A27 ke Gendou
auto eth0
iface eth0 inet static
    address 192.232.4.162
    netmask 255.255.255.252
    gateway 192.232.4.161
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A32 (Switch-Terminal / Magi)
auto eth1
iface eth1 inet static
    address 192.232.4.62
    netmask 255.255.255.248
    up ip link set dev eth1 up

# Link A28 ke Toji
auto eth2
iface eth2 inet static
    address 192.232.4.169
    netmask 255.255.255.252
    up ip link set dev eth2 up

# Link A30 ke Maya
auto eth3
iface eth3 inet static
    address 192.232.4.165
    netmask 255.255.255.252
    up ip link set dev eth3 up
```

### Maya

```bash
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 192.232.4.170
    netmask 255.255.255.252
    gateway 192.232.4.169
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1

# LAN A31 (Switch-Medic / Pen-Pen)
auto eth1
iface eth1 inet static
    address 192.232.3.222
    netmask 255.255.255.224
    up ip link set dev eth1 up
```

## Verifikasi Koneksi

Jalankan perintah `ip -br a` di setiap router.

```bash
ip -br a
```

Kemudian jalankan ping ke router lain dengan menggunakan `ping <IP_ADDRESS>`.

# Soal 4

## Konfigurasi

Pada soal ini, diharuskan masuk ke router dan node agar bisa memasukkan konfigurasi baru. 

### Pada Gendou

```bash
ip link set dev eth0 up
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 192.232.0.0/21 -o eth0 -j MASQUERADE
```

### Pada Armisael

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
```

### Pada Lilith

```bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
```

### Membuat Konfigurasi Permanen

Apabila ingin menjadikan konfigurasi pada `Gendou` menjadi permanen, maka masuk ke `/etc/network/interfaces/` milik Gendou.

```bash
auto eth0
iface eth0 inet dhcp
    up ip link set dev eth0 up
    up sysctl -w net.ipv4.ip_forward=1
    up iptables -t nat -A POSTROUTING -s 192.232.0.0/21 -o eth0 -j MASQUERADE
```

## Pengujian

Untuk menguji hasil konfigurasi, masuk ke masing-masing node. `Armiseal` dan `Lilith`, kemudian jalankan command berikut:

```bash
ping -c 4 8.8.8.8
ping -c 4 deb.debian.org
```

Kemudian lihat counter rule NAT pada Gendou.

```bash
iptables -t nat -L POSTROUTING -v -n
```

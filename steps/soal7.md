# Soal 7

## Konfigurasi

Router yang akan berhubungan dengan soal 7 adalah `Toji` dan `Fuyutsuki`. Lakukan konfigurasi dibawah ini agar router dapat terhubung.

### Pada Toji

```bash
sysctl -w net.ipv4.ip_forward=1
ip route add default via 192.232.4.149 2>/dev/null
```

### Pada Fuyutsuki

```bash
sysctl -w net.ipv4.ip_forward=1
# Rute turun ke LAN Lilith via Toji
ip route add 192.232.4.64/29 via 192.232.4.150 2>/dev/null
# Default route naik ke Gendou
ip route add default via 192.232.4.146 2>/dev/null
```

Selanjutnya, pastikan pula node `Magi-Balthasar` terhubung ke `Fuyutsuki`.

### Magi-Balthasar

```bash
ip route add default via 192.232.4.46 2>/dev/null
```

### Pada Lilith

```bash
ip route add default via 192.232.4.67 2>/dev/null
```

## Pengujian

### Uji Coba Listener

Jalankan script yang telah dibuat pada node Balthasar, Casper, dan Melchior. Apabila listener telah berjalan, kirimkan pesan dari node `Lilith` dan cek log-nya.

#### Kirimkan ke Casper

```bash
echo "Pesan dari Lilith ke Casper Port 5000" | nc -n 192.232.4.57 5000
```

#### Kirimkan ke Balthasar

```bash
echo "Pesan dari Lilith ke Balthasar Port 5000" | nc -n 192.232.4.58 5000
echo "Pesan dari Lilith ke Balthasar Port 5001" | nc -n 192.232.4.58 5001
```

#### Kirimkan ke Melchior

```bash
echo "Pesan dari Lilith ke Melchior Port 5000" | nc -n 192.232.4.59 5000
```

Apabila sudah, lakukan pengecekan dari masing-masing node `Magi` dan matikan listener apabila telah selesai.

```bash
pkill -f "melchior.sh"
pkill -f "balthasar.sh"
pkill -f "casper.sh"

kill 409 2>/dev/null || killall nc 2>/dev/null
```

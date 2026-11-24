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

### Tahapan awal

Sebelum melakukan netcat, lakukan pengecekan apakah Lilith terhubung ke Magi-Balthasar. 

```bash
ping -c 4 192.232.4.42
```

### Uji Coba Listener

#### Uji Coba Magi-Balthasar

Magi Balthasar harus menjalankan nc agar dapat mendengarkan dari port yang telah ditentukan (5000 dan 5001)

```bash
killall nc 2>/dev/null
nc -l -n -v -p 5000
```

Kemudian kirimkan pesan dari node `Lilith`.

```bash
echo "Halo Balthasar dari Lilith" | nc -n 192.232.4.42 5000
```

**Catatan**
Lakukan hal yang sama untuk port `5001`

#### Uji Coba Magi-Casper

Magi-Casper harus menjalankan nc agar dapat mendengarkan dari port yang telah ditentukan (5000)

```bash
killall nc 2>/dev/null
nc -l -n -v -p 5000
```

Kemudian kirimkan pesan dari node `Lilith`.

```bash
echo "Halo Casper dari Lilith" | nc -n 192.232.4.41 5000
```

#### Uji Coba Magi-Melchior

Magi-Melchior harus menjalankan nc agar dapat mendengarkan dari port yang telah ditentukan (5000)

```bash
killall nc 2>/dev/null
nc -l -n -v -p 5000
```

Kemudian kirimkan pesan dari node `Lilith`.

```bash
echo "Halo Melchior dari Lilith" | nc -n 192.232.4.43 5000
```
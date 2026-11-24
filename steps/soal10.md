# Soal 10

## Pengecekan

### Node

Setelah break_nat.sh dijalankan, lakukan

### Router Misato

Pada router `Missato`, lakukan pengeecekan dengan iptables. Untuk menampilkan seluruh aturan di rantai `POSTROUTING` pada tabel `nat`. Dengan perintah inin juga dapat mengetahui rule SNAT ke 172.31.99.1 berada di baris berapa  .

```bash
iptables -t nat -L POSTROUTING -n -v --line-numbers
```

Kemudian hapus rule SNAT-nya.

```bash
iptables -t nat -D POSTROUTING 1
```

Verifikasi ulang dengan `iptables` yang telah dilakukan tadi.

### Router Gendou

Jalankan pengujian/pengecekan awal di Gendo.

```bash
iptables -t nat -L POSTROUTING -n -v --line-numbers
```

Kemudian hapus seuai dengan baris yang dikeluarkan oleh `iptables`.

```bash
iptables -t nat -D POSTROUTING 1

# Pastikan pula NAT yang keluar via WAN Gendo tetap aktif
iptables -t nat -A POSTROUTING -s 192.232.0.0/21 -o eth0 -j MASQUERADE 2>/dev/null || true
```

## Pengujian

Lakukan pengujian dari node `Unit-00`, `Unit-01`, dan `Unit-02`.

```bash
ping -c 4 8.8.8.8
```
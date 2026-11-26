# Soal 20

## Pendahuluan
Pilih tiga node sendiri, minimal satu router. Di tiap node, simpan dulu rule dengan iptables-save ke /root/<nama>.rules. Lalu hapus semua rule iptables termasuk tabel nat, dan hapus rute yang kamu tambahkan sendiri. Pulihkan rule dengan iptables-restore, dan pulihkan rute dengan /root/<nama>.sh. Lakukan pemulihan itu dua kali berturut-turut. Hasilnya harus sama: rule dan rute tidak dobel, dan node berfungsi seperti semula. Buktikan jumlah baris iptables -S dan iptables -t nat -S sama setelah pemulihan pertama dan kedua. Buktikan juga node itu berfungsi lagi.

## Penyelesaian
Untuk soal ini, saya memilih menggunakan node Fuyutsuki, Shigeru, dan Casper.

Pertama, kita perlu menyimpam baselinenya yang dijalankan sekali untuk setiap node.
```
NAME=fuyutsuki

iptables-save > /root/$NAME.rules

{ echo '#!/bin/sh'; ip route show | grep -Ev 'proto (kernel|dhcp)' | sed 's/^/ip route replace /'; } > /root/$NAME.sh
chmod +x /root/$NAME.sh
cat /root/$NAME.sh

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=shigeru

iptables-save > /root/$NAME.rules

{ echo '#!/bin/sh'; ip route show | grep -Ev 'proto (kernel|dhcp)' | sed 's/^/ip route replace /'; } > /root/$NAME.sh
chmod +x /root/$NAME.sh
cat /root/$NAME.sh

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=casper

iptables-save > /root/$NAME.rules

{ echo '#!/bin/sh'; ip route show | grep -Ev 'proto (kernel|dhcp)' | sed 's/^/ip route replace /'; } > /root/$NAME.sh
chmod +x /root/$NAME.sh
cat /root/$NAME.sh

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

![alt text](/assets/20_baseline.png)

Terlihat dan tersimpan baseline untuk ketiga nodenya.

Berikut, kita melakukan penghancuran untuk ketiga nodenya.
```
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

ip route show | grep -Ev 'proto (kernel|dhcp)' | while read r; do ip route del $r; done

iptables -S
iptables -t nat -S
ip route
```

Untuk membuktikan kerusakan, kita bisa melakukan berikut

Dari Casper
```
ping -c 3 -W 2 192.232.4.89      # ke Zeruel
ping -c 3 -W 2 8.8.8.8
```

![alt text](/assets/20_rusak1.png)

Bisa terlihat bahwa networknya unreachable, selanjutnya

Dari Lilith
```
ping -c 3 -W 2 192.232.4.89      # ke Zeruel
```

Dari Armisael
```
ping -c 3 -W 2 8.8.8.8
ping -c 3 -W 2 192.232.4.81      # ke Lilith
```

Dari Zeruel
```
ping -c 3 -W 2 8.8.8.8
ping -c 3 -W 2 192.232.4.81
```

![alt text](/assets/20_rusak2.png)

Sekarang kita bisa melihat bahwa semuanya sudah benar-benar rusak.

Setelah perusakan, kita lakukan pemulihan pada setiap node dengan
```
NAME=fuyutsuki

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=shigeru

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=casper

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

![alt text](/assets/20_pemulihan.png)

Akhirnya kita bisa melihat bahwa semuanya sudah pulih dan kembali memiliki filter, nat, dan rute yang sama dengan baselinenya.

## Pembuktian

### Fuyutsuki
Untuk Fuyutsuki, dari Casper kita jalankan
```
echo "tes" | nc -w 3 192.232.4.89 9000
```

Ini harus muncul di log Pen-Pen, bukan Zeruel. Dan kita juga melakukan di Fuyutsuki
```
conntrack -L -p tcp --dport 9000
```

Untuk menunjukkan entri DNAT lagi

![alt text](/assets/20_fuyutsuki.png)
![alt text](/assets/20_conntrack.png)

Bisa terlihat listener dari Pen-Pen berhasil mendengar dari Casper dan kita bisa melihat conntracknya

### Shigeru
Untuk Shigeru, kita melakukan pembuktian ping di beberapa node

Di Casper harus berhasil
```
ping -c 3 -W 2 192.232.4.89
```

![alt text](/assets/20_pcasper.png)

Di Lilith harus gagal
```
ping -c 3 -W 2 192.232.4.89
```

![alt text](/assets/20_plilith.png)

Di Armisael semua harus gagal
```
ping -c 3 -W 2 8.8.8.8
ping -c 3 -W 2 192.232.4.81
ping -c 3 -W 2 192.232.4.89
```

![alt text](/assets/20_parmisael.png)

Dan terakhir di Zeruel, semua harus berhasil
```
ping -c 3 -W 2 8.8.8.8
ping -c 3 -W 2 192.232.4.81
```

![alt text](/assets/20_pzeruel.png)

### Casper
Untuk Casper, kita melakukan pembuktian ping di beberapa node lagi

Di Casper, semua harus berhasil
```
ping -c 3 -W 2 192.232.4.58
ping -c 3 -W 2 8.8.8.8
ping -c 3 -W 2 192.232.4.81
```

![alt text](/assets/20_pulihcasper.png)


Dan terakhir untuk semuanya, kita jalankan lagi pemulihan sekali lagi
```
NAME=fuyutsuki      # lalu shigeru, lalu casper

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
iptables -S; iptables -t nat -S

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=shigeru      # lalu shigeru, lalu casper

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
iptables -S; iptables -t nat -S

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```

```
NAME=casper     # lalu shigeru, lalu casper

echo "SEBELUM: filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
iptables -S; iptables -t nat -S

echo "=== PEMULIHAN 1 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"

echo "=== PEMULIHAN 2 ==="
iptables-restore < /root/$NAME.rules
/root/$NAME.sh
echo "filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) rute=$(ip route | wc -l)"
```
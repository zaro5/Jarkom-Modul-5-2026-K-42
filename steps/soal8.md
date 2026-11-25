# Soal 8

## Pengecekan pada Lilith

Agar dapat menjalankan Listener dan `Lilith`, `Pen-Pen` serta `Tokyo3-Core` berhasil terhubung, uji coba dengan `ping`.

```bash
# Jalankan pada Lilith
ping -c 2 192.232.3.193
ping -c 2 192.232.4.89
```

## Menjalankan Listener

### Jalankan Script

Jalankan script `penpen.sh` dan `tokyo.sh` yang sudah ada. Berikut penjelasannya.

### Pen-Pen

```bash
killall nc 2>/dev/null
while true; do
  printf "Welcome to Pen-Pen\n" | nc -l -n -p 80
done
```

Apabila ini sudah jalan pada node `Pen-Pen`, beralih ke node `Lilith` untuk mengirim pesan. Kirimkan pesan kosong pada `Pen-Pen`.

```bash
echo "" | nc -n -w 2 192.232.3.193 80
```

Uji coba berhasil apabila terminal mengembalikan pesan `Welcome to Pen-Pen`.

### Tokyo3

Hal yang sama dilakukan pada node `Tokyo3-Core`.

#### Untuk port 80

```bash
killall nc 2>/dev/null
while true; do
  printf "Welcome to Tokyo3-Core\n" | nc -l -n -p 80
done
```

#### Untuk port 8080

```bash
killall nc 2>/dev/null
while true; do
  printf "syifa imutz\n" | nc -l -n -p 8080
done
```

Setelah berhasil dilakukan, masuk lagi ke node `Lilith` dan kirimkan pesan kosong.

```bash
echo "" | nc -n -w 2 192.232.4.106 80
echo "" | nc -n -w 2 192.232.4.106 8080
```

### Pada Port yang Dilarang

Uji coba pada port 22

```bash
nc -n -v -w 2 192.232.4.106 22
```

# Soal 7

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

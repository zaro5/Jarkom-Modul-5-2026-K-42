# Soal 7

## Apa yang teradi?

Pada soal ini diminta untuk mengaktifkan listener (daemon) pada node `Casper`, `Balthasar`, dan `Melchior`.

### Uji Coba Listener

Jalankan script yang telah dibuat pada node Balthasar, Casper, dan Melchior. Apabila listener telah berjalan, kirimkan pesan dari node `Lilith` dan cek log-nya.

#### Kirimkan ke Casper

```bash
echo "Pesan dari Lilith ke Casper Port 5000" | nc -n 192.232.4.57 5000
```

![alt text](../assets/7_casper-terkirim.png)

#### Kirimkan ke Balthasar

```bash
echo "Pesan dari Lilith ke Balthasar Port 5000" | nc -n 192.232.4.58 5000
echo "Pesan dari Lilith ke Balthasar Port 5001" | nc -n 192.232.4.58 5001
```

![alt text](../assets/7_balthasar-terkirim.png)

#### Kirimkan ke Melchior

```bash
echo "Pesan dari Lilith ke Melchior Port 5000" | nc -n 192.232.4.59 5000
```

![alt text](../assets/7_melchisior-terkirim.png)

Apabila sudah, lakukan pengecekan dari masing-masing node `Magi` dan matikan listener apabila telah selesai.

```bash
pkill -f "melchior.sh"
kill 409 2>/dev/null || killall nc 2>/dev/null
```

```bash
pkill -f "balthasar.sh"
kill 409 2>/dev/null || killall nc 2>/dev/null
```

```bash
pkill -f "casper.sh"
kill 409 2>/dev/null || killall nc 2>/dev/null
```
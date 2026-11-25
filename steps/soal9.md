# Soal 9

## Pengecekan

Setelah script dijalankan, jalankan tes ping dari node `Lilith`.

```bash
# Jalankan ping ke Armisael
ping -c 4 192.232.4.73
```

Kemudian jalankan pula tes ping dari node `Armisael`.

```bash
ping -c 4 192.232.4.94
```

## Perbaikan

```bash
# 1. Hapus Policy Routing (Rule 90) & Flush Tabel 100
ip rule del iif eth1 lookup 100 2>/dev/null
ip rule del priority 90 2>/dev/null
ip route flush table 100 2>/dev/null

# 2. Hapus Rute Blackhole ke Subnet LAN Armisael
ip route del blackhole 192.232.4.72/29 2>/dev/null

# 3. Kembalikan Default Route Shigeru ke Induk (Gendou)
# Catatan: IP Gateway Gendou pada link ke Shigeru adalah 192.232.4.138 (Link A19)
ip route replace default via 192.232.4.138

# 4. Pastikan Rute ke Subnet Makoto (LAN A25: 192.232.4.56/29) Mengarah ke IP Makoto (.142)
ip route add 192.232.4.56/29 via 192.232.4.142 2>/dev/null

# 5. Aktifkan Kembali IP Forwarding
sysctl -w net.ipv4.ip_forward=1
```

## Penjelasan

- Mengapa Armisael masih bisa ping ke gateway-nya sendiri?
    Karena link lokal antara Armisael dan interface LAN Shigeru berada dalam satu segmen, sehingga tidak membutuhkan IP forwarding maupun tabel routing eksternal.

- Mengapa Lilith tidak mendapat balasan dari Armisael?
    Paket dari Lilith menuju Armisael terhenti di Shigeru karena aturan `blackhole` membuang paket tersebut, ditambah aturan `ip rule` dan matinya `ip_forward` pada Shigeru yang memutus komunikasi dua arah.

#!/bin/sh
# Hentikan listener lama milik penpen.sh jika ada
pkill -f "Welcome to Pen-Pen" 2>/dev/null
killall nc 2>/dev/null

# Jalankan listener port 80 di background
while true; do
  printf "Welcome to Pen-Pen\n" | nc -l -n -p 80
done &

echo "Pen-Pen listener aktif di port 80"
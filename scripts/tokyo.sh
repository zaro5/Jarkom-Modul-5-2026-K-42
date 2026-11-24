#!/bin/sh
# Hentikan listener lama milik tokyo3.sh jika ada
pkill -f "Welcome to Tokyo3-Core" 2>/dev/null
pkill -f "syifa imutz" 2>/dev/null
killall nc 2>/dev/null

# Listener Port 80
while true; do
  printf "Welcome to Tokyo3-Core\n" | nc -l -n -p 80
done &

# Listener Port 8080
while true; do
  printf "syifa imutz\n" | nc -l -n -p 8080
done &

echo "Tokyo3-Core listener aktif di port 80 dan 8080"
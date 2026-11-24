#!/bin/sh
apt-get update
apt-get install -y iptables netcat-traditional

# Jalankan listener netcat di background/foreground untuk port 80 & 5000
nc -l -p 80 &
nc -l -p 5000 &  
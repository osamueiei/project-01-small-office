#!/usr/bin/env bash
# Project 1 - Web-Server (webtop-u22 in GNS3)
# Static IP 192.168.10.10/26, gateway R1 e0/1 (192.168.10.1)
set -e
sudo ip addr flush dev eth0
sudo ip addr add 192.168.10.10/26 dev eth0
sudo ip link set eth0 up
sudo ip route replace default via 192.168.10.1
echo "nameserver 192.168.10.1" | sudo tee /etc/resolv.conf >/dev/null

mkdir -p ~/web
echo "Project 1 web server" > ~/web/index.html
cd ~/web
# Serves http://www.lab.local (DNS record lives on R1)
sudo python3 -m http.server 80

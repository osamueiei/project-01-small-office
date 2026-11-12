#!/usr/bin/env bash
# Project 1 - Staff-Kali (kali-linux in GNS3)
# Gets its address from R1 DHCP pool STAFF, then runs the client-side tests.
sudo dhclient -r eth0 2>/dev/null || true
sudo dhclient eth0
ip addr show eth0
ip route

echo "== Test 2: gateway =="
ping -c 3 192.168.10.1
echo "== Test 4: DNS =="
nslookup www.lab.local 192.168.10.1
echo "== Test 5: Internet (via NAT) =="
ping -c 3 198.51.100.10
traceroute -n 198.51.100.10
echo "== Test 8: Web =="
curl -s http://www.lab.local
echo "== Test 7: Remote management (manual) =="
echo "Run: telnet 192.168.10.1   and log in as admin"

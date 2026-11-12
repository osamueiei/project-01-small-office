# Test Plan — Project 1

Fill the **Result** column with PASS/FAIL and save a screenshot or output file in `evidence/` for each test.

| # | Test | Where | Command | Expected | Result | Evidence |
|---|---|---|---|---|---|---|
| 1 | DHCP lease | Staff-PC, Guest-PC / R1 | `dhcp`, `show ip` / `show ip dhcp binding` | Staff gets .11+, Guest gets .71+ | | `evidence/01-dhcp-binding.txt` |
| 2 | Gateway reachability | Staff-PC, Guest-PC | `ping 192.168.10.1` / `ping 192.168.10.65` | Replies | | `evidence/02-gateway.txt` |
| 3 | Inter-subnet | Guest-PC | `ping 192.168.10.10` | Replies (no ACL yet — blocked in Project 2) | | `evidence/03-inter-subnet.txt` |
| 4 | DNS | Staff-Kali | `nslookup www.lab.local` | 192.168.10.10 from server 192.168.10.1 | | `evidence/04-dns.txt` |
| 5 | Internet access | Staff-Kali, Guest-PC | `ping 198.51.100.10`, `traceroute 198.51.100.10` | Replies via 192.168.10.1 → 203.0.113.1 | | `evidence/05-internet.txt` |
| 6 | NAT translation | R1 | `show ip nat translations` (right after a ping) | inside local 192.168.10.x → inside global 203.0.113.2 | | `evidence/06-nat-translations.txt` |
| 7 | Remote management | Staff-Kali | `telnet 192.168.10.1` | Prompts for local user `admin` | | `evidence/07-telnet.png` |
| 8 | Web service | Staff-Kali | `curl http://www.lab.local` | `Project 1 web server` | | `evidence/08-web.txt` |

## Packet captures

| Capture | Link | Filter | What it proves | File |
|---|---|---|---|---|
| DHCP DORA | R1 e0/1 ↔ SW-STAFF | `dhcp` | Discover, Offer, Request, Ack | `evidence/dhcp-dora.pcapng` |
| NAT source | R1 e0/0 ↔ ISP | `icmp` | Source IP is 203.0.113.2, not 192.168.10.x | `evidence/nat-wan.pcapng` |

## Fault-injection exercises

| Fault | How | Symptom | Fix |
|---|---|---|---|
| Missing NAT inside | `interface e0/2` → `no ip nat inside` | Guest cannot reach 198.51.100.10, Staff still can | Re-add `ip nat inside` |
| Wrong DHCP gateway | `ip dhcp pool GUEST` → `default-router 192.168.10.66` | Guest gets an IP but cannot leave its subnet | Set `default-router 192.168.10.65`, renew lease |

# Networking

## Manual MTU detection

Detect MTU by sending non-fragmentable ICMP packets. Restore MTU to a default value before testing.

```
ping -c 3 -M do -s 1500 10.0.0.13
```

Set MTU

```
ip link set dev eth0 mtu 1500
```

## Host discovery

```
nmap -sP 192.168.88.1/24
```

- [How to find live hosts on my network?](https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network)

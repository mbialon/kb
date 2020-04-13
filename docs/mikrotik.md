# MikroTik

## Open port

```
/ip firewall nat add chain=dstnat dst-port=1234 action=dst-nat protocol=tcp to-address=192.168.1.1 to-port=1234
```

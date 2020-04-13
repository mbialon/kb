# iostat

## Run iostat 10 times every 5 seconds

```
iostat 5 10
```

### CPU

*%idle*

Show the percentage of time that the CPU or CPUs were idle and the system did not have an outstanding disk I/O request.

*%iowait*

Show the percentage of time that the CPU or CPUs were idle during which the system had an outstanding disk I/O request.

### DEVICE

*%util*

Percentage of CPU time during which I/O requests were issued to the device (bandwidth utilization for the device). Device saturation occurs when this value is close to 100%.

http://linux.die.net/man/1/iostat

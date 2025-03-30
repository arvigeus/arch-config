# Grub

## CPU Mitigations

To check CPU vulnerabilities (while filtering out `Not affected` entries):

```sh
grep . /sys/devices/system/cpu/vulnerabilities/* | grep -v ":Not affected"

```

If mitigations are active, expect entries containing `Mitigation`. If a vulnerability is still present, it will be marked as `Vulnerable`.

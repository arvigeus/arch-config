# Pacman

## "Rollback" packages

You can specify date, and "rollback" all packages to the state of Arch repos at that time. No dependencies trouble with rollbacking nvidia, kernel, etc.

```conf
#/etc/pacman.conf

[core]
Server=https://archive.archlinux.org/repos/2025/02/25/$repo/os/$arch
#Include = /etc/pacman.d/mirrorlist

[extra]
Server=https://archive.archlinux.org/repos/2025/02/25/$repo/os/$arch
#Include = /etc/pacman.d/mirrorlist

[multilib]
Server=https://archive.archlinux.org/repos/2025/02/25/$repo/os/$arch
#Include = /etc/pacman.d/mirrorlist
```

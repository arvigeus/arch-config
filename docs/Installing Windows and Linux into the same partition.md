# [Installing Windows and Linux into the same partition](https://gist.github.com/motorailgun/cc2c573f253d0893f429a165b5f851ee)

## But WHY?

There was [a reddit post](https://www.reddit.com/r/archlinux/comments/qwsftq/arch_linux_on_ntfs3/) about installing Arch on NTFS3 partition. Since Windows and Linux doesn't have directories with same names under the `/`(`C:\`), I thought it's possible, and turned out it was actually possible.  
__If you are not familiar to Linux, for example you've searched on Google "how to dualboot Linux and Windos" or brbrbr... you mustn't try this. This is not practical.__

## Pre-requirements

- UEFI system
- Any Linux live-boot CD/DVD/USB... with Linux kernel newer than 5.15
- Windows installer USB

## How-to

1. Boot up Linux and create a EFI system partition. 1GB is enough (512MB may not be)
2. Boot up Windows and normally install it. You may need to choose "Custom: Install Windows only" option.
3. When finished, boot up Linux install USB and mount the NTFS partition Windows created. Note you need to specify `-t ntfs3` on `mount`.
4. Mount EFI partition and other needed ones (like swaps) and continue installing.
5. Don't forget to "Add `rootfstype=ntfs3` as kernel parameter"
6. Done!

## Known issues

- ldconfig crashes for me, using Arch.
- sometimes kernel panics on poweroff.
- the pioneer says "the system will break after a few boots".

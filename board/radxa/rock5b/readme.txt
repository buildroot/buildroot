RADXA ROCK 5B
==============
https://wiki.radxa.com/Rock5/hardware/5b

Build:
======
  $ make rock5b_defconfig
  $ make

Files created in output directory
=================================

output/images
.
├── Image
├── rk3588_bl31_v1.40.elf
├── rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.12.bin
├── rk3588-rock-5b.dtb
├── rootfs.ext2
├── rootfs.ext4
├── rootfs.tar
├── sdcard.img
├── u-boot.bin
└── u-boot-rockchip.bin

Creating bootable SD card:
==========================

Simply invoke (as root)

sudo dd if=output/images/sdcard.img of=/dev/sdX && sync

Where X is your SD card device.

Booting:
========

Serial console:
---------------
The Rock 5B has a 40-pin GPIO header. Its layout can be seen here:
https://wiki.radxa.com/Rock5/hardware/5b/gpio

The Uart pins are as follows:

pin 6:  gnd
pin 8:  tx
pin 10: rx

Baudrate for this board is 1500000.

Login:
------
Enter 'root' as login user, and the prompt is ready.

wiki link:
----------
https://forum.radxa.com/c/rock5

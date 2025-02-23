FriendlyARM NanoPi R3S
=======================
https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S

How to build
============
  $ make friendlyarm_nanopi_r3s_defconfig
  $ make

Files created in output directory
=================================

output/images
├── bl31.elf
├── genimage.cfg
├── Image
├── rk3566_ddr_1056MHz_v1.18.bin
├── rockchip
│   └── rk3566-nanopi-r3s.dtb
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rtl_nic
│   ├── ...
│   ├── rtl8168h-2.fw
│   └── ...
├── sdcard.img
├── u-boot.bin
└── u-boot-rockchip.bin

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M conv=fsync

Insert the micro SDcard in your Nanopi R3S and power it up.
The console is on the serial line, 1500000 8N1.

Intro
=====

This default configuration will allow you to start experimenting with the
buildroot environment for the Nanopi R2S. With the current configuration
it will bring-up the board, and allow access through the serial console.

Nanopi R2S link:
https://www.friendlyarm.com/index.php?route=product/product&path=69&product_id=282

This configuration uses ATF, U-Boot mainline and kernel mainline.

How to build
============

    $ make friendlyarm_nanopi_r2s_defconfig
    $ make

Note: you will need access to the internet to download the required
sources.

Files created in output directory
=================================

output/images

├── bl31.elf
├── boot.vfat
├── extlinux
├── idbloader.img
├── Image
├── rk3328-nanopi-r2s.dtb
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── u-boot.bin
└── u-boot.itb

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
  $ sudo sync

Insert the micro SDcard in your Nanopi R2S and power it up. The console
is on the serial line, 1500000 8N1.

Notes
=====

This configuration can also be used to drive the Friendlyarm Nanopi Neo3 board.

Lichee RV
===============

Lichee RV - Nezha CM is a compute module with modular design, equipped
with Allwinner D1 chip (based on T-Head XuanTie C906 core), 512MB DDR3 RAM.
It can boot from TF card or SD-NAND, uses two sets of M.2 b key 67 pin
connectors to route all IO, making it convient for wide use and easy to replace.

How to build
============

$ make sipeed_lichee_rv_defconfig
$ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Connect a TTL UART to the debug connector, insert the microSD card and
plug in a USB-C cable to the PWR connector to boot the system.

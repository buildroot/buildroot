Cubietech Cubieboard1
=====================

Cubieboard1 is the first generation Cubieboard from Cubietech.

Cubietech:
http://www.cubietech.com/product-detail/cubieboard1

Linux Sunxi Wiki:
https://linux-sunxi.org/Cubietech_Cubieboard

Building
--------

Configure and build with

  make cubieboard1_defconfig
  make

Flashing
--------

Flash the sdcard image onto a micro sdcard with

  dd if=output/images/sdcard.img of=/dev/sdX bs=1M conv=fsync

Running
-------

Connect a 3V3 serial interface to the serial header on the top side of the board
(between the USB jacks and the A10 chip). Then provide power to the board. The
interface uses 115200 baud.

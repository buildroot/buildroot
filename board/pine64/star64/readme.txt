Pine64 Star64
=============

The Star64 is a low-cost RISC-V 64-bit based platform, powered by a
Starfive JH7110 processor.

https://wiki.pine64.org/wiki/STAR64

How to build
============

$ make pine64_star64_defconfig
$ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX conv=fdatasync

Preparing the board
===================

Connect a TTL UART cable to pin 6 (GND), 8 (TX) and 10 (RX).

Insert your SD card.

Power-up the board using a 12V power supply.

Starfive VisionFive
===================

The VisionFive is a low-cost RISC-V 64-bit based platform, powered by a
Starfive JH7100 processor.

https://doc-en.rvspace.org/Doc_Center/visionfive.html

How to build
============

$ make visionfive_defconfig
$ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Preparing the board
===================

Connect a TTL UART cable to pin 6 (GND), 8 (TX) and 10 (RX).

Insert your SD card.

Power-up the board using an USB-C cable.

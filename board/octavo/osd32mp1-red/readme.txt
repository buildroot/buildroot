OSD32MP1-RED

Intro
=====

This configuration supports the OSD32MP1-RED platform:

  https://octavosystems.com/octavo_products/osd32mp1-red/

How to build
============

 $ make octavo_osd32mp1_red_defconfig
 $ make

How to write the microSD card
=============================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Boot the board
==============

 (1) Insert the microSD card in connector X5.

 (2) Plug an USB-SERIAL cable in the JP4 pin connector and run your serial
     communication program on /dev/ttySTM0.

 (3) Plug an USB-C cable in the J2 connector or use barrel power supply to
     power-up the board.

 (4) The system will start, with the console on UART.

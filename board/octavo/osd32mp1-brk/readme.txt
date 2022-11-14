OSD32MP1-BRK

Intro
=====

This configuration supports the OSD32MP1-BRK platform:

  https://octavosystems.com/octavo_products/osd32mp1-brk/

How to build
============

 $ make octavo_osd32mp1_brk_defconfig
 $ make

How to write the microSD card
=============================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Boot the board
==============

 (1) Insert the microSD card.

 (2) Plug an USB-SERIAL cable on the RX, TX and GND pins

 (3) Plug a micro-USB cable to power-up the board.

 (4) The system will start, with the console on UART.

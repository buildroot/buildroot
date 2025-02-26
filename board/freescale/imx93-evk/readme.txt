NXP i.MX93 EVK
==============

This is a Buildroot target for building an image for the imx93-evk
board using upstream components: TF-A, U-Boot and kernel.

How to build it
===============

Configure Buildroot and build it:

  $ make imx93-evk_defconfig
  $ make

Flashing the SD card image
==========================

Copy the sdcard.img file into the SD card:

  $ sudo dd if=output/images/sdcard.img of=<your-sd-device>; sync


Booting the board
=================

To boot your newly created system:

- Insert the SD card in the MicroSD slot of the board.
- Connect a serial to USB cable to the DBG port.
- Open a terminal on the ttyUSB2 port. For example: sudo picocom -b 115200 /dev/ttyUSB2
- Power on the board.

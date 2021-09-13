OMAP5432 uEVM
=============

This file documents the Buildroot support for the OMAP5432 uEVM[1], a
single-board computer development platform based on the Texas Instruments
OMAP5432 system on a chip (SoC).

How to build
============

  $ make uevm5432_defconfig
  $ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
  $ sync

Where /dev/sdX is the device node of your SD card (may be /dev/mmcblkX instead
depending on setup).

To boot from SD card, set the SYSBOOT switches S1 of your OMAP5432 uEVM to the
following position:

  ON   x   x
     x   x
     1 2 3 4

Insert the micro SDcard in your OMAP5432 uEVM, and power it up with the POWER
ON push button switch S3. The console is on the micro USB Debug UART, with
serial settings 115200 8N1. Refer also to the quick start guide[2].

[1]: https://svtronics.com/5432
[2]: https://www.ti.com/lit/ug/swcu131/swcu131.pdf

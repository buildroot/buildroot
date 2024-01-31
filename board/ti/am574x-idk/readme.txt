Texas Instuments AM574x IDK Test and Development Board

Description
===========

This configuration will build a basic image for the TI AM574x IDK
board: https://www.ti.com/tool/TMDSIDK574

How to build it
===============

Configure Buildroot:

    $ make am574x_idk_defconfig

Compile everything and build the USB flash drive image:

    $ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

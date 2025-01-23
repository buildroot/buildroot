Intro
=====

This default configuration will allow you to start experimenting with the
buildroot environment for the Radxa ROCK 4SE. With the current configuration
it will bring-up the board, and allow access through the serial console.

Radxa ROCK 4SE link:
https://radxa.com/products/rock4/4se/

Wiki link:
https://forum.radxa.com/c/rockpi4

GPIO connector pinout link:
https://wiki.radxa.com/Rockpi4/hardware/gpio

This configuration uses mainline ATF, U-Boot and kernel.

How to build
============

    $ make rock4se_defconfig
    $ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
  $ sudo sync

Insert the micro SDcard in your Radxa ROCK 4SE and power it up. The console
is available on UART2 on the GPIO connector, 1500000bps 8N1.

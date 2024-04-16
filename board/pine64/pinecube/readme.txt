Intro
=====

This directory contains a Buildroot configuration for building a
Pine64 PineCube.

Board homepage: https://www.pine64.org/cube/
Board wiki:     https://wiki.pine64.org/wiki/PineCube

How to build it
===============

  $ make pine64_pinecube_defconfig
  $ make

Note: you will need access to the internet to download the required
sources.

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX
  $ sudo sync

Insert the micro SDcard in your PineCube and power it up. The console
is on the serial port 2, 115200 8N1 (check Wiki for board pinout).

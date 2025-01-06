Intro
=====

This default configuration allows to start experimenting with the Buildroot
environment for the OrangePi 5 Plus board. Default configuration brings up
the board and allows access through the serial console.

Orangepi 5 Plus links:
- http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-5-plus-32GB.html

Upstream support
================

Linux v6.12.x provides a good starting point for experiments with this board.
All the basic features are already enabled including all the basic low-speed
I2C/SPI/PWM peripherals, ethernet networking, USB 2.0, PCIe, eMMC, Audio.
However advanced features such as graphics, display controllers, multimedia
codecs, camera and image processing units are still in work. For details and
updates check RK3588 hardware enablement status at Collabora gitlab, see:

- https://gitlab.collabora.com/hardware-enablement/rockchip-3588/notes-for-rockchip-3588/-/blob/main/mainline-status.md

Also keep an eye on RK3588 updates in kernel release announcements, e.g.
- https://kernelnewbies.org/Linux_6.12

How to Build
============
  $ make orangepi_5_plus_defconfig
  $ make

How to write the SD card
========================

Once the build process is finished there will be an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX status=progress
  $ sudo sync

Insert the micro SDcard into the Orangepi 5 Plus board and power it up.
The console is on the TTL Debug UART 3-pin connector which is located
near RTC connector and Type-C Power port.

Note that baudrate for this board is 1500000 8N1.

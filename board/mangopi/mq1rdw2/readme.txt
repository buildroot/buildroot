MangoPi MQ1RDW2
===============

MangoPi MQ1RDW2 is a tiny ARM Cortex-A7 based single board computer.
It's built around Allwinner T113-S3 dual core 1GHz CPU with integrated
128MB DDR3-1600 RAM.
Board features:
- USB-OTG Type-C socket
- USB-HOST Type-C socket
- 2x 18 pin GPIO headers
- TF card slot
- RTL8723DS WiFi module with ext. antenna connector
- 40 pin RGB FPC connector
- 6 pin CTP FPC connector
- 24 pin DVP FPC connector
- onboard mic
- onboard audio amplifier
- FEL,reset button

How to build
============

$ make mangopi_mq1rdw2_defconfig
$ make

Wifi
==========

Edit board/mangopi/mq1rdw2/overlay/etc/wpa_supplicant.conf or
/etc/wpa_supplicant.conf once connected to the board:

* Replace YOURSSID with your AP ssid
* Replace YOURPASSWD with your AP password

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Connect a TTL UART to the UART3 on P8 header (unpopulated), insert the microSD card and
plug in a USB-C cable to the OTG or HOST connector to boot the system.

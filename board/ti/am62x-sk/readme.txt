Texas Instuments SK-AM62 Test and Development Board

Description
===========

This configuration will build a complete image for the TI SK-AM62
board: https://www.ti.com/tool/SK-AM62.

How to Build
============

Select the default configuration for the target:

$ make ti_am62x_sk_defconfig

Optional: modify the configuration:

$ make menuconfig

Build:

$ make

To copy the resultimg output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the SK-AM62 board, and power it up through the
USB Type-C connector. The system should come up. You can use a
micro-USB cable to connect to the connector labeled UART to
communicate with the board.

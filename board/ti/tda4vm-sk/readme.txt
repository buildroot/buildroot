Texas Instruments SK-TDA4VM Test and Development Board

Description
===========

This configuration will build a complete image for the TI SK-TDA4VM
board: https://www.ti.com/tool/SK-TDA4VM

How to Build
============

Select the default configuration for the target:

$ make ti_tda4vm_sk_defconfig

Optional: modify the configuration:

$ make menuconfig

Build:

$ make

To copy the resultimg output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the SK-TDA4VM board, and power it up through the
USB Type-C connector. The system should come up. You can use a
micro-USB cable to connect to the connector labeled UART to
communicate with the board.

User's guide : https://www.ti.com/lit/ug/spruj21e/spruj21e.pdf

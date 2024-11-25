BeagleBoard.org BeagleBone AI-64 Development Board

Description
===========

This configuration will build a basic image for the BeagleBoard.org
BeagleBone AI-64. For more details about the board, visit:

https://www.beagleboard.org/boards/beaglebone-ai-64

How to Build
============

Select the default configuration for the target:

$ make beagleboneai64_defconfig

Optional: modify the configuration:

$ make menuconfig

Build:

$ make

To copy the resultimg output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the BeagleBone AI-64 board, and power it up
through the USB Type-C connector. The system should come up (make sure
to boot from the SD card not from the eMMC). You can use a USB to
serial adapter to connect to the connector labeled UART0 (J3) to
communicate with the board.

https://docs.beagleboard.org/latest/boards/beaglebone/ai-64/02-quick-start.html

BeagleBoard.org BeagleY-AI Development Board

Description
===========

This configuration will build a basic image for the BeagleBoard.org
BeagleY-AI. For more details about the board, visit:

https://www.beagleboard.org/boards/beagley-ai

How to Build
============

Select the default configuration for the target:

$ make beagley_ai_defconfig

Optional: modify the configuration:

$ make menuconfig

Build:

$ make

To copy the resulting output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the BeagleY-AI board, and power it up
through the USB Type-C connector. The system should come up.
You can use a USB to serial adapter to connect to the connector
labeled UART0 (J13) to communicate with the board.

https://docs.beagle.cc/boards/beagley/ai/02-quick-start.html

STM32MP157C-Odyssey

Intro
=====

This configuration supports the STM32MP157C-Odyssey platform:

  https://wiki.seeedstudio.com/ODYSSEY-STM32MP157C/

How to build
============

 $ make stm32mp157c_odyssey_defconfig
 $ make

How to write the microSD card
=============================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Boot the board
==============

 (1) Insert the microSD card in connector J21.

 (2) Connect to the UART connector J24 (located next the the DC jack
     J24 and the battery connector J20) and run your serial communication
     program on /dev/ttyACM0.

 (3) Plug a USB-C cable in J6 or a center-positive 12V jack into J17
     to power-up the board.

 (4) The system will start, with the console on UART.

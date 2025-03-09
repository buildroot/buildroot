STM32MP135F Discovery Kit

Intro
=====

This configuration supports the STM32MP135F Discovery Kit (DK)
platform:

  https://www.st.com/en/evaluation-tools/stm32mp135f-dk.html

How to build
============

 $ make stm32mp135f_dk_defconfig
 $ make

How to write the microSD card
=============================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Boot the board
==============

 (1) Insert the microSD card in connector CN3

 (2) Plug a micro-USB cable in connector CN10 and run your serial
     communication program on /dev/ttyACM0.

 (3) Plug a USB-C cable in CN12 to power-up the board.

 (4) The system will start, with the console on UART.

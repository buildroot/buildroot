Starfive VisionFive2
====================

The VisionFive2 is a low-cost RISC-V 64-bit based platform, powered by a
Starfive JH7110 processor.

https://doc-en.rvspace.org/Doc_Center/visionfive_2.html

How to build
============

$ make visionfive2_defconfig
$ make

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Preparing the board
===================

Connect a TTL UART cable to pin 6 (GND), 8 (TX) and 10 (RX).

Change the boot mode pins to SD card booting (RGPIO_0=1, GRPIO_1=0):

https://doc-en.rvspace.org/VisionFive2/Quick_Start_Guide/VisionFive2_SDK_QSG/boot_mode_settings.html

Insert your SD card.

Power-up the board using an USB-C cable.

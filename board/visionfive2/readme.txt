Starfive VisionFive2
====================

The VisionFive2 is a low-cost RISC-V 64-bit based platform, powered by a
Starfive JH7110 processor.

https://doc-en.rvspace.org/Doc_Center/visionfive_2.html

How to build
============

$ make visionfive2_defconfig
$ make

Once the build process is finished you will have two images
in the output/images/ directory:
- sdcard.img
- spi-nor.img

How to write the SPI NOR flash
=============================

If you have a booting device use u-boot and tftp:

  # tftpboot 0x82000000 spi-nor.img
  # sf probe
  # sf update 0x82000000 0x0 {filesize}

Otherwise, follow the recovery instruction:

https://doc-en.rvspace.org/VisionFive2/Quick_Start_Guide/VisionFive2_SDK_QSG/recovering_bootloader%20-%20vf2.html

How to write the SD card
========================

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Preparing the board
===================

Connect a TTL UART cable to pin 6 (GND), 8 (TX) and 10 (RX).

Use the correct mode for booting:
- SD card RGPIO_0=1, GRPIO_1=0
- SPI NOR flash RGPIO_0=1, GRPIO_1=1

Note that Buildroot puts the bootloader both in SPI NOR and on the SD card,
so after flashing as instructed above, either boot mode should work.

https://doc-en.rvspace.org/VisionFive2/Quick_Start_Guide/VisionFive2_SDK_QSG/boot_mode_settings.html

Insert your SD card.

Power-up the board using an USB-C cable.

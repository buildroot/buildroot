StarFive VisionFive2
====================

The VisionFive2 is a low-cost RISC-V 64-bit based platform, powered by a
StarFive JH7110 processor.

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
  # sf update 0x82000000 0x0 ${filesize}

Otherwise, follow the recovery instructions:

https://doc-en.rvspace.org/VisionFive2/Quick_Start_Guide/VisionFive2_SDK_QSG/recovering_bootloader%20-%20vf2.html

How to write the SD card
========================

Write "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M conv=fsync

Preparing the board
===================

Connect a TTL UART cable to pin 6 (GND), 8 (TX) and 10 (RX).

Select SPI NOR flash boot mode:
- RGPIO_0=0, RGPIO_1=0

https://doc-en.rvspace.org/VisionFive2/Quick_Start_Guide/VisionFive2_SDK_QSG/boot_mode_settings.html

Insert your SD card.

Power-up the board using an USB-C cable.

Note that starting with U-Boot v2025.10, booting U-Boot directly from an
SD card is no longer supported on this board. In this configuration, the
bootloader is loaded from SPI NOR flash, while the SD card contains the
Linux kernel, device trees and root filesystem.

https://docs.u-boot.org/en/v2026.07/board/starfive/visionfive2.html#zero-stage-program-loader

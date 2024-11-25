STM32F746-DISCO
===================

This tutorial describes how to use the predefined Buildroot
configuration for the STM32F746-DISCO evaluation platform.

Building
--------

  make stm32f746_disco_sd_defconfig
  make

Flashing
--------

  ./board/stmicroelectronics/stm32f746-disco/flash_sd.sh output/

It will flash the U-boot bootloader.

Creating SD card
----------------

Buildroot prepares an "sdcard.img" image in the output/images/ directory,
ready to be dumped on a SD card. Launch the following command as root:

  dd if=output/images/sdcard.img of=/dev/<your-sd-device>

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout and its content, see the
definition in board/stmicroelectronics/stm32f746-disco/genimage.cfg.

STM32F469 Discovery
===================

This tutorial describes how to use the predefined Buildroot
configuration for the STM32F469 Discovery evaluation platform.

Internal flash memory stores simple afboot-stm32 bootloader, device tree and
in place (XIP) kernel with built-in initramfs. No external flash or SD card
is needed.

Kernel is based on tinyconfig.

Building
--------

  make stm32f469_disco_xip_defconfig
  make

Flashing
--------

  ./board/stmicroelectronics/stm32f469-disco/flash_xip.sh output/

It will flash binary to internal flash memory.

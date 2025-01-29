***************
NXP LS1046A-RDB
***************

This file documents the Buildroot support for the LS1046A Reference Design Board.

for more details about the board and the QorIQ Layerscape SoC, see the following pages:
  - https://www.nxp.com/design/design-center/development-boards-and-designs/LS1046A-RDB
  - https://www.nxp.com/products/LS1046A

for the NXP LDP (Linux Distribution POC), see
  - https://www.nxp.com/design/design-center/software/embedded-software/linux-software-and-development-tools/layerscape-linux-distribution-poc:LAYERSCAPE-SDK

the components provided by NXP are:
  - rcw, lf-6.6.52-2.2.0
  - atf (fork), lf-6.6.52-2.2.0
  - uboot (fork), lf-6.6.52-2.2.0
  - qoriq-fm-ucode (blob), lf-6.6.52-2.2.0
  - linux (fork), lf-6.6.52-2.2.0

Build
=====

First, configure Buildroot for the LS1046A-RDB board:

  make ls1046a-rdb_defconfig

Build all components:

  make

You will find in output/images/ the following files:
  - bl2_sd.pbl
  - fip.bin
  - fsl_fman_ucode_ls1046_r1.0_106_4_18.bin
  - fsl_fman_ucode_ls1046_r1.0_108_4_9.bin
  - fsl-ls1046a-rdb.dtb
  - fsl-ls1046a-rdb-sdk.dtb
  - Image
  - PBL.bin
  - rootfs.ext2
  - rootfs.ext4
  - sdcard.img
  - u-boot.bin

Create a bootable SD card
=========================

To determine the device associated to the SD card have a look in the
/proc/partitions file:

  cat /proc/partitions

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be dumped on a SD card. Launch the following
command as root:

  dd if=output/images/sdcard.img of=/dev/sdX

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout, see the definition in
board/freescale/ls1046a-rdb/genimage.cfg.

Boot the LS1046A-ARDB board
===========================

To boot your newly created system:
- insert the SD card in the SD slot of the board;
- Configure the DIP switches
  SW3[1:8] = 01000110
  SW4[1:8] = 00111011
  SW5[1:8] = 00100000 (select SD Card boot option)
- put a Micro-USB cable into the console port and connect using a terminal emulator
  at 115200 bps, 8n1.
- power on the board.

Alternatively, SD card boot can also be selected from the uboot command prompt:
- insert the SD card in the SD slot of the board;
- put a Micro-USB cable into console Port and connect using a terminal emulator
- power on the board.
- press any key to stop at the uboot command prompt.
- run the following uboot command
  => cpld reset sd

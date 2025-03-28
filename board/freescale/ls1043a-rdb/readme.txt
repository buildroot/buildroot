***************
NXP LS1043A-RDB
***************

This file documents the Buildroot support for the LS1043A Reference Design Board.

for more details about the board and the QorIQ Layerscape SoC, see the following pages:
  - https://www.nxp.com/design/design-center/development-boards-and-designs/LS1043A-RDB
  - https://www.nxp.com/products/LS1043A

Layerscape platforms are officially supported by NXP under the Layerscape
Debian Linux SDK (LDLSDK). This uses components from Linux Factory (project
common with i.MX), currently tag lf-6.6.36-2.1.0, two releases behind the
latest lf-6.12.3-1.0.0.  In Buildroot, the latest Linux Factory release tag
is used, which may be considered pre-release software, as it may contain
features which are not yet documented, and it generally undergoes less testing.

For the software Layerscape Debian Linux SDK User Guide, see:
  - https://docs.nxp.com/bundle/UG10143/page/topics/about_this_document.html
  - https://www.nxp.com/docs/en/user-guide/UG10143.pdf

The components from NXP are:
  - rcw, lf-6.12.3-1.0.0
  - atf (fork), lf-6.12.3-1.0.0
  - uboot (fork), lf-6.12.3-1.0.0
  - qoriq-fm-ucode (blob), lf-6.12.3-1.0.0
  - linux (fork), lf-6.12.3-1.0.0
  - fmlib, lf-6.12.3-1.0.0
  - fmc, lf-6.12.3-1.0.0

Build
=====

First, configure Buildroot for the LS1043A-RDB board:

  make ls1043a-rdb_defconfig

Build all components:

  make

You will find in output/images/ the following files:
  - bl2_sd.pbl
  - fip.bin
  - fsl_fman_ucode_ls1043_r1.1_106_4_18.bin
  - fsl_fman_ucode_ls1043_r1.1_108_4_9.bin
  - fsl-ls1043a-rdb.dtb
  - fsl-ls1043a-rdb-sdk.dtb
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
board/freescale/ls1043a-rdb/genimage.cfg.

Boot the LS1043A-ARDB board
===========================

To boot your newly created system:
- insert the SD card in the SD slot of the board;
- Configure the DIP switches
  SW3[1:8] = 10110011
  SW4[1:8] = 00100000
  SW5[1:8] = 00100010
  (SW5[1:8] and SW4[1] should be set to 001000000_0 for the SD card boot)
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

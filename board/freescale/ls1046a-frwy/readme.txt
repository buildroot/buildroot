**************
NXP LS1046A-FRWY
**************

This file documents the Buildroot support for the LS1046A Freeway Board.

for more details about the board and the QorIQ Layerscape SoC, see the following pages:
  - https://www.nxp.com/design/software/qoriq-developer-resources/ls1046a-freeway-board:FRWY-LS1046A
  - https://www.nxp.com/FRWY-LS1046A
  - https://www.nxp.com/docs/en/quick-reference-guide/FRWY-LS1046AGSG.pdf

for the software NXP LSDK (Layerscape Software Development Kit), see
  - https://www.nxp.com/docs/en/user-guide/LSDKUG_Rev21.08.pdf

the components from NXP are:
  - rcw, LSDK 21.08
  - atf (fork), LSDK 21.08
  - uboot (fork), LSDK 21.08
  - qoriq-fm-ucode (blob), LSDK 21.08
  - linux (fork), LSDK 21.08

Build
=====

First, configure Buildroot for the LS1046A-FRWY board:

  make ls1046a-frwy_defconfig

Build all components:

  make

You will find in output/images/ the following files:
  - bl2_sd.pbl
  - fip.bin
  - fsl_fman_ucode_ls1046_r1.0_106_4_18.bin
  - fsl_fman_ucode_ls1046_r1.0_108_4_9.bin
  - fsl-ls1046a-frwy.dtb
  - fsl-ls1046a-frwy-sdk.dtb
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
board/freescale/ls1046a-frwy/genimage.cfg.

Boot the LS1046A-FRWY board
=========================

To boot your newly created system:
- insert the SD card in the SD slot of the board;
- Configure the switches SW1[1:9] = 0_0100_0000 (select SD Card boot option)
- put a Micro-USB cable into UART1 Port and connect using a terminal emulator
  at 115200 bps, 8n1. Or remove the jumper on J72, connect a USB to TTL cable
  to J73, and connect using a terminal emualtor at 115200 bps, 8n1.
- power on the board.

The front panel Ethernet connectors are off at boot, to bring them up run the
following commands.

1G PORT1
  ip link set eth1 up

1G PORT2
  ip link set eth2 up

1G PORT3
  ip link set eth0 up

1G PORT4
  ip link set eth3 up

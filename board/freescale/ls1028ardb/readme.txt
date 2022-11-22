**************
NXP LS1028ARDB
**************

This file documents the Buildroot support for the LS1028A Reference Design Board.

for more details about the board and the QorIQ Layerscape SoC, see the following pages:
  - https://www.nxp.com/design/qoriq-developer-resources/layerscape-ls1028a-reference-design-board:LS1028ARDB
  - https://www.nxp.com/LS1028A

for the software NXP LSDK (Layerscape Software Development Kit), see
  - https://www.nxp.com/docs/en/user-guide/LSDKUG_Rev21.08.pdf

the components from NXP are:
  - rcw, LSDK 21.08
  - atf (fork), LSDK 21.08
  - uboot (fork), LSDK 21.08
  - cadence-dp-firmware (blob), LSDK 20.12
  - linux (fork), LSDK 21.08

Build
=====

First, configure Buildroot for the LS1028ARDB board:

  make ls1028ardb_defconfig

Build all components:

  make

You will find in output/images/ the following files:
  - bl2_sd.pbl
  - fip.bin
  - fsl-ls1028a-rdb.dtb
  - Image
  - PBL.bin
  - rootfs.ext2
  - rootfs.ext4 -> rootfs.ext2
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
board/freescale/ls1028ardb/genimage.cfg.

Boot the LS1028ARDB board
=========================

To boot your newly created system:
- insert the SD card in the SD slot of the board;
- Configure the switches SW2[1:4] = 1000 (select SD Card boot option)
- put a DB9F cable into the UART1 Port and connect using a terminal
  emulator at 115200 bps, 8n1;
- power on the board.

The Cadence DP (Display Port) firmware must loaded from uboot with the following commands:

  => ext2load mmc 0 0x80000000 /boot/ls1028a-dp-fw.bin
  102464 bytes read in 24 ms (4.1 MiB/s)
  => hdp load 0x80000000 0x2000
  Loading hdp firmware from 0x0000000080000000 offset 0x0000000000002000
  Loading hdp firmware Complete
  => boot

The interfaces of Ethernet switch (Felix DSA) are bring up with the following commands:

  ip link set eno2 up
  ip link set swp0 up
  ip link set swp1 up
  ip link set swp2 up
  ip link set swp3 up

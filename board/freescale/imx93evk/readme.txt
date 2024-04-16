*********************
NXP i.MX93 EVK board
*********************

This file documents the Buildroot support for the i.MX 93 EVK board.

Build
=====

First, configure Buildroot for the i.MX 93 EVK board:

  make freescale_imx93evk_defconfig

Build all components:

  make

You will find in output/images/ the following files:
  - ahab-container.img
  - bl31.bin
  - boot.vfat
  - ddr_fw.bin
  - Image
  - imx93-11x11-evk.dtb
  - imx9-boot-sd.bin
  - lpddr4_pmu_train_fw.bin
  - rootfs.ext2
  - rootfs.ext4
  - rootfs.tar
  - sdcard.img
  - u-boot-atf-container.img
  - u-boot.bin
  - u-boot-hash.bin
  - u-boot-spl.bin
  - u-boot-spl-ddr.bin
  - u-boot-spl-padded.bin

Create a bootable SD card
=========================

To determine the device associated to the SD card have a look in the
/proc/partitions file:

  cat /proc/partitions

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be dumped on a SD card. Launch the following
command as root:

  dd if=output/images/sdcard.img of=/dev/<your-sd-device>

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout, see the definition in
board/freescale/common/imx/genimage.cfg.template_imx9.

Boot the i.MX 93 EVK board
===============================

To boot your newly created system (refer to the i.MX 93 EVK Documentation
[1] for guidance):
- insert the SD card in the SD slot of the board;
- Configure the switches as follows:
SW1301: 0100 SW1301[1-4]
- put a micro USB cable into the Debug USB Port and connect using a terminal
  emulator at 115200 bps, 8n1;
- power on the board.

Note: the debug USB connector presents 4 UARTs (for example /dev/ttyUSB[0-3]),
the Cortex-A55 UART should be the 3rd one (in the previous example, /dev/ttyUSB2).
Refer to the documentation [1] for more details.

Enjoy!

References
==========
[1] https://www.nxp.com/document/guide/getting-started-with-the-i-mx93-evk:GS-IMX93EVK

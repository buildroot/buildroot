**********************
NXP i.MX 93 FRDM board
**********************

This file documents the Buildroot support for the i.MX 93 FRDM
(Freedom) board. For more information on this board, see [1].


Build
=====

First, configure Buildroot for the i.MX 93 FRDM board:

    make freescale_imx93frdm_defconfig

Build all components:

    make

When this command completes, the generated image containing everything
to boot from the SD card is located in "output/images/sdcard.img".


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


Boot the i.MX 93 FRDM board
===========================

To boot your newly created system (refer to the i.MX 93 FRDM
Documentation [2] for guidance):
- insert the SD card in the SD slot (P13) of the board;
- Configure the SW1 boot switches as follows:
  SW1: 1100 SW1[1-4] ("USDHC2 4-bit SD3.0" Boot Mode)
- connect a USB Type-C cable into the P16 Debug USB Port and connect
  using a terminal emulator at 115200 bps, 8n1;
- power on the board by connecting a USB Type-C cable into the P1
  Power USB Port.

Note 1: the board boot switches default configuration is:
SW1: 0100 SW1[1-4] ("USDHC1 8-bit eMMC 5.1" Boot Mode)
and the board is also pre-flashed with a reference Linux demo
image. It is important to change the boot config switches to make
sure the system will boot on the SD Card.

Note 2: the debug USB connector presents 2 UARTs (for example
/dev/ttyACM[0-1]), the Cortex-A55 UART should be the 1st one (in the
previous example, /dev/ttyACM0). Refer to the documentation [2] for
more details.

Enjoy!


References
==========
[1] https://www.nxp.com/FRDM-IMX93
[2] https://www.nxp.com/document/guide/getting-started-with-frdm-imx93:GS-FRDM-IMX93

***************************
NXP i.MX95 15x15 FRDM board
***************************

This file documents the Buildroot support for the i.MX95 15x15 FRDM board.
For more information on this board, see [1].


Build
=====

First, configure Buildroot for the i.MX95 15x15 FRDM board:

    make freescale_imx95_15x15_frdm_defconfig

Build all components:

    make

When this command completes, the generated image containing everything
to boot from the SD card is located in "output/images/sdcard.img".


Create a bootable SD card
=========================

To determine the device associated with the SD card, have a look in the
/proc/partitions file:

    cat /proc/partitions

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be dumped on an SD card. Launch the following
command as root:

    dd if=output/images/sdcard.img of=/dev/<your-sd-device>

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout, see the definition in
board/freescale/common/imx/genimage.cfg.template_imx9.


Boot the i.MX95 15x15 FRDM board
================================

To boot your newly created system (refer to the i.MX95 15x15 FRDM
Documentation [2] for guidance):
- insert the SD card in the SD slot of the board;
- configure the boot switch as follows:
  SW1: 11 SW1[1-2] ("USDHC2 4-bit SD3.0" Boot Mode)
- connect a USB Type-C cable into the USB-DBG port and connect using
  a terminal emulator at 115200 bps, 8n1;
- power on the board by connecting a USB Type-C cable into the PWR IN
  Power USB port.

Note: the debug USB connector presents 4 UARTS (for example
/dev/ttyACM[0-3]), the AP UART should be the first one (in the previous
example, /dev/ttyACM0), while the SM UART should be the second one
(in the previous example, /dev/ttyACM1).

Enjoy!


References
==========
[1] https://www.nxp.com/FRDM-IMX95
[2] https://www.nxp.com/document/guide/getting-started-with-frdm-imx95:GS-FRDM-IMX95

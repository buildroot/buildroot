Texas Instuments SK-AM62 Test and Development Board

Description
===========

This configuration will build a complete image for the TI SK-AM62
board: https://www.ti.com/tool/SK-AM62.

How to Build
============

Select the default configuration for the target:

$ make ti_am62x_sk_defconfig

Optional: modify the configuration:

$ make menuconfig

IMPORTANT: make sure to use the tiboot3 firmware that match with the TI
K3 SoC boot ROM (tiboot3-am62x-{gp/hs-fs/hs}-*.bin) used on the board.

HS-FS should be the default for all TI AM6x devices but earlier version
of TI starter kit EVMs for AM6x was produced with a GP device.

See further details on e2e Forum [1] :

   "Unfortunately with this transition any existing GP device based AM62x
   (and AM64x) boards will no longer boot with MMC/SD card images generated"

For such existing GP device based AM62x boards, users have to provide the
tiboot3.bin name using BR2_TARGET_TI_K3_R5_LOADER_TIBOOT3_BIN.

[1]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1210443/faq-am625-generating-sitara-am62x-am62ax-am64x-gp-device-bootable-mmc-sd-card-images-using-sdk-v8-6-and-yocto

Build:

$ make

To copy the resultimg output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the SK-AM62 board, and power it up through the
USB Type-C connector. The system should come up. You can use a
micro-USB cable to connect to the connector labeled UART to
communicate with the board.

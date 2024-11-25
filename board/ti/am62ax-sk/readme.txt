Texas Instuments SK-AM62A Test and Development Board

Description
===========

This configuration will build a complete image for the TI SK-AM62A
board: https://www.ti.com/tool/SK-AM62A-LP

How to Build
============

Select the default configuration for the target:

$ make ti_am62ax_sk_defconfig

Optional: modify the configuration:

$ make menuconfig

IMPORTANT: make sure to use the tiboot3 firmware that match with the TI
K3 SoC boot ROM (tiboot3-am62ax-{gp/hs-fs/hs}-evm.bin) used on the board.
Use the BR2_TARGET_TI_K3_R5_LOADER_TIBOOT3_BIN to name which tiboot3.bin
security variant we want to use.

Build:

$ make

To copy the resultimg output image file to an SD card use dd:

$ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

Insert the SD card into the SK-AM62A board, and power it up through the
USB Type-C connector. The system should come up. You can use a
micro-USB cable to connect to the connector labeled UART to
communicate with the board.

Kontron pitx-imx8m
==================

https://www.kontron.com/produkte/pitx-imx8m/p155258


How to build it
===============

Configure buildroot:

  $ make kontron_pitx_imx8m_defconfig

Change settings to fit your needs (optional):

  $ make menuconfig

Compile everything and buildr the rootfs image:

  $ make


Result of the build
===================

After building, the output/images directory contains:

  output/images/
    ├── bl31.bin
    ├── boot.scr
    ├── ddr_fw.bin
    ├── Image
    ├── imx8-boot-sd.bin
    ├── imx8mq-kontron-pitx-imx8m.dtb
    ├── lpddr4_pmu_train_fw.bin
    ├── rootfs.ext2
    ├── rootfs.ext4 -> rootfs.ext2
    ├── rootfs.tar
    ├── sdcard.img
    ├── signed_hdmi_imx8m.bin
    ├── u-boot.bin
    ├── u-boot.itb
    ├── u-boot-nodtb.bin
    ├── u-boot-spl.bin
    └── u-boot-spl-ddr.bin


Flashing the SD card image
==========================

To install the image on a SDCard simply copy sdcard.img to the storage (e.g. SD, eMMC)

  $ sudo dd if=output/images/sdcard.img of=<your-sd-device>


Preparing the board
===================

 * Connect a serial line to the board
 * Insert the SD card
 * Make sure the boot source selection DIP switches are set correctly
  * SW1 1-4 OFF
  * SW1 2-3 OFF
 * Power-up the board


Booting the board
=================

By default the bootloader will search for the first valid image, starting
with the internal eMMC. To make sure the bootloader loads bootscript from
the correct location (SD card) set the boot_targets environment variable:

  $ setenv boot_targets mmc1

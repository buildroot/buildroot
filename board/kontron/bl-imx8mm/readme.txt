Kontron BL i.MX8M Mini
======================

https://www.kontron.com/produkte/baseboard-bl-i.mx8m-mini/p158549


How to build it
===============

Configure buildroot:

  $ make kontron_bl_imx8mm_defconfig

Change settings to fit your needs (optional):

  $ make menuconfig

Compile everything and build the rootfs image:

  $ make


Result of the build
===================

After building, the output/images directory contains:

  output/images/
    ├── bl31.bin
    ├── boot.scr
    ├── ddr_fw.bin
    ├── flash.bin
    ├── Image
    ├── imx8mm-kontron-n801x-s.dtb
    ├── lpddr4_pmu_train_1d_dmem_201904.bin
    ├── lpddr4_pmu_train_1d_dmem_202006.bin
    ├── lpddr4_pmu_train_1d_dmem.bin
    ├── lpddr4_pmu_train_1d_dmem_pad.bin
    ├── lpddr4_pmu_train_1d_fw.bin
    ├── lpddr4_pmu_train_1d_imem_201904.bin
    ├── lpddr4_pmu_train_1d_imem_202006.bin
    ├── lpddr4_pmu_train_1d_imem.bin
    ├── lpddr4_pmu_train_1d_imem_pad.bin
    ├── lpddr4_pmu_train_2d_dmem_201904.bin
    ├── lpddr4_pmu_train_2d_dmem_202006.bin
    ├── lpddr4_pmu_train_2d_dmem.bin
    ├── lpddr4_pmu_train_2d_dmem_pad.bin
    ├── lpddr4_pmu_train_2d_fw.bin
    ├── lpddr4_pmu_train_2d_imem_201904.bin
    ├── lpddr4_pmu_train_2d_imem_202006.bin
    ├── lpddr4_pmu_train_2d_imem.bin
    ├── lpddr4_pmu_train_2d_imem_pad.bin
    ├── lpddr4_pmu_train_fw.bin
    ├── rootfs.ext2
    ├── rootfs.ext4 -> rootfs.ext2
    ├── rootfs.tar
    ├── sdcard.img
    ├── u-boot.bin
    └── u-boot-spl.bin


Flashing the SD card image
==========================

To install the image on a SDCard simply copy sdcard.img to the storage (e.g. SD, eMMC)

  $ sudo dd if=output/images/sdcard.img of=<your-sd-device>


Preparing the board
===================

 * Connect a serial line to the board
 * Insert the SD card
 * Power-up the board


Booting the board
=================

By default the bootloader will search for the first valid image, starting
with the internal eMMC. To make sure the bootloader loads bootscript from
the correct location (SD card) set the boot_targets environment variable:

  $ setenv boot_targets mmc1

***************************************************
Xilinx ZCU102 / ZCU104 / ZCU106 boards - ZynqMP SoC
***************************************************

This document describes the Buildroot support for the ZCU102, ZCU104
and ZCU106 boards by Xilinx, based on the Zynq UltraScale+ MPSoC (aka
ZynqMP).  It has been tested with the ZCU102 and ZCU106 production
boards.

Evaluation board features can be found here with the links below.

ZCU102:
https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/ek-u1-zcu102-g.html

ZCU104:
https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/zcu104.html

ZCU106:
https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boards/zcu106.html


How to build it
===============

Configure Buildroot: (use the command for the specific board)

    $ make zynqmp_zcu102_defconfig
    $ make zynqmp_zcu104_defconfig
    $ make zynqmp_zcu106_defconfig

Compile everything and build the rootfs image:

    $ make

Result of the build
-------------------

After building, you should get a tree like this:

    output/images/
    +-- atf-uboot.ub
    +-- bl31.bin
    +-- boot.bin
    +-- boot.vfat
    +-- Image
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- sdcard.img
    +-- system.dtb -> zynqmp-zcu106-revA.dtb
    +-- u-boot.itb
    `-- zynqmp-zcu106-revA.dtb

How to write the SD card
========================

WARNING! This will destroy all the card content. Use with care!

The sdcard.img file is a complete bootable image ready to be written
on the boot medium. To install it, simply copy the image to an SD
card:

    # dd if=output/images/sdcard.img of=/dev/sdX

Where 'sdX' is the device node of the SD.

Eject the SD card, insert it in the board, and power it up.

==============
Important Note
==============

The DDR memory on the original ZCU102 and ZCU106 boards is EOL.
The Buildroot defconfigs for these boards use the new DDR memory
which is configured by the u-boot spl initialization with the
Buildroot config options below.

New DDR Memories:
BR2_TARGET_UBOOT_CUSTOM_MAKEOPTS="DEVICE_TREE=zynqmp-zcu102-rev1.0"
BR2_TARGET_UBOOT_CUSTOM_MAKEOPTS="DEVICE_TREE=zynqmp-zcu106-rev1.0"

If nothing is printing upon boot, most likely it is because the
board has the original DDR memories.  To fix the problem, modify
the Buildroot defconfig file to use the u-boot spl initialization
for the original DDR memory using the config below for the target
board.

Original DDR Memories:
BR2_TARGET_UBOOT_CUSTOM_MAKEOPTS="DEVICE_TREE=zynqmp-zcu102-revA"
BR2_TARGET_UBOOT_CUSTOM_MAKEOPTS="DEVICE_TREE=zynqmp-zcu106-revA"

For more information on this issue:
https://support.xilinx.com/s/article/71961?language=en_US

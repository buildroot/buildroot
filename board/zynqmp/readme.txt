******************************************
Xilinx ZCU102 / ZCU106 boards - ZynqMP SoC
******************************************

This document describes the Buildroot support for the ZCU102 and
ZCU106 boards by Xilinx, based on the Zynq UltraScale+ MPSoC (aka
ZynqMP).  It has been tested with the ZCU102 and ZCU106 production
boards.

Evaluation board features can be found here with the links below.

ZCU102:
https://www.xilinx.com/products/boards-and-kits/zcu102.html

ZCU106:
https://www.xilinx.com/products/boards-and-kits/zcu106.html


How to build it
===============

Configure Buildroot:

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

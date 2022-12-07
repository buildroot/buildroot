******************************************
Xilinx VCK190 board - Versal
******************************************

This document describes the Buildroot support for the VCK190
board by Xilinx, based on Versal.  It has been tested with the 
VCK190 production board.

Evaluation board features can be found here with the link below.

VCK190:
https://www.xilinx.com/products/boards-and-kits/vck190.html


How to build it
===============

Configure Buildroot:

    $ make versal_vck190_defconfig

Compile everything and build the rootfs image:

    $ make

Result of the build
-------------------

After building, you should get a tree like this:

    output/images/
    +-- boot.bin
    +-- boot.vfat
    +-- Image
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- sdcard.img
    +-- system.dtb -> versal-vck190-rev1.1.dtb
    `-- versal-vck190-rev1.1.dtb

How to write the SD card
========================

WARNING! This will destroy all the card content. Use with care!

The sdcard.img file is a complete bootable image ready to be written
on the boot medium. To install it, simply copy the image to an SD
card:

    # dd if=output/images/sdcard.img of=/dev/sdX

Where 'sdX' is the device node of the SD.

Eject the SD card, insert it in the board, and power it up.

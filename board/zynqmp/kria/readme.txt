**************************************************
Xilinx Kria SOM Starter Kits - ZynqMP SoC
**************************************************

This document describes the Buildroot support for the Kria 
KV260 starter kit by Xilinx, based on Kria SOM including the 
Zynq UltraScale+ MPSoC (aka ZynqMP).  It has been tested with 
the KV260 production board.

Evaluation board features can be found here with the link below.

KV260:
https://www.xilinx.com/products/boards-and-kits/kv260.html

How to build it
===============

Configure Buildroot:

    $ make zynqmp_kria_kv260_defconfig

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
    +-- system.dtb -> smk-k26-revA-sck-kv-g-revB.dtb
    +-- u-boot.itb
    `-- smk-k26-revA-sck-kv-g-revB.dtb

How to write the SD card
========================

WARNING! This will destroy all the card content. Use with care!

The sdcard.img file is a complete bootable image ready to be written
on the boot medium. To install it, simply copy the image to an SD
card:

    # dd if=output/images/sdcard.img of=/dev/sdX

Where 'sdX' is the device node of the SD.

Eject the SD card, insert it in the board, and power it up.

How to write boot.bin and u-boot.itb to QSPI boot flash
=======================================================

The Kria SOMs are preconfigured to boot initially from QSPI.
This makes these boards different from other ZynqMP boards
in that the boot.bin and u-boot.itb files need to be flashed
into the QSPI boot flash such that U-Boot can then load all
of the remaining images from the SD card.

In addition, the KV260 Starter Kit QSPI comes pre-flashed with
a utility designed to make updating the QSPI flash memory
easier.

Instructions for using these utilities to update the files
in QSPI flash can be found on the wiki link below.

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1641152513/Kria+K26+SOM#Boot-Firmware-Updates

Additionally, it is possible to use u-boot for updating the
QSPI with new boot.bin and u-boot.itb images with the u-boot
commands below:

Flashing u-boot.itb:
    $ sf probe
    $ fatload mmc 1 0x1000000 u-boot.itb
    $ sf erase 0xf80000 +$filesize
    $ sf write 0x1000000 0xf80000 $filesize

Flashing boot.bin:
    $ sf probe
    $ fatload mmc 1 0x1000000 boot.bin
    $ sf erase 0x200000 +$filesize
    $ sf write 0x1000000 0x200000 $filesize

It is possible to boot the Buildroot generated SD card image without
updating the QSPI boot.bin image, so this is an optional step.

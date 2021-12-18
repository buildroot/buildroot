STMP157-OLinuXino-LIME2

Intro
=====

These are open hardware boards, all based on the STmicro STMP157 SoC.

for more details about the board see the following pages:
 - https://www.olimex.com/Products/OLinuXino/open-source-hardware
 - https://www.olimex.com/Products/OLinuXino/STMP1/STMP157-OLinuXino-LIME2/

The following defconfigs are available:
 - olimex_stmp157_olinuxino_lime_defconfig

How to build it
===============

Configure Buildroot:

    $ make <board>_defconfig

Compile everything and build the rootfs image:

    $ make

Result of the build
-------------------

After building, you should get a tree like this:

    output/images/
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- sdcard.img
    +-- stm32mp1xx-olinuxino-lime.dtb
    +-- u-boot-spl.stm32
    +-- u-boot.img
    `-- zImage


How to write the SD card
========================

The sdcard.img file is a complete bootable image ready to be written
on the boot medium. To install it, simply copy the image to a uSD
card:

    # dd if=output/images/sdcard.img of=/dev/sdX

Where 'sdX' is the device node of the uSD.

Eject the SD card, insert it in the STMP1-OLinuXino board, and power it up.


Intro
=====

This directory contains a Buildroot configuration for building a
LicheePi 4A image. For more information, see the board wiki page [1].


How to build it
===============


Configure Buildroot
-------------------

    make sipeed_licheepi_4a_defconfig


Build the boot and rootfs
-------------------------

Note: you will need to have access to the network, since Buildroot
will download the packages' sources.

You may now build your rootfs with:

    make

(This may take a while, consider getting yourself a coffee ;-) )


Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- boot.ext4
    +-- rootfs.ext2
    +-- rootfs.ext4 -> rootfs.ext2
    +-- rootfs.tar
    +-- u-boot.bin
    +-- u-boot-with-spl.bin
    +-- fw_dynamic.bin
    `-- Image


How to flash the board
======================

Once the build process is finished you will have to flash the
correspoding images to the respective partitions in the eMMC.
LicheePi 4A uses fastboot to flash the images.

The board needs to be booted in "Burning Mode". For that, check first
the boot switches (SW1, SW2) on the base board are set up on the
"eMMC" mode (this is the factory default). Then, boot the board while
pressing the "BOOT" button. See [2].

Note that the board can be booted by either:
- attaching the USB-C power cable, or
- pressing the "RESET" button (near the USB-C power connector) if the
  power cable is already connected to the host computer.

The board should be enumerated from the host computer. This can be
confirmed with "lsusb". The board should be listed as:

    ID 2345:7654 T-HEAD USB download gadget

The device should also be listed by the "fastboot devices" command:

    ????????????         Android Fastboot

The board can be flashed with the commands:

    fastboot flash ram output/images/u-boot-with-spl.bin
    fastboot reboot
    fastboot flash uboot output/images/u-boot-with-spl.bin
    fastboot flash boot output/images/boot.ext4
    fastboot flash root output/images/rootfs.ext2


Boot the board
==============

Connect the console on the System Serial Port on pins
U0-RX, U0-TX and GND. For more details, see [3].

When resetting or powering up the board on the USB-C port, the U-Boot
prompt and Linux console will appear on this System Serial Port.


References
==========

[1] https://wiki.sipeed.com/hardware/en/lichee/th1520/lpi4a/1_intro.html
[2] https://wiki.sipeed.com/hardware/en/lichee/th1520/lpi4a/4_burn_image.html#How-to-enter-burning-mode
[3] https://wiki.sipeed.com/hardware/en/lichee/th1520/lpi4a/6_peripheral.html#System-Serial-Port

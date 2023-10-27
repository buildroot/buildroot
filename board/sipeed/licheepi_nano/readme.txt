Intro
=====

This directory contains a buildroot configuration for building a
LicheePi Nano image which can be flashed into the board.

This frees the MMC port which can be used for an additional SD
card of for a WiFi adapter.

How to build it
===============

Configure Buildroot
-------------------

  $ make sipeed_licheepi_nano_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot
will download the packages' sources.

You may now build your rootfs with:

  $ make

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- flash.bin
    +-- rootfs.jffs2
    +-- rootfs.tar
    +-- suniv-f1c100s-licheepi-nano.dtb
    +-- u-boot.bin
    +-- u-boot-sunxi-with-spl.bin
    `-- zImage

How to flash
============

Once the build process is finished you will have an image called
"flash.bin" in the output/images/ directory. It contains the
bootloader, the device tree, the kernel and the root file system.

The device can be flashed when it is in special mode called "FEL
mode". There are multiple ways to enter this mode described here:
https://linux-sunxi.org/FEL#Entering_FEL_mode

One way is to write one file from sunxi-tools to a SD card with:

  $ sudo dd if=./output/build/host-sunxi-tools-*/bin/fel-sdboot.sunxi of=/dev/sdX bs=1024 seek=8

Once the SD card is burned, insert it into your LicheePi Nano board,
and plug the USB cable. A new USB device should be visible with
lsusb:

  1f3a:efe8 Allwinner Technology sunxi SoC OTG connector in FEL/flashing mode

The image can be flashed with:

  $ sudo ./output/host/bin/sunxi-fel -p spiflash-write 0 output/images/flash.bin

Once this completes, remove the SD card and power the board. Your
new system should come up now and start a console on the UART0
serial port.

Note
====

Some standard kernel features are disabled using the fragment in
order to reduce the size. They can be enabled again if other
features are disabled instead.

For U-Boot, the upstream repository is preferred and the system
boots, but loading the image from the flash takes a long time. It
is much faster when using the branch "licheepi-nano-v2020.01" of
this fork:
https://github.com/florpor/u-boot

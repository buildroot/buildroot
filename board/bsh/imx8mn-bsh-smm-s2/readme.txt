i.MX8MN BSH SMM S2
==================

This tutorial describes how to use the predefined Buildroot
configuration for the i.MX8MN BSH SMM S2 PRO board.

Building
--------

Configure buildroot:

  $ make imx8mn_bsh_smm_s2_defconfig

Change settings to fit your needs (optional):

  $ make menuconfig

Compile everything and build the rootfs image:

  $ make


Result of the build
-------------------

After building, the output/images directory contains:

  output/images/
    ├── bl31.bin
    ├── ddr3*
    ├── flash.bin
    ├── freescale/imx8mn-bsh-smm-s2.dtb
    ├── Image
    ├── nand-full.lst
    ├── rootfs.ext2
    ├── rootfs.ext4 -> rootfs.ext2
    ├── rootfs.tar
    ├── rootfs.ubifs
    ├── u-boot.bin
    └── u-boot-spl.bin


Preparing the board
-------------------

Plug the USB type A to micro B cable into the USB Debug
Connector (DBG UART). Use serial port settings 115200 8N1
to access the debug console.

Plug another USB type A to micro B cable into the USB-OTG
Connector (USB1). This connection is used to flash the board
firmware using the Freescale/NXP UUU tool.

Connect the power supply/adaptor to the DC Power Jack (labelled
+5V).


Flashing
--------

Power up the board by switching on the Power ON Switch, which is
placed right next to the DC Jack.

Enter the following U-Boot commands on the debug serial console:

  $ nand erase.chip
  $ reset

Flash the built images directly to board’s memory. On your computer,
run:

  $ board/bsh/imx8mn-bsh-smm-s2/flash.sh output/

It will flash the bootloader, the Device Tree Blob, the kernel image
and the UBI root file system.

i.MX8MN BSH SMM S2 PRO
======================

How to build it
---------------

Configure buildroot:

  $ make imx8mn_bsh_smm_s2_pro_defconfig

Change settings to fit your needs (optional):

  $ make menuconfig

Compile everything and build the rootfs image:

  $ make


Result of the build
-------------------

After building, the output/images directory contains:

  output/images/
    ├── bl31.bin
    ├── Image
    ├── flash.bin
    ├── ddr3*
    ├── rootfs.ext2
    ├── rootfs.ext4 -> rootfs.ext2
    ├── rootfs.tar
    ├── sdcard.img
    ├── u-boot.bin
    ├── u-boot-nodtb.bin
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


Flashing the emmc card image
----------------------------

Power up the board by switching on the Power ON Switch, which is
placed right next to the DC Jack.

Enter the following U-Boot commands on the debug serial console:

  $ fastboot usb 0

Flash the images on eMMC. On your computer, run:

  $ board/bsh/imx8mn-bsh-smm-s2-pro/flash.sh output/


Booting the board
-----------------

By default the bootloader will search for the first valid image,
starting with the internal eMMC.

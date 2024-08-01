MX6X Udoo Neo board
===================
http://www.udoo.org/udoo-neo/

Build:
======

To build a minimal support for these boards:

    $ make mx6sx_udoo_neo_defconfig
    $ make

Files created in the output directory:
======================================

output/images
.
├── boot.scr
├── imx6sx-udoo-neo-basic.dtb
├── imx6sx-udoo-neo-extended.dtb
├── imx6sx-udoo-neo-full.dtb
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── SPL
├── u-boot.bin
├── u-boot.img
└── zImage

Creating bootable SD card:
==========================

Buildroot prepares a bootable "sdcard.img" image in the output/images/
directory, ready to be dumped on an SD card:

dd if=output/images/sdcard.img of=/dev/<your-microsd-device>

For details about the medium image layout, see the definition in
board/freescale/common/imx/genimage.cfg.template_no_boot_part_spl.

Booting:
========

Serial console:
---------------
The Udoo Neo features the serial console "UART1" on the pin header "P7". The
Uart pins are as follows (see board labels):

pin 46: rx
pin 47: tx

Baudrate for this board is 115200.

Login:
------
Enter 'root' as login user, and the prompt is ready.

Documentation:
==============

documentation link:
-------------------
https://www.udoo.org/docs-neo/Introduction/Introduction.html

forum link:
-----------
https://www.udoo.org/forum/forums/udoo-neo.39/

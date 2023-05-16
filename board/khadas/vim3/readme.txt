Khadas VIM3

Description
===========

This configuration builds a complete image for the Khadas VIM3 to be flashed
on an SD-card.

How to build it
===============

Select the default configuration for the target:
$ make khadas_vim3_defconfig

Optional: modify the configuration:
$ make menuconfig

Build:
$ make

Result of the build
===================
output/images/
+-- amlogic-boot-fip
+   +-- build-fip.sh
+   +-- g12a.inc
+   `-- khadas-vim3
+       +-- acs.bin
+       +-- acs_tool.py
+       +-- aml_ddr.fw
+       +-- aml_encrypt_g12b
+       +-- bl2.bin
+       +-- bl301.bin
+       +-- bl30.bin
+       +-- bl31.bin
+       +-- bl31.img
+       +-- blx_fix.sh
+       +-- ddr3_1d.fw
+       +-- ddr4_1d.fw
+       +-- ddr4_2d.fw
+       +-- diag_lpddr4.fw
+       +-- lpddr3_1d.fw
+       +-- lpddr4_1d.fw
+       +-- lpddr4_2d.fw
+       +-- Makefile
+       `-- piei.fw
+-- boot.vfat
+-- extlinux
+   `-- extlinux.conf
+-- fip
+   +-- u-boot.bin
+   +-- u-boot.bin.sd.bin
+   +-- u-boot.bin.usb.bl2
+   `-- u-boot.bin.usb.tpl
+-- Image
+-- meson-g12b-a311d-khadas-vim3.dtb
+-- rootfs.ext2
+-- rootfs.ext4 -> rootfs.ext2
+-- rootfs.tar
+-- sdcard.img
`-- u-boot.bin

The post-image script uses the files in the amlogic-boot-fip folder to sign
the bootloader image before integrating it into the sdcard image.

To copy the image file to the sdcard use dd:
$ dd if=output/images/sdcard.img of=/dev/sdX

Tested hardware
===============
Khadas vim3 (rev. 14)

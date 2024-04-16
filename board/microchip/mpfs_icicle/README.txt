Microchip PolarFire SoC Icicle Kit
==================================

This file describes how to use the pre-defined Buildroot
configuration for Microchip's PolarFire SoC Icicle Kit.

Further information about the PolarFire SoC Icicle Kit can be found
at https://github.com/polarfire-soc/polarfire-soc-documentation

Building
========

Configure Buildroot using the default board configuration:

  '$ make microchip_mpfs_icicle_defconfig'

Customise the build as necessary:

  '$ make menuconfig'

Start the build:

  '$ make'

Result of the build
===================

Once the build has finished you will have the following files:

    output/images/
    +-- boot.scr
    +-- boot.vfat
    +-- Image
    +-- mpfs_icicle.itb
    +-- mpfs_icicle.its
    +-- mpfs-icicle-kit.dtb
    +-- payload.bin
    +-- rootfs.ext2
    +-- rootfs.ext4
    +-- rootfs.tar
    +-- sdcard.img
    +-- u-boot.bin


Creating a bootable SD card with genimage
=========================================

By default Buildroot builds a SD card image for you. The first partition
of this image contains a U-Boot binary, embedded in a Hart Software
Services (HSS) payload. The second partition contains a FAT filesystem
with a U-Boot env and an ITB file containing the kernel and the device
tree. The third partition contains the file system. This image can be
written directly to the eMMC or an SD card. All you need to do is dd the
image to the eMMC or your SD card, which can be done with the following
command on your development host:

  '$ sudo dd if=output/images/sdcard.img of=/dev/sdb bs=1M'

For instructions on how to transfer the image to the eMMC/SD, please refer to
the "Programming the Linux image" section of our guide on updating
PolarFire SoC dev kits:
https://github.com/polarfire-soc/polarfire-soc-documentation/blob/master/reference-designs-fpga-and-development-kits/updating-mpfs-kit.md.

Terasic DE10 Nano Development Board

Intro
=====

More information about this board can be found here:
https://rocketboards.org/foswiki/Documentation/DE10NanoDevelopmentBoard

Build
=====

First, load socrates config for buildroot

    make terasic_de10nano_cyclone5_defconfig

Build everything

    make

Following files will be generated in output/images

.
├── barebox-env
├── barebox-socfpga-de10_nano.img
├── barebox-socfpga-de10_nano-xload.img
├── boot.vfat
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── socfpga_cyclone5_de0_nano_soc.dtb
└── zImage

Creating bootable SD card
=========================

Simply invoke

dd if=output/images/sdcard.img of=/dev/sdX

Where X is your SD card device (not partition)

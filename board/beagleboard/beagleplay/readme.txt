BeagleBoard's BeaglePlay

Description
===========

This configuration will build a complete image for the BeaglePlay
board: https://www.beagleboard.org/boards/beagleplay

How to Build
============

Select the default configuration for the target:

    $ make beagleplay_defconfig

Optional: modify the configuration:

    $ make menuconfig

NOTE: The AM625x processor has multiple security variants. You must
ensure the matching tiboot3.bin is uses or the board will not boot.
The BeaglePlay uses the General Purpose (GP) variant, ensure you use
the tiboot3-am62x-gp-evm.bin

Build:

    $ make

To copy the resultimg output image file to an SD card use dd:

    $ dd if=output/images/sdcard.img of=/dev/sdX bs=1M

How to Run
==========

This configuration has both the boot/ and root/ partitions which is
capable of booting from the bootloaders embedded in the eMMC as well
as when using holding the USR button to boot from the SD card.


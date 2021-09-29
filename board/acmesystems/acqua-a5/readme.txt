Acme Systems Acqua A5

Intro
=====

The Acqua A5 is a system on module based on the Microchip SAMA5D31 SoC:

    https://www.acmesystems.it/acqua

The files here support configurations that build a microSD image for a
minimal system that can be accessed through the serial console. You will
need an USB-to-serial interface in order to access that console from
your computer:

    https://www.acmesystems.it/DPI

How to build the image
======================

If you have an Acqua module with 256 MiB of RAM, type:

$ make acmesystems_acqua_a5_256mb_defconfig

If you have the 512 MiB version, type instead:

$ make acmesystems_acqua_a5_512mb_defconfig

You can optionally tweak the configuration and add packages by typing:

$ make menuconfig

Then, proceed with the build:

$ make

How to write the microSD card
=============================

The system image is the file "sdcard.img" in the "output/images"
directory. Write it to the card by invoking:

$ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M

where `sdX' is the block device representing the microSD card.

Intro
=====

Libre Computer "La Frite" is a low cost SBC based around an Amlogic
s805x SoC (quad A53), 512MB/1GB DDR4 and a 16MB SPI NOR flash:

https://libre.computer/products/boards/aml-s805x-ac/

Ensure the the bootloader in the SPI flash is up-to-date. Updates are
available at:

https://boot.libre.computer/release/aml-s805x-ac/

To update, write aml-s805x-ac-spiflash.img to a USB flash drive and
boot it as described below.

How to build it
===============

Configure Buildroot:

    $ make lafrite_defconfig

Compile everything and build the USB flash drive image:

    $ make

How to write the USB flash drive image
======================================

Once the build process is finished you will have an image called "usb.img"
in the output/images/ directory.

Copy the bootable "usb.img" onto a USB flash drive with "dd":

  $ sudo dd if=output/images/usb.img of=/dev/sdX

How to boot
===========

Insert flash drive to the USB connector furthest away from the IR
receiver and power up board. The system will boot automatically.

A serial console is available on the GPIO header with the following
pinout:

- TX: pin 3
- RX: pin 5
- Ground: pin 6

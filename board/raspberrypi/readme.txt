Raspberry Pi

Intro
=====

These instructions apply to all models of the Raspberry Pi:
  - the original models A and B,
  - the "enhanced" models A+ and B+,
  - the model CM (aka Raspberry Pi Compute Module).
  - the model Zero (aka Raspberry Pi Zero)
  - the model Zero W (aka Raspberry Pi Zero W)
  - the model Zero 2 W (aka Raspberry Pi Zero 2 W)
  - the model B2 (aka Raspberry Pi 2)
  - the model B3 (aka Raspberry Pi 3).
  - the model CM3 (aka Raspberry Pi Compute Module 3).
  - the model CM3+ (aka Raspberry Pi Compute Module 3+).
  - the model B4 (aka Raspberry Pi 4).
  - the model 400 (aka Raspberry Pi 400).
  - the model CM4 (aka Raspberry Pi Compute Module 4 and IO Board).
  - the model CM4s (aka Raspberry Pi Compute Module 4s).
  - the model B5 (aka Raspberry Pi 5).
  - the model 500 (aka Raspberry Pi 500).

How to build it
===============

Configure Buildroot
-------------------

There are several Raspberry Pi defconfig files in Buildroot, one for
each major variant, which you should base your work on:

For models A, B, A+, B+ and CM:

  $ make raspberrypi_defconfig

For model Zero (model A+ in smaller form factor):

  $ make raspberrypi0_defconfig

or for model Zero W (model Zero with wireless LAN and Bluetooth):

  $ make raspberrypi0w_defconfig

For model Zero 2 W (model B3 in smaller form factor):

  $ make raspberrypizero2w_defconfig

or for model Zero 2 W (model B3 in smaller form factor, 64-bit):

  $ make raspberrypizero2w_64_defconfig

For model 2 B:

  $ make raspberrypi2_defconfig

or for model 2 B (Rev 1.2, model B3 without wireless LAN and Bluetooth, 64 bit):

  $ make raspberrypi2_64_defconfig

For model 3 B, B+, CM3 and CM3+:

  $ make raspberrypi3_defconfig

or for model 3 B, B+, CM3 and CM3+ (64 bit):

  $ make raspberrypi3_64_defconfig

For model 4 B, 400, CM4 and CM4s:

  $ make raspberrypi4_defconfig

or for model 4 B, 400, CM4 and CM4s (64 bit):

  $ make raspberrypi4_64_defconfig

For model CM4 (on IO Board):

  $ make raspberrypicm4io_defconfig

or for CM4 (on IO Board - 64 bit):

  $ make raspberrypicm4io_64_defconfig

For model 5 B and 500:

  $ make raspberrypi5_defconfig

Build the rootfs
----------------

Note: you will need to have access to the network, since Buildroot will
download the packages' sources.

You may now build your rootfs with:

  $ make

(This may take a while, consider getting yourself a coffee ;-) )

Result of the build
-------------------

After building, you should obtain this tree:

    output/images/
    +-- bcm2708-rpi-b-rev1.dtb      [1]
    +-- bcm2708-rpi-b.dtb           [1]
    +-- bcm2708-rpi-b-plus.dtb      [1]
    +-- bcm2708-rpi-cm.dtb          [1]
    +-- bcm2708-rpi-zero.dtb        [1]
    +-- bcm2708-rpi-zero-w.dtb      [1]
    +-- bcm2709-rpi-2-b.dtb         [1]
    +-- bcm2710-rpi-2-b.dtb         [1]
    +-- bcm2710-rpi-3-b.dtb         [1]
    +-- bcm2710-rpi-3-b-plus.dtb    [1]
    +-- bcm2710-rpi-cm3.dtb         [1]
    +-- bcm2710-rpi-zero-2-w.dtb    [1]
    +-- bcm2711-rpi-4-b.dtb         [1]
    +-- bcm2711-rpi-400.dtb         [1]
    +-- bcm2711-rpi-cm4.dtb         [1]
    +-- bcm2711-rpi-cm4s.dtb        [1]
    +-- bcm2712-rpi-5-b.dtb         [1]
    +-- bcm2712d0-rpi-5-b.dtb       [1]
    +-- bcm2712-rpi-500.dtb         [1]
    +-- boot.vfat
    +-- rootfs.ext4
    +-- rpi-firmware/
    |   +-- bootcode.bin            [2]
    |   +-- cmdline.txt
    |   +-- config.txt
    |   +-- fixup.dat               [3]
    |   +-- fixup4.dat              [4]
    |   +-- start.elf               [3]
    |   +-- start4.elf              [4]
    |   `-- overlays/               [5]
    +-- sdcard.img
    +-- Image                       [1]
    `-- zImage                      [1]

[1] Not all of them will be present, depending on the RaspberryPi
    model you are using.

[2] Only for the Raspberry Pi 1, 2, 3, Zero, Zero W and Zero 2 W. The Raspberry
    Pi 4, 400, 5 and the Compute Module 4, 4s and 5 load the second stage
    bootloader from a SPI flash EEPROM.

[3] Only for the Raspberry Pi 1, 2, 3, Zero and Zero 2.

[4] Only for the Raspberry Pi 4, 400, Compute Module 4 and 4s.

[5] Only for the Raspberry Pi installing device-tree overlays. The Raspberry Pi
    with Bluetooth connectivity (Zero W, Zero 2 W, 3, 4, 400, Compute Module 4
    and 4s) use the miniuart-bt overlay to enable UART0 for the serial console;
    the Bluetooth uses the mini-UART instead. Alternative would be to disable
    the serial console in cmdline.txt and /etc/inittab.

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Insert the SDcard into your Raspberry Pi, and power it up. Your new system
should come up now and start two consoles: one on the serial port on
the P1 header, one on the HDMI output where you can login using a USB
keyboard.

How to write to CM4 eMMC memory
===============================

For CM4 modules without eMMC memory see above for booting from SD card,
for CM4 modules with eMMC memory proceed as following:

- fit jumper on IO Board header J2 to disable eMMC boot
- connect IO Board micro USB port (J11 USB slave) to your host linux system
- power up CM4/IO Board (lsusb command should show a '0a5c:2711 Broadcom Corp.
  BCM2711 Boot' device)
- run 'sudo ./host/bin/rpiboot', output should look like the following:
    Waiting for BCM2835/6/7/2711...
    Loading embedded: bootcode4.bin
    Sending bootcode.bin
    Successful read 4 bytes
    Waiting for BCM2835/6/7/2711...
    Loading embedded: bootcode4.bin
    Second stage boot server
    Loading embedded: start4.elf
    File read: start4.elf
    Second stage boot server done

- a USB mass storage device should show up (the CM4 eMMC memory), proceed
  as described above to copy sdcard.img to it
- power down CM4/IO Board
- remove jumper on IO Board header J2 to re-enable eMMC boot
- power up CM4/IO Board

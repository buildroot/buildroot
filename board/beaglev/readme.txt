BeagleV
=======

BeagleV is a low-cost RISC-V 64-bit based platform, powered by a
Starfive JH7100 processor. The current defconfig in Buildroot has been
tested with the JH7100 chip used on the beta version of the BeagleV
board.

How to build
============

$ make beaglev_defconfig
$ make

Build results
=============

After building, output/images contains:

+ bootloader-JH7100-buildroot.bin.out
+ ddrinit-2133-buildroot.bin.out
+ Image
+ fw_payload.bin
+ fw_payload.bin.out
+ fw_payload.elf
+ rootfs.ext2
+ rootfs.ext4
+ sdcard.img
+ u-boot.bin

The four important files are:

 - bootloader-JH7100-buildroot.bin.out, the first stage bootloader

 - ddrinit-2133-buildroot.bin.out, the DDR initialization firmware

 - fw_payload.bin.out, which is the bootloader image, containing
   both OpenSBI and U-Boot.

 - sdcard.img, the SD card image, which contains the root filesystem,
   kernel image and Device Tree.

Flashing the SD card image
==========================

$ sudo dd if=output/images/sdcard.img of=/dev/sdX

Preparing the board
===================

Connect the Beagle-V fan to the 5V supply (pin 2 or 4 of the GPIO
connector) and GND (pin 6 of the GPIO connector).

Connect a TTL UART cable to pin 8 (TX), 10 (RX) and 14 (GND).

Insert your SD card.

Power-up the board using an USB-C cable.

Flashing OpenSBI/U-Boot
=======================

The bootloader pre-flashed on the Beagle-V has a non-working
fdt_addr_r environment variable value, so it won't work
as-is. Reflashing the bootloader with the bootloader image produced by
Buildroot is necessary.

When the board starts up, a pre-loader shows a count down of 2
seconds, interrupt by pressing any key. You should reach a menu like
this:

--------8<----------

bootloader version:210209-4547a8d
ddr 0x00000000, 1M test
ddr 0x00100000, 2M test
DDR clk 2133M,Version: 210302-5aea32f
0
***************************************************
*************** FLASH PROGRAMMING *****************
***************************************************

0:update uboot
1:quit
select the function:

--------8<----------

Press 0 and Enter. You will now see "C" characters being
displayed. Ask your serial port communication program to send
fw_payload.bin.out using the Xmodem protocol.

After reflashing is complete, restart the board, it will automatically
start the system from the SD card, and reach the login prompt.

Flashing low-level bootloaders
==============================

The BeagleV comes pre-flashed with functional low-level bootloaders
(called "secondboot" and "ddrinit"). Re-flashing them is not necessary
to use this Buildroot defconfig. However, for the sake of
completeness, Buildroot builds and provides those low-level bootloader
images.

You can flash them as follows:

 - In the same "pre-loader" menu as the one used above, instead of
   entering 0 or 1, enter the magic "root@s5t" string. This enters the
   "expert" features.

 - Then, press 0 and send over X-modem the
   bootloader-JH7100-buildroot.bin.out file.

 - Then, press 1 and send over X-modem the
   ddrinit-2133-buildroot.bin.out.

Note that the reflashing mechanism itself relies on those low-level
bootloaders, so if you flash non-working versions, you'll have to go
through a recovery process. This requires wiring up to a separate
debug UART, which pins are located near the HDMI connector. See
https://wiki.seeedstudio.com/BeagleV-Update-bootloader-ddr-init-boot-uboot-Recover-bootloader/
section "Recover the bootloader" for more details. The instructions
make use of a jh7100-recover tool, which Buildroot has built as part
of this defconfig: it is available as output/host/bin/jh7100-recover.

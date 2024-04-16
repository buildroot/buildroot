RZBoard V2L
===========

https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/rzboard-v2l/

This board support creates a bootable sd card image for the AVNET RZBoard V2L.
This board is shipped with a u-boot inside its eMMC. This board support uses
that u-boot and only puts uEnv.txt, kernel image and rootfs onto the sd card.

Build:
======

  $ make rzboard_v2l_defconfig
  $ make

Files created in output directory
=================================

output/images
.
├── Image
├── boot.vfat
├── rootfs.ext2
├── rootfs.ext4
├── rootfs.tar
├── rzboard.dtb
├── sdcard.img
└── uEnv.txt

Creating bootable SD card:
==========================

Simply invoke (as root)

sudo dd if=output/images/sdcard.img of=/dev/sdX && sync

Where X is your SD card device.

Booting:
========

Configure board for sd card boot:
---------------------------------
Set the 'BOOT1' switch (next to the audio jack) to '1' (away from 'ON') in
order to let the board boot kernel and rootfs from SD card.

Serial console:
---------------
The RZBoard V2L has a 4-pin header "J19" right next to the micro USB. Its
layout can be seen in the Quick-Start Guide, or the Hardware User Guide,
obtainable from:
https://www.avnet.com/wps/portal/us/products/avnet-boards/avnet-board-families/rzboard-v2l/

The uart pins are as follows (from left to right - orientation according to the
board's labeling):

pin 1: n/a  (most away from the board's corner)
pin 2: tx
pin 3: rx
pin 4: gnd  (nearest to the board's corner)

Baudrate for this board is 115200.

Power-Up:
---------
Plug in a suitable USB-C power supply and press the button 'S1' (next to the
USB-C port) for 2 seconds until the LED goes on.

Login:
------
Enter 'root' as login user, and the prompt is ready.

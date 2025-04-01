ENGICAM PX30-EDIMM2.2 carrier board
===================================

Build:

  $ make engicam_px30_core_defconfig
  $ make

Files created in output directory
---------------------------------

output/images

├── bl31.elf
├── idbloader.img
├── Image
├── px30-engicam-px30-core-ctouch2-of10.dtb
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── u-boot.bin
└── u-boot.itb

How to connect the board and get started:
-----------------------------------------
Ensure that the power supply is stable and provides enough current to handle
the board's needs, especially when peripherals are connected.

Insert micro SD card on the board micro SD slot J17

Creating bootable SD card:
--------------------------
sudo dd if=output/images/sdcard.img of=/dev/sdX && sync

/dev/sdX is the path in host via which SD card is detected
Where X is your SD card device

Connect UART port on the board J26

Serial console
--------------
Launch minicom at host with 1152008N1

Power on the kit using J4

Refer link on checking board booting

Program eMMC
------------
Connect USB otg cable A-type to host pc, Micro USB end to board.

Close Jumper JM5.

Boot the Kit with SD boot.

Program eMMC in U-Boot. (Refer link for the steps)

Wiki link:
https://wiki.amarulasolutions.com/bsp/rockchip/px30/engicam-px30-edimm2.2.html

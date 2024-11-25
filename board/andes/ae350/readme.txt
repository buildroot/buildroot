Intro
=====

Andestech AE350 Platform

The AE350 prototype demonstrates the AE350 platform on the FPGA.

How to build it
===============

Configure Buildroot
-------------------

  $ make andes_ae350_45_defconfig

If you want to customize your configuration:

  $ make menuconfig

Build everything
----------------
Note: you will need to access to the network, since Buildroot will
download the packages' sources.

  $ make

Result of the build
-------------------

After building, you should obtain the following files:

  output/images/
  |-- ae350_ax45mp.dtb
  |-- boot.vfat
  |-- fw_dynamic.bin
  |-- fw_dynamic.elf
  |-- Image
  |-- rootfs.ext2
  |-- rootfs.ext4 -> rootfs.ext2
  |-- sdcard.img
  |-- u-boot-spl.bin
  `-- u-boot.itb

How to update the bootloader and device-tree
============================================

To update the bootloader and device tree, make sure you have
an ICEman (Andes OpenOCD [1]) and AICE [2] connection set up
as below:

  Local Host                 Local/Remote Host
 .-----------------.          .--------------.
 | buildroot images|          |              |
 |                 |         ICEman host <IP:PORT>
 | .----------.    |          |  .--------.  |
 | | SPI_burn |<---+--socket--+->| ICEman |  |
 | '----------'    |          |  '--.-----'  |
 '-----------------'          '-----|--------'
                                    |
                                    USB
   .--------------.                 |
   | target       |           .-----v-----.
   | board        <----JTAG---| AICE      |
   |              |           '-----------'
   '--------------'

[1] https://github.com/andestech/ICEman
[2] https://www.andestech.com/en/products-solutions/andeshape-platforms/aice-micro/

The Andes SPI_burn tool will be located in output/host/bin. Use
the following commands to update the bootloader and device tree:

  $ SPI_burn --host $ICE_IP --port $ICE_BURNER_PORT --addr 0x0     -i u-boot-spl.bin
  $ SPI_burn --host $ICE_IP --port $ICE_BURNER_PORT --addr 0x10000 -i u-boot.itb
  $ SPI_burn --host $ICE_IP --port $ICE_BURNER_PORT --addr 0xf0000 -i ae350_ax45mp.dtb

Note that the --addr option specifies the offset starting from
the flash base address 0x80000000 and set by U-Boot configurations.
e.g.
u-boot-spl.bin  : CONFIG_SPL_TEXT_BASE=0x80000000
u-boot.itb      : CONFIG_SPL_LOAD_FIT_ADDRESS=0x80010000
ae350_ax45mp.dtb: CONFIG_SYS_FDT_BASE=0x800f0000

How to write the SD card
========================

Copy the sdcard.img to a SD card with "dd":

  $ sudo dd if=sdcard.img of=/dev/sdX bs=4096
  $ sudo sync

Your SD card partition should be:

  Disk /dev/sdb: 14.48 GiB, 15552479232 bytes, 30375936 sectors
  Disk model: Multi-Card
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: dos
  Disk identifier: 0x00000000

  Device     Boot Start    End Sectors Size Id Type
  /dev/sdb1           1   4096    4096   2M  c W95 FAT32 (LBA)
  /dev/sdb2  *     4097 126976  122880  60M 83 Linux

Insert SD card and reset the board, it should boot Linux from mmc.

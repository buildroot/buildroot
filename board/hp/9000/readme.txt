Introduction
============

The hp_9000_defconfig is meant to run Linux on a large range of 32-bit
HP PA-RISC 1.1 Workstations, such as the HP 9000 700 and Visualize
workstations. [1]

Building
========

  $ make hp_9000_defconfig
  $ make

Generated files under output/images:

* lifimage: network bootable image comprising Linux kernel and ramdisk.
* disk.img: bootable disk image, with Linux kernel and root filesystem.

Running
=======

To run the generated system, one method is to write the disk image directly to
the workstation hard disk drive using a PC and an SCSI adapter. Extract the
disk from the workstation, connect it to the PC, then do:

  # dd if=output/images/disk.img of=<hdd device> ; sync

Put the disk back into the workstation, connect to the UART console with
baudrate 9600; the firmware should boot Linux from disk and you should obtain a
login prompt.

Another method is to boot from the network. This necessitates to setup a DHCP
and TFTP server, such as dnsmasq[2], to give the workstation its boot filename
with DHCP and serve the lifimage with TFTP.

Connect to the UART console with baudrate 9600 and interrupt the boot sequence
of the firmware.

On an HP 9000 712 workstation, do:

  BOOT_ADMIN> boot lan

On an HP Visualize J210XC workstation, do:

  Configuration Menu: Enter command > boot lan
  Interact with IPL (Y or N)?>  n

The firmware should boot Linux from the network and you should obtain a login
prompt.

It is possible to download the disk image from the network and write it to the
hard disk drive, for example with TFTP:

  # tftp -g -r <path to>/disk.img -l /dev/sda <server ip>

[1] https://www.openpa.net/systems/
[2] https://dnsmasq.org/doc.html

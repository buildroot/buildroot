Intro
=====

Andestech(nds32) AE300 Platform

The AE300 prototype demonstrates the AE300 example platform on the FPGA.
It is composed of one Andestech(nds32) processor and AE300.

How to build it
===============

Configure Buildroot
-------------------

The andes_ae300_defconfig configuration is a sample configuration with
all that is required to bring the FPGA Development Board:

  $ make andes_ae300_defconfig

Build everything
----------------
Note: you will need to have access to the network, since Buildroot will
download the packages' sources.

  $ make

Result of the build
-------------------

After building, you should obtain this tree:

output/images/
    +-- vmlinux
    +-- rootfs.cpio
    +-- rootfs.tar

How to run it
=============

Run
---

  Setup the Console with the rate 38400/8-N-1.

  $ cd output/images
  $ ../host/bin/nds32le-linux-gdb vmlinux
  $ target remote [your host]
  $ lo
  $ c 

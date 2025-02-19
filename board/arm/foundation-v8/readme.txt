Introduction
============

This is the support for the ARM Foundation v8 machine emulated by the
ARM software simulator of the AArch64 architecture.

Building
========

  $ make arm_foundationv8_defconfig
  $ make

Generated files under output/images:

* linux-system.axf: An image comprising the boot-wrapper-aarch64 minimal
                    firmware and bootloader, a Devicetree and the Linux kernel.
* rootfs.ext2:      The OS root filesystem.

Running on the simulator
========================

Download the AArch64 software simulator from one of the following sources,
corresponding to your host computer:

- https://developer.arm.com/-/cdn-downloads/permalink/FVPs-Architecture/FM-11.27/Foundation_Platform_11.27_19_Linux64.tgz
- https://developer.arm.com/-/cdn-downloads/permalink/FVPs-Architecture/FM-11.27/Foundation_Platform_11.27_19_Linux64_armv8l.tgz

Finally, boot your system with:

 ${LOCATION_OF_FOUNDATIONV8_SIMULATOR}/models/Linux64_GCC-9.3/Foundation_Platform \
    --arm-v8.0 \
    --image output/images/linux-system.axf \
    --block-device output/images/rootfs.ext2 \
    --network=nat \
    --cores 4

You can get network access from within the simulated environment
by requesting an IP address using DHCP (run the command 'udhcpc').

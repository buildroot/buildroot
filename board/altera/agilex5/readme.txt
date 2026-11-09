Altera SoCFPGA Agilex 5 SoC Development Kit


Intro
=====

This configuration builds a Linux system for the Agilex 5 SoC
Development Kit (socfpga_agilex5_socdk) from the QPDS Golden System
Reference Design component versions:

  https://github.com/altera-fpga/linux-socfpga
  https://github.com/altera-fpga/u-boot-socfpga
  https://github.com/altera-fpga/arm-trusted-firmware

The HPS first-stage bootloader is packaged by Quartus into the FPGA
configuration file. This defconfig builds the software that the HPS loads
after that: U-Boot (u-boot.itb, with TF-A BL31), the kernel Image, the
socfpga_agilex5_socdk device tree, and a root filesystem.

The socfpga_agilex5_vendor_defconfig supports the Agilex5 065B Premium
development kit [1].


Build
=====

    make socfpga_agilex5_vendor_defconfig
    make

output/images will contain:

    Image
    socfpga_agilex5_socdk.dtb
    u-boot.itb
    u-boot-spl-dtb.hex
    bl31.bin
    rootfs.ext2
    rootfs.tar.gz
    sdcard.img

sdcard.img has a FAT boot partition (Image, device tree, u-boot.itb) and
an ext4 root filesystem on the second partition.


Creating a bootable SD card
===========================

Prepare the SD card with this command:

    dd if=output/images/sdcard.img of=/dev/sdX

Notes:
  - replace 'sdX' with the actual device with your micro SDcard,
  - you may need to be root to do that (use 'sudo')

Program the HPS first-stage bootloader with Quartus, using
output/images/u-boot-spl-dtb.hex as the HPS handoff file. Boot the HPS
from the SD card. The serial console is ttyS0 at 115200 8n1.

Copy a fabric configuration file named ghrd.core.rbf onto the FAT
partition if the design needs the FPGA loaded before Linux starts. U-Boot
skips that step when the file is absent.

[1] https://www.altera.com/products/devkit/po-3284/agilex-5-fpga-e-series-065b-premium-development-kit

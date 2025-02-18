Polyhex Debix Model A
=====================

DEBIX Model A is an industrial grade single board computer
powered by NXP i.MX 8M Plus applications processor

https://www.debix.io/hardware/model-a.html
User Manual: [1]


How to build it
===============

Configure buildroot:

  $ make polyhex_debix_model_a_defconfig

Change settings to fit your needs (optional):

  $ make menuconfig

Compile everything and build the rootfs image:

  $ make


Result of the build
===================

After building, the output/images directory contains:

output/images/
├── bl31.bin
├── ddr_fw.bin -> /home/gilles/buildroot-dev/output/images/lpddr4_pmu_train_fw.bin
├── flash.bin
├── freescale
│   └── imx8mp-debix-model-a.dtb
├── genimage.cfg
├── Image
├── lpddr4_dmem_1d_v202201.bin
├── lpddr4_dmem_2d_v202201.bin
├── lpddr4_dmem_qb_v202201.bin
├── lpddr4_imem_1d_v202201.bin
├── lpddr4_imem_2d_v202201.bin
├── lpddr4_imem_qb_v202201.bin
├── lpddr4_pmu_train_1d_dmem_201904.bin
├── lpddr4_pmu_train_1d_dmem_202006.bin
├── lpddr4_pmu_train_1d_dmem.bin
├── lpddr4_pmu_train_1d_dmem_pad.bin
├── lpddr4_pmu_train_1d_fw.bin
├── lpddr4_pmu_train_1d_imem_201904.bin
├── lpddr4_pmu_train_1d_imem_202006.bin
├── lpddr4_pmu_train_1d_imem.bin
├── lpddr4_pmu_train_1d_imem_pad.bin
├── lpddr4_pmu_train_2d_dmem_201904.bin
├── lpddr4_pmu_train_2d_dmem_202006.bin
├── lpddr4_pmu_train_2d_dmem.bin
├── lpddr4_pmu_train_2d_dmem_pad.bin
├── lpddr4_pmu_train_2d_fw.bin
├── lpddr4_pmu_train_2d_imem_201904.bin
├── lpddr4_pmu_train_2d_imem_202006.bin
├── lpddr4_pmu_train_2d_imem.bin
├── lpddr4_pmu_train_2d_imem_pad.bin
├── lpddr4_pmu_train_fw.bin
├── lpddr4x_dmem_qb_v202306.bin
├── lpddr4x_dmem_qb_v202311.bin
├── lpddr4x_dmem_v202306.bin
├── lpddr4x_dmem_v202311.bin
├── lpddr4x_imem_qb_v202306.bin
├── lpddr4x_imem_qb_v202311.bin
├── lpddr4x_imem_v202306.bin
├── lpddr4x_imem_v202311.bin
├── rootfs.ext2
├── rootfs.ext4 -> rootfs.ext2
├── rootfs.tar
├── sdcard.img
├── u-boot.bin
└── u-boot-spl.bin


Flashing the SD card image
==========================

To install the image on a SDCard simply copy sdcard.img to the storage (e.g. SD, eMMC)

  $ sudo dd if=output/images/sdcard.img of=<your-sd-device>


Booting the board
=================

To boot your newly created system:
- insert the SD card in the SD slot of the board;
- if you use a Debix I/O daughter card, follow the instructions provided
in [2], section 3.1 for the hardware connection between the main board
and the I/O daughter card. Then, put a micro USB cable into the I/0 daughter card
Debug USB Port and connect using a terminal emulator at 115200 bps, 8n1;
- if you do not use a Debix I/O daughter card, connect a USB-to-TTL serial cable to
the 40-pin header (J2) on the main board, the following way:
    USB-to-TTL cable GND pin to J2 pin 05
    USB-to-TTL cable TX pin to J2 pin 09
    USB-to-TTL cable RX pin to J2 pin 11
    connect using a terminal emulator at 115200 bps, 8n1;
- power on the board.

Enjoy!


References
==========
[1] https://www.debix.io/Uploads/Temp/file/20250207/DEBIX%20User%20Manual-V3.5.pdf
[2] https://www.debix.io/Uploads/Temp/file/20241225/DEBIX%20IO%20Board%20User%20Manual-V1.1.pdf

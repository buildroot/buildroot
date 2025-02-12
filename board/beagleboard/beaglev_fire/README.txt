Beagle-V Fire
==============

BeagleV Fire is a low-cost RISC-V 64-bit based platform, powered by
Microchip's PolarFire SoC. This file describes how to use the
pre-defined Buildroot configuration for the Beagle-V Fire board.

Further information about the Beagle-V Fire can be found at
https://docs.beagleboard.org/latest/boards/beaglev/fire/index.html.


Building
========

Configure Buildroot using the default board configuration:

  '$ make beaglev_fire_defconfig'

Customise the build as necessary:

  '$ make menuconfig'

Start the build:

  '$ make'


Result of the build
===================

Once the build has finished you will have the following files:

    output/images/
    +-- boot.scr
    +-- boot.vfat
    +-- Image
    +-- Image.gz
    +-- beaglev_fire.itb
    +-- beaglev_fire.its
    +-- mpfs-beaglev-fire.dtb
    +-- payload.bin
    +-- rootfs.ext2
    +-- rootfs.ext4
    +-- rootfs.tar
    +-- sdcard.img
    +-- u-boot.bin


Flashing the image to your eMMC
===============================

By default Buildroot builds an image suitable for the eMMC. The first partition
of this image contains a U-Boot binary, embedded in a Hart Software Services
(HSS) payload. The second partition contains a FAT filesystem with a U-Boot env
and an ITB file containing the kernel and the device tree. The third partition
contains the file system. This image can be written directly to the eMMC.

To do so, follow the below steps:

1. Connect to BeagleV-Fire UART debug port using a 3.3v USB to UART bridge.

2. Now you can run `tio <port>` in a terminal window to access the UART debug
port connection.
  e.g `tio /dev/ttyUSB4`

3. Once you are connected properly, you can press the Reset button which will
show you a progress bar.

4. Press any key in the terminal application to stop the HSS from booting. This
will give you access to the HSS command line interface and a ">>" for input
will be displayed in the terminal.

5. Type `usbdmsc` in the HSS command line interface. The HSS `usbdmsc` command
exposes the eMMC as a USB mass storage device using the USB type C connector.
If successful, a message saying "USB Host connected" will be displayed.

6. The eMMC should now appear as mass storage device/drive on your host PC, as
it is mounted through your USB type C connector.

7. Now, all you need to do is dd the image to the eMMC, which can be done with
the following command on your development host:

  '$ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M'

You will have to replace /dev/sdX by the actual device name of your eMMC.
Please, be especially cautious not to overwrite the wrong drive as this cannot
be undone.

8. Once the image transfer has completed you can type `CTRL+C` to disconnect
your device.

9. Finally, type `boot` or reset your board to boot your new Linux image.

Customize BeagleV-Fire Cape Gateware Using Verilog (Optional)
=============================================================

To customize your Beagle-V Fire gateware please follow the guide below to
create your custom bitstream (steps 1 - 6):
https://docs.beagleboard.org/latest/boards/beaglev/fire/demos-and-tutorials/gateware/customize-cape-gateware-verilog.html


  Program BeagleV-Fire With Your Custom Bitstream with Buildroot
  ==============================================================

  After following the steps 1-6 from the above tutorial, you should now have a
  artifacts.zip file on your local host.

  Unzip the downloaded artifacts.zip file.

  Go to the custom FPGA design directory:
    'cd artifacts/bitstreams/my_custom_fpga_design/LinuxProgramming/'

  On your Linux host development computer, copy the bitstream to BeagleV-Fire
  board, replacing </path/to/your/> with the path to your BeagleV-Fire root file
  system.
    'cp ./* /path/to/your/buildroot/board/beagleboard/beaglev_fire/rootfs-overlay/lib/firmware/'

  To apply these changes to your image, make sure to re-build it with:
    `make`

  Then, re-flash your image - to ensure you have the necessary firmware files - by
  following the above section "Flashing the image to your eMMC".

  On BeagleV-Fire initiate the reprogramming of the FPGA with your gateware bitstream:
    `/usr/share/microchip/update-gateware.sh`

  Wait for a couple of minutes for the BeagleV-Fire to reprogram itself.

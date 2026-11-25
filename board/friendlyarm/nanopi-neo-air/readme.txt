NanoPi NEO Air

Intro
=====

This configuration builds a minimal system for the FriendlyELEC NanoPi
NEO Air (Allwinner H3, 512 MB RAM, 8 GB eMMC, AP6212 Wi-Fi/Bluetooth).
The same system boots from a micro SD card or from the eMMC.

The board has no Ethernet port. The console is on the debug UART pins,
115200 8N1.

FriendlyELEC NanoPi NEO Air link:
https://wiki.friendlyelec.com/wiki/index.php/NanoPi_NEO_Air

How to build it
===============

    $ make friendlyarm_nanopi_neo_air_defconfig
    $ make

The build creates two images in output/images:

 - sdcard.img, for the micro SD card;
 - emmc.img, for the eMMC.

They have the same content, but different partition IDs, so the board
can have a system on both at the same time.

The board boots from the micro SD card when it finds a system on it,
then from the eMMC.

Booting from a micro SD card
============================

Write output/images/sdcard.img to a micro SD card:

    $ sudo dd if=output/images/sdcard.img of=/dev/sdX bs=1M
    $ sudo sync

Insert the micro SD card in the board and power it up.

Booting from the eMMC
=====================

The eMMC is written over USB, in FEL mode: in this mode, the boot ROM
of the H3 waits for a PC on the micro USB port. The board enters it
when it finds no system on a micro SD card nor on the eMMC (e.g. a new
board).

 1. Connect the micro USB port to the PC, and power the board up in FEL
    mode:

    - when the eMMC is empty: without a micro SD card;
    - when the eMMC already has a system: with a micro SD card that only
      enters FEL mode (the board boots from the micro SD card first),
      written once with:

        $ sudo dd if=output/images/fel-sdboot.sunxi of=/dev/sdX bs=1024 seek=8

      Remove this micro SD card once U-Boot is loaded (step 2), before
      the board is powered off and on (step 4).

    For your convenience, a flash-emmc.sh script has been provided. It
    does steps 2 and 3: it waits for the board in FEL mode, loads
    U-Boot, waits for the USB disk and writes emmc.img to it:

        $ sudo board/friendlyarm/nanopi-neo-air/flash-emmc.sh output

 2. Load U-Boot and its FEL script (output/images/boot.scr) over USB:

        $ sudo output/host/bin/sunxi-fel -v \
            uboot output/images/u-boot-sunxi-with-spl.bin \
            write 0x43100000 output/images/boot.scr

    U-Boot runs the script, which exports the eMMC to the PC as a USB
    disk: a new disk appears on the PC (/dev/sdY).

 3. Check its name with lsblk, unmount it if it was mounted, and write
    the image to the whole disk (/dev/sdY, not a partition):

        $ sudo dd if=output/images/emmc.img of=/dev/sdY bs=1M conv=fsync status=progress

 4. Power the board off and on, without a micro SD card: it boots from
    the eMMC.

Wi-Fi
=====

    # modprobe brcmfmac
    # wpa_passphrase <SSID> <passphrase> > /etc/wpa_supplicant.conf
    # wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
    # udhcpc -i wlan0

Enjoy!

Lichee RV dock
===============

Lichee RV Dock is a RISC-V Linux development kits with high integration, small
size and affordable price designed for opensource developer. It's equipped with
HDMI interface and it supports many screen by its screen convert board. It's
also equipped with many peripherals, including a UAB-A port, 2.4G Wifi-BT module,
an analog microphone and a speaker jack interface.

How to build
============

$ make sipeed_lichee_rv_dock_defconfig
$ make

Wifi
==========

Edit board/sipeed/lichee_rv_dock/overlay/etc/wpa_supplicant.conf or
/etc/wpa_supplicant.conf once connected to the board:

* Replace YOURSSID with your AP ssid
* Replace YOURPASSWD with your AP password

Bluetooth
==========

To make the device discoverable and pairable, once connected to the board:

* bluetoothctl power on
* bluetoothctl discoverable yes
* bluetoothctl pairable yes

How to write the SD card
========================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Connect a TTL UART to the debug connector, insert the microSD card and
plug in a USB-C cable to the PWR connector to boot the system.

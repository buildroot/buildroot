Broadcom Northstar

Intro
=====

This readme covers Northstar family of Broadcom SoCs. It includes:
  - BCM4708 (2 x 800 MHz)
  - BCM47081 (1 x 800 MHz)
  - BCM4709 (2 x 1 GHz)
  - BCM47094 (2 x 1 GHz) (AKA BCM4709C0)

Northstar platform is used in some home routers by multiple vendors. There are
over 100 market devices based on it and they can all be supported with 1 kernel.

There is no point in having separated board for each model. This board code is
meant for all supported Northstar devices.

All Northstar devices come with CFE bootloader by default. It's basically closed
source as sources are available for some old releases only. There is no U-Boot (or
any other) drop-in replacement or second stage loader with Northstar support.

CFE supports flashing firmware images over TFTP and HTTP (depending on vendor /
device setup).

How to build it
===============

  $ make broadcom_northstar_defconfig

  $ make

How to flash over HTTP
======================

Power on device and press (and hold) CTRL+C in serial console terminal. When CFE
gets into prompt mode it'll automatically start built-in HTTP server. Navigate
to http://192.168.1.1/ (unless IP was changed - verify with "ifconfig") and
upload new firmware using a web browser.

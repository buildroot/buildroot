STM32F469 Discovery
===================

This tutorial describes how to use the predefined Buildroot
configuration for the STM32F469 Discovery evaluation platform.

Building
--------

  make stm32f469_disco_sd_defconfig
  make

Flashing
--------

  ./board/stmicroelectronics/stm32f469-disco/flash_sd.sh output/

It will flash the U-boot bootloader.

Creating SD card
----------------

Buildroot prepares an"sdcard.img" image in the output/images/ directory,
ready to be dumped on a SD card. Launch the following command as root:

  dd if=output/images/sdcard.img of=/dev/<your-sd-device>

*** WARNING! This will destroy all the card content. Use with care! ***

For details about the medium image layout and its content, see the
definition in board/stmicroelectronics/stm32f469-disco/genimage.cfg.

Framebuffer
-----------
After Linux boots, /dev/fb0 will be accessible. You can control the
brightness of the display after enabling the framebuffer by running the
following commands:

   # echo 0 0 > /sys/class/graphics/fb0/pan
   # echo 255 >/sys/class/backlight/40016c00.dsi.0/brightness

The brightness ranges from 0 to 255, as you can see running the
command:

   # cat /sys/class/backlight/40016c00.dsi.0/max_brightness

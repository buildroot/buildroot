#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

chown root:video /sys/class/graphics/fb0/blank
chmod 664 /sys/class/graphics/fb0/blank

chown root:video /sys/devices/virtual/vtconsole/vtcon1/bind
chmod 664 /sys/devices/virtual/vtconsole/vtcon1/bind

chown root:video /sys/class/backlight/board\:backlight/brightness
chmod 664 /sys/class/backlight/board\:backlight/brightness

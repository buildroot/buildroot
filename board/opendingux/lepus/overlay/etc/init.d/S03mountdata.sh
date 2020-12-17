#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data
mount /dev/mmcblk0p2 -o nosuid,nodev /media/data

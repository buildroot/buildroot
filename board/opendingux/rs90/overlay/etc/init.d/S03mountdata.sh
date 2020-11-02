#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data

mount --bind /media/data /media/data
mount --make-shared /boot
mount --make-slave /media/data
mount --bind /boot /media/data
mount -o remount,rw /media/data

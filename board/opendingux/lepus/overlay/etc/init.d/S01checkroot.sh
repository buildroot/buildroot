#!/bin/sh

if [ -z "$1" ] || [ "x$1" = "xstart" ]; then

	echo "Checking system partition for errors..."
	fsck.fat -a /dev/mmcblk0p1
fi

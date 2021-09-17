#!/bin/sh

if [ -z "$1" ] || [ "x$1" = "xstart" ]; then
	BOOT_PARTITION=$(sed -n 's/.*root=\([[:alnum:]:\/]\+\).*/\1/p' /proc/cmdline)

	if [ "$BOOT_PARTITION" = "/dev/mmcblk0p1" ] ; then
		psplash_write "Checking root FS for errors..."
		fsck.fat -a /dev/mmcblk0p1
	fi
fi

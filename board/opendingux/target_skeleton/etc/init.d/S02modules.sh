#!/bin/sh

case "$1" in
	start)
		psplash_write 'Mounting modules filesystem...'

		MODULES_FILESYSTEM=/boot/modules.squashfs
		if [ "`grep 'kernel_bak' /proc/cmdline`" ] ; then
			MODULES_FILESYSTEM=/boot/modules.squashfs.bak
		fi

		if [ "`grep '/lib/modules' /proc/mounts`" ] ; then
			echo 'Modules filesystem is already mounted' >&2
			exit 1
		fi

		if [ -r "$MODULES_FILESYSTEM" ] ; then
			mount -o loop "$MODULES_FILESYSTEM" /lib/modules
		fi
		;;

	stop)
		psplash_write 'Unmounting modules filesystem...'

		if [ "`grep '/lib/modules' /proc/mounts`" ] ; then
			umount /lib/modules
		fi
		;;

	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac

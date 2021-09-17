#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data

BOOT_PARTITION=$(sed -n 's/.*root=\([[:alnum:]:\/]\+\).*/\1/p' /proc/cmdline)

case "$BOOT_PARTITION" in
	/dev/mmcblk*)
		# Booting from MMC/SD. The first partition is the system,
		# the second partition is the data.
		DATA_PARTITION=${BOOT_PARTITION::-1}$(expr ${BOOT_PARTITION: -1} \+ 1)
		DATA_FS=$(blkid_fs $DATA_PARTITION)

		psplash_write "Mounting $DATA_PARTITION..."

		# Modprobe the module needed for the filesystem if needed.
		if [ -z "$(grep "$DATA_FS" /proc/filesystems)" ] ; then
			modprobe "$DATA_FS"
		fi

		mount $DATA_PARTITION -t $DATA_FS -o nosuid,nodev /media/data
		;;
	"")
		# Booting without a system partition - do nothing.
		;;
	*)
		# Booting with a merged system / data partition.
		# Create a read-write mountpoint of the partition to
		# /media/data.

		psplash_write "Mounting /media/data..."

		mount --bind /media/data /media/data
		mount --make-shared /boot
		mount --make-slave /media/data
		mount --bind /boot /media/data
		mount -o remount,rw /media/data
		;;
esac

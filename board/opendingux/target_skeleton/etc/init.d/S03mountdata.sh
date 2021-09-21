#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

mkdir -p /media/data

BOOT_PARTITION=$(sed -n 's/.*root=\([[:alnum:]:\/]\+\).*/\1/p' /proc/cmdline)
DATA_PARTITION=${BOOT_PARTITION::-1}$(expr ${BOOT_PARTITION: -1} \+ 1)

if [ -b "$DATA_PARTITION" ] ; then
	# If present, use the partition following the system partition
	# for the user data.

	psplash_write "Mounting $DATA_PARTITION..."

	DATA_FS=$(blkid_fs $DATA_PARTITION)

	# Modprobe the module needed for the filesystem if needed.
	if [ -z "$(grep "$DATA_FS" /proc/filesystems)" ] ; then
		modprobe "$DATA_FS"
	fi

	# Verify the filesystem for errors
	fsck -p $DATA_PARTITION

	mount $DATA_PARTITION -t $DATA_FS -o nosuid,nodev /media/data

elif [ "$BOOT_PARTITION" ] ; then
	# Booting with a merged system / data partition.
	# Create a read-write mountpoint of the partition to
	# /media/data.

	psplash_write "Mounting /media/data..."

	mount --bind /media/data /media/data
	mount --make-shared /boot
	mount --make-slave /media/data
	mount --bind /boot /media/data
	mount -o remount,rw /media/data
fi

#!/bin/sh

# $1: images directory path
# $2: device dts filename
# $3: board id
build_lxl() {
	local images="$1"
	local device="$2"
	local board="$3"

	$HOST_DIR/bin/lzma_alone e $images/zImage.$device $images/zImage.$device.lzma -d16
	rm -f $images/zImage.$device
	$HOST_DIR/bin/otrx create $images/$device.trx -f $images/zImage.$device.lzma -a 0x20000 -f $images/rootfs.ubi
	rm -f $images/zImage.$device.lzma
	$HOST_DIR/bin/lxlfw create $images/$device.lxl -i $images/$device.trx -b "$board"
}

# $1: images directory path
# $2: device dts filename
build_trx() {
	local images="$1"
	local device="$2"

	$HOST_DIR/bin/lzma_alone e $images/zImage.$device $images/zImage.$device.lzma -d16
	rm -f $images/zImage.$device
	$HOST_DIR/bin/otrx create $images/$device.trx -f $images/zImage.$device.lzma -a 0x20000 -f $images/rootfs.ubi
	rm -f $images/zImage.$device.lzma
}

devices="$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([^"]*\)"$/\1/p' ${BR2_CONFIG})"
for device in $devices; do
	device="${device#broadcom/}"
	case "$device" in
		"bcm4708-smartrg-sr400ac")
			build_trx "$1" "$device"
			;;
		"bcm47094-luxul-xwr-3150-v1")
			build_lxl "$1" "$device" "XWR-3150"
			;;
	esac
done

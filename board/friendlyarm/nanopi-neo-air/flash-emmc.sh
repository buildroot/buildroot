#!/bin/sh

# Write emmc.img to the eMMC of a NanoPi NEO Air in FEL mode.
# Usage: sudo board/friendlyarm/nanopi-neo-air/flash-emmc.sh [OUTPUT_DIR]

set -e

OUTPUT_DIR="${1:-output}"
IMAGES_DIR="${OUTPUT_DIR}/images"
SUNXI_FEL="${OUTPUT_DIR}/host/bin/sunxi-fel"

echo "Waiting for the board in FEL mode..."
until "${SUNXI_FEL}" ver 2>/dev/null | grep -q "(H3)"; do
	sleep 1
done

"${SUNXI_FEL}" -v \
	uboot "${IMAGES_DIR}/u-boot-sunxi-with-spl.bin" \
	write 0x43100000 "${IMAGES_DIR}/boot.scr"

# U-Boot exports the eMMC as a USB disk ("ums"): wait for it
echo "Waiting for the eMMC USB disk..."
DISK=""
while [ -z "${DISK}" ]; do
	sleep 1
	DISK=$(find /dev/disk/by-id -name 'usb-Linux_UMS_disk_*-0:0')
done

umount "${DISK}"-part* 2>/dev/null || true
dd if="${IMAGES_DIR}/emmc.img" of="${DISK}" bs=1M conv=fsync status=progress

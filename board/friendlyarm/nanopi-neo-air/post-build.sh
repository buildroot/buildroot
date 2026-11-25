#!/bin/sh

BOARD_DIR="$(dirname "$0")"

install -m 0644 -D "$BOARD_DIR"/extlinux.conf "$TARGET_DIR"/boot/extlinux/extlinux.conf

# The AP6212 NVRAM of linux-firmware, under the name brcmfmac looks for
ln -sf brcmfmac43430-sdio.AP6212.txt \
	"$TARGET_DIR"/lib/firmware/brcm/brcmfmac43430-sdio.friendlyarm,nanopi-neo-air.txt

#!/bin/bash

set -u
set -e

echo "Post-build: processing $@"

BOARD_DIR="$(dirname $0)"

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi

# Copy keymap for Arris remote
if [ -f "${BOARD_DIR}/arris-ir-remote.json" ]; then
	mkdir -p "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/"
	cp -pf "${BOARD_DIR}/arris-ir-remote.json" "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/ir-remote.json"
fi

mkdir -p "${TARGET_DIR}/boot"
grep -q '^/dev/sda1' "${TARGET_DIR}/etc/fstab" || \
	echo -e '/dev/sda1 /boot vfat defaults 0 0' >> "${TARGET_DIR}/etc/fstab"

mkdir -p "${TARGET_DIR}/root"
grep -q '^/dev/sda2' "${TARGET_DIR}/etc/fstab" || \
	echo -e '/dev/sda2 /root ext4 defaults 0 0' >> "${TARGET_DIR}/etc/fstab"

install -m 0755 -D board/arris/S30mountroot \
	${TARGET_DIR}/etc/init.d/S30mountroot

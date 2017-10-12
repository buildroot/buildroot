#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi

# update fstab in order to mount harddrive as root
# NOTE: Temporary change for demo
if [ -f "${TARGET_DIR}/etc/fstab" ]; then
        echo "/dev/sda1 /root   ext4    defaults        0       0" >> ${TARGET_DIR}/etc/fstab
fi

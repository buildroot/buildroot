#!/bin/bash

set -u
set -e

echo "Post-build: processing $@"

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
	grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

BOARD_DIR="$(dirname $0)"

# Add Gstreamer software based AC3 Decoder
if [ -f "${BOARD_DIR}/libgstfluac3dec.so" ]; then
	mkdir -p "${TARGET_DIR}/usr/lib/gstreamer-1.0/"
	cp -pf "${BOARD_DIR}/libgstfluac3dec.so" "${TARGET_DIR}/usr/lib/gstreamer-1.0/"
fi

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/www/"
fi

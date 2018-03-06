#!/bin/bash

set -u
set -e

echo "Post-build: processing $@"

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

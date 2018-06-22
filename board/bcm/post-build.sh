#!/bin/bash


set -u
set -e

echo "Post-build: processing $@"

BOARD_DIR="$(dirname $0)"

# Copy index.html page for WPE Framework
if [ -f "${BOARD_DIR}/index.html" ]; then
	mkdir -p "${TARGET_DIR}/var/www/"
	cp -pf "${BOARD_DIR}/index.html" "${TARGET_DIR}/var/www/"
fi

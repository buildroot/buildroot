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

source="kaon-ir-remote.json"
destination="ir-remote.json"
echo "Add keymap ${source} as ${destination}"
mkdir -p "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl"
cp -pf "${BOARD_DIR}/${source}" "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/${destination}"

#!/bin/bash

set -u
set -e

echo "Post-build: processing $@"

BOARD_DIR="$(dirname $0)"

# Copy keymap for Arris remote
if [ -f "${BOARD_DIR}/arris-ir-remote.json" ]; then
	mkdir -p "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/"
	cp -pf "${BOARD_DIR}/arris-ir-remote.json" "${TARGET_DIR}/usr/share/WPEFramework/RemoteControl/ir-remote.json"
fi

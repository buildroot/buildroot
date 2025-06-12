#!/usr/bin/env bash
set -e

BOARD_DIR="$(dirname "$0")"
gzip -fk "${BINARIES_DIR}/Image"
install -m 0644 -D "$BOARD_DIR/extlinux.conf" "$BINARIES_DIR/extlinux/extlinux.conf"
support/scripts/genimage.sh -c board/coolpi/coolpi-4b/genimage.cfg

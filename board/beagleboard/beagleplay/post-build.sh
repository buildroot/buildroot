#!/bin/sh -x

BOARD_DIR="$(dirname "$0")"

install -m 0644 -D "$BOARD_DIR"/extlinux.conf "$BINARIES_DIR"/extlinux.conf

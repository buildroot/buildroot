#!/bin/sh

BOARD_DIR="$(dirname "$0")"

ln -sf tispl.bin_unsigned "$BINARIES_DIR"/tispl.bin

install -m 0644 -D "$BOARD_DIR"/extlinux.conf "$BINARIES_DIR"/extlinux/extlinux.conf

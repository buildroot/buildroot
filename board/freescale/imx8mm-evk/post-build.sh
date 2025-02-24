#!/bin/sh
BOARD_DIR="$(dirname "$0")"
PARTUUID="$("$HOST_DIR"/bin/uuidgen)"

install -d "$TARGET_DIR/boot/extlinux/"
sed "s/%PARTUUID%/$PARTUUID/g" "$BOARD_DIR/extlinux.conf.in" > "$TARGET_DIR/boot/extlinux/extlinux.conf"
sed "s/%PARTUUID%/$PARTUUID/g" "$BOARD_DIR/genimage.cfg.in" > "$BINARIES_DIR/genimage.cfg"

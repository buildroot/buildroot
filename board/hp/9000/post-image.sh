#!/bin/sh
set -eu

BOARD_DIR="$(dirname "$0")"

# Generate a random 32-bit signature for the disk image and
# substitute it in genimage configuration file and palo script.
PARTUUID="$("$HOST_DIR"/bin/uuidgen -r |sed 's/-.*//')"

sed "s/%PARTUUID%/$PARTUUID/g" "$BOARD_DIR/genimage.cfg.in" \
	> "$BINARIES_DIR/genimage.cfg"

sed "s/%PARTUUID%/$PARTUUID/g" "$BOARD_DIR/palo.sh.in" \
	> "$BINARIES_DIR/palo.sh"

chmod +x "$BINARIES_DIR/palo.sh"

#!/bin/sh
set -eu

# Copy the firmware for the SPI NOR flash into the filesystem.
install -v -D -m 0644 "$BINARIES_DIR/u-boot-rockchip-spi.bin" \
	"$TARGET_DIR/lib/firmware/u-boot-rockchip-spi.bin"

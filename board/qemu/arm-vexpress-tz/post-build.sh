#!/bin/sh

set -u
set -e

# Create flash.bin TF-A FIP image from bl1.bin and fip.bin
cd "$BINARIES_DIR"
dd if=bl1.bin of=flash.bin bs=4096
dd if=fip.bin of=flash.bin seek=64 bs=4096 conv=notrunc

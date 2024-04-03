#!/bin/bash
BOARD_DIR="$CONFIG_DIR"/board/pine64/star64

# Add header to the SPL
"$HOST_DIR"/bin/spl_tool -c -f "$BINARIES_DIR"/u-boot-spl.bin

# Create the u-boot FIT image
cp "$BOARD_DIR"/star64-uboot-fit-image.its "$BINARIES_DIR"
mkimage -f "$BINARIES_DIR"/star64-uboot-fit-image.its -A riscv -O u-boot -T firmware "$BINARIES_DIR"/opensbi_uboot_payload.img

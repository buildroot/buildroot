#!/bin/sh

if [ -d "$BINARIES_DIR/efi-part/" ]; then
    sed -i 's%tty1%ttyS0,115200%' "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
else
    sed -i 's%tty1%ttyS0,115200%' "$TARGET_DIR/boot/grub/grub.cfg"
fi

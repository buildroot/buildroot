#!/bin/sh

set -e

BOARD_DIR=$(dirname "$0")

# Detect boot strategy, EFI or BIOS
if [ -d "$BINARIES_DIR/efi-part/" ]; then
    cp -f "$BOARD_DIR/grub-efi.cfg" "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
else
    cp -f "$BOARD_DIR/grub-bios.cfg" "$TARGET_DIR/boot/grub/grub.cfg"
    # Copy grub 1st stage to binaries, required for genimage
    cp -f "$TARGET_DIR/lib/grub/i386-pc/boot.img" "$BINARIES_DIR"
fi

# When post-build script is runing $BR2_TARGET_GRUB2_BUILTIN_CONFIG_PC is unset, so parce Buildroot .config file again
GRUB2_BUILTIN_CONFIG_PC="`grep --only-matching --perl-regex "(?<=BR2_TARGET_GRUB2_BUILTIN_CONFIG_PC\=).*" $BR2_CONFIG`"
# Using the native shell prefix/suffix removal feature (see also qstrip)
GRUB2_BUILTIN_CONFIG_PC="${GRUB2_BUILTIN_CONFIG_PC%\"}"
GRUB2_BUILTIN_CONFIG_PC="${GRUB2_BUILTIN_CONFIG_PC#\"}"
if [ -z "$GRUB2_BUILTIN_CONFIG_PC" ]; then #if user doesn't use his .config for grub
    # Set time to wait 5 s for keyboard input before booting by default
    sed -i -e '1 s/^/set default="0"\nset timeout="5"\n\n/;' "$TARGET_DIR/boot/grub/grub.cfg"
#else if user use his .config for grub
# to configure bootloader put something like
#  set default="0"
#  set timeout="5"
# to your file located $BR2_TARGET_GRUB2_BUILTIN_CONFIG_PC 
# More info https://www.gnu.org/software/grub/manual/grub
fi

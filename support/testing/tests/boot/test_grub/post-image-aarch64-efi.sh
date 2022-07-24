#!/bin/sh

set -e

UUID=$(dumpe2fs "$BINARIES_DIR/rootfs.ext2" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')
sed "s/UUID_TMP/$UUID/g" support/testing/tests/boot/test_grub/grub-aarch64-efi.cfg > "$BINARIES_DIR/efi-part/EFI/BOOT/grub.cfg"
sed "s/UUID_TMP/$UUID/g" support/testing/tests/boot/test_grub/genimage-aarch64-efi.cfg > "$BINARIES_DIR/genimage-aarch64-efi.cfg"
support/scripts/genimage.sh -c "$BINARIES_DIR/genimage-aarch64-efi.cfg"

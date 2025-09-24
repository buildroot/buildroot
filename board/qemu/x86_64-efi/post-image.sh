#!/bin/sh

BOARD_DIR="$(dirname "$0")"

PARTUUID=$(dumpe2fs "${BINARIES_DIR}/rootfs.ext2" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')
sed "s/%PARTUUID%/$PARTUUID/g" "${BOARD_DIR}/grub.cfg.in" > "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"
sed "s/%PARTUUID%/$PARTUUID/g" "${BOARD_DIR}/genimage.cfg.in" > "${BINARIES_DIR}/genimage.cfg"
support/scripts/genimage.sh -c "${BINARIES_DIR}/genimage.cfg"

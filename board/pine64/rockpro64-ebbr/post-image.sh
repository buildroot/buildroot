#!/bin/sh
set -eu

BOARD_DIR=$(dirname "$0")

# Override the default GRUB configuration file with our own.
cp -vf "${BOARD_DIR}/grub.cfg" "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"

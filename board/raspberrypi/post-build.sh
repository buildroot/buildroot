#!/bin/sh

set -u
set -e

if grep -q "^BR2_TARGET_ROOTFS_INITRAMFS=y$" "${BR2_CONFIG}"; then

mkdir -p "${TARGET_DIR}/boot"
grep -q '^/dev/mmcblk0p1' "${TARGET_DIR}/etc/fstab" || \
    echo '/dev/mmcblk0p1 /boot vfat defaults 0 0' >> "${TARGET_DIR}/etc/fstab"

mkdir -p "${TARGET_DIR}/root"
grep -q '^/dev/mmcblk0p2' "${TARGET_DIR}/etc/fstab" || \
    echo '/dev/mmcblk0p2 /root ext4 defaults 0 0' >> "${TARGET_DIR}/etc/fstab"

fi

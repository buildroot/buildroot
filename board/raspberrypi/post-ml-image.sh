#!/bin/sh

BOARD_DIR="$(dirname $0)"

# Mark the kernel as DT-enabled
mkdir -p "${BINARIES_DIR}/kernel-marked"
${HOST_DIR}/usr/bin/mkknlimg "${BINARIES_DIR}/zImage" \
	"${BINARIES_DIR}/kernel-marked/zImage"

echo "Updating the config and cmdline files"
cp -af ${BOARD_DIR}/config.txt ${BINARIES_DIR}/rpi-firmware/
cp -af ${BOARD_DIR}/cmdline.txt ${BINARIES_DIR}/rpi-firmware/

INITRAMFS="$(grep ^BR2_TARGET_ROOTFS_INITRAMFS=y ${BR2_CONFIG})"
ROOTFS_CPIO="$(grep ^BR2_TARGET_ROOTFS_CPIO=y ${BR2_CONFIG})"

if [ "x${INITRAMFS}" = "x" ] && [ "x${ROOTFS_CPIO}" != "x" ];
then
sed -i /\#initramfs/initramfs/ ${BINARIES_DIR}/rpi-firmware/config.txt
CPIO_XZ=$(grep ^BR2_TARGET_ROOTFS_CPIO_XZ=y ${BR2_CONFIG})
CPIO_GZIP=$(grep ^BR2_TARGET_ROOTFS_CPIO_GZIP=y ${BR2_CONFIG})
if [ "x${CPIO_XZ}" != "x" ]; then
sed -i /rootfs.cpio/rootfs.cpio.xz/ ${BINARIES_DIR}/rpi-firmware/config.txt
elif [ "x${CPIO_GZIP}" != "x" ]; then
sed -i /rootfs.cpio/rootfs.cpio.gz/ ${BINARIES_DIR}/rpi-firmware/config.txt
fi
fi

#!/bin/sh
BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"
ROOTFS_FILES="${BINARIES_DIR}/rootfs.files"
STAR="*"

# Clean up target
rm -rf "${TARGET_DIR}/usr/lib/libstdc++.so.6.0.22-gdb.py"
rm -rf "${TARGET_DIR}/etc/ssl/man"

# Temp rootfs dir
mkdir -p "${ROOTFS_DIR}"

# Create files list for rsync
rm -rf "${ROOTFS_FILES}"
while read line
do
	find "${TARGET_DIR}" -name "$line$STAR" -printf "%P\n" >> "${ROOTFS_FILES}"
done < "${BOARD_DIR}/explora.txt"

# Append missing folders
echo "usr/lib/gstreamer-1.0" >> "${ROOTFS_FILES}"
echo "usr/lib/gio" >> "${ROOTFS_FILES}"
echo "usr/share/X11" >> "${ROOTFS_FILES}"
echo "usr/share/mime" >> "${ROOTFS_FILES}"
echo "usr/share/ignition" >> "${ROOTFS_FILES}"
echo "etc/playready" >> "${ROOTFS_FILES}"
echo "etc/ssl" >> "${ROOTFS_FILES}"
echo "etc/fonts" >> "${ROOTFS_FILES}"

rsync -ar --files-from="${ROOTFS_FILES}" "${TARGET_DIR}" "${ROOTFS_DIR}"

# Default font
mkdir -p "${ROOTFS_DIR}/usr/share/fonts/ttf-bitstream-vera"
cp -f "${TARGET_DIR}/usr/share/fonts/ttf-bitstream-vera/Vera.ttf" "${ROOTFS_DIR}/usr/share/fonts/ttf-bitstream-vera/"

# move utility lib of brcm plugin to usr/lib
mv "${ROOTFS_DIR}/usr/lib/gstreamer-1.0/libbrcmgstutil.so" "${ROOTFS_DIR}/usr/lib/"

# WPEFramework launcher
cp -pf "${BOARD_DIR}/wpeframework.sh" "${ROOTFS_DIR}"

# WebServer path
mkdir -p "${ROOTFS_DIR}/www"

# Create tar
tar -cvf "${BINARIES_DIR}/explora.tar" -C "${ROOTFS_DIR}" .

# Cleaning up
rm -rf "${ROOTFS_FILES}"
rm -rf "${ROOTFS_DIR}"

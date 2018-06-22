#!/bin/sh
BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"
ROOTFS_INSTALL_DIR="${ROOTFS_DIR}/home/metrological"
ROOTFS_FILES="${BINARIES_DIR}/rootfs.files"
STAR="*"

# Clean up target
rm -rf "${TARGET_DIR}/usr/lib/gstreamer-1.0/include"
rm -rf "${TARGET_DIR}/usr/lib/libstdc++.so.6.0.20-gdb.py"
rm -rf "${TARGET_DIR}/etc/ssl/man"

# Temp rootfs dir
mkdir -p "${ROOTFS_DIR}/usr/bin"
mkdir -p "${ROOTFS_INSTALL_DIR}"

# Create files list for rsync
rm -rf "${ROOTFS_FILES}"
while read line
do
	find "${TARGET_DIR}" -name "$line$STAR" -printf "%P\n" >> "${ROOTFS_FILES}"
done < "${BOARD_DIR}/vss.txt"

# Append missing folders
echo "usr/lib/gstreamer-1.0" >> "${ROOTFS_FILES}"
echo "usr/lib/gio" >> "${ROOTFS_FILES}"

rsync -ar --files-from="${ROOTFS_FILES}" "${TARGET_DIR}" "${ROOTFS_INSTALL_DIR}"

# select general libs that need priority over default version on the box
mkdir -p "${ROOTFS_INSTALL_DIR}/usr/ml_libs/gstreamer-1.0"
find "${ROOTFS_INSTALL_DIR}/usr/lib/" -maxdepth 1 -name "libgst*" -exec mv {} "${ROOTFS_INSTALL_DIR}/usr/ml_libs/" \;
find "${ROOTFS_INSTALL_DIR}/usr/lib/" -maxdepth 1 -name "libbrcm*" -exec mv {} "${ROOTFS_INSTALL_DIR}/usr/ml_libs/" \;
mv -f "${ROOTFS_INSTALL_DIR}/usr/lib/gstreamer-1.0" "${ROOTFS_INSTALL_DIR}/usr/ml_libs/"
# workaround to prevent mixing libs and slow HTTPS
find "${TARGET_DIR}/usr/lib/" -maxdepth 1 -name "libsoup*" -exec cp -pf {} "${ROOTFS_INSTALL_DIR}/usr/ml_libs/" \;


# WPEFramework launcher
cp -apf "${BOARD_DIR}/start.vss.sh" "${ROOTFS_DIR}/usr/bin/wpe"

# Create tar
tar -cvf "${BINARIES_DIR}/vss.tar" -C "${ROOTFS_DIR}" .

# Cleaning up
rm -rf "${ROOTFS_FILES}"
rm -rf "${ROOTFS_DIR}"

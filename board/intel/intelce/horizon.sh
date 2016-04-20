#!/bin/sh

BOARD_DIR="$(dirname $0)"
ROOTFS_DIR="${BINARIES_DIR}/../rootfs"
STAR="*"

rm -rf ${BINARIES_DIR}/filter.rootfs

while read line
do
	find "${TARGET_DIR}" -name "$line$STAR" -printf "%P\n" >> "${BINARIES_DIR}/filter.rootfs"
done < "${BOARD_DIR}/horizon.txt"

mkdir -p "${ROOTFS_DIR}"

rsync -av --files-from="${BINARIES_DIR}/filter.rootfs" "${TARGET_DIR}" "${ROOTFS_DIR}"
rsync -av "${TARGET_DIR}/usr/lib/gstreamer-1.0" "${ROOTFS_DIR}/usr/lib"
rsync -av "${TARGET_DIR}/usr/lib/gio" "${ROOTFS_DIR}/usr/lib"
rsync -av "${TARGET_DIR}/usr/lib/webbridge" "${ROOTFS_DIR}/usr/lib"
rsync -av "${TARGET_DIR}/usr/share/X11" "${ROOTFS_DIR}/usr/share"
rsync -av "${TARGET_DIR}/usr/share/fonts" "${ROOTFS_DIR}/usr/share"
rsync -av "${TARGET_DIR}/usr/share/webbridge" "${ROOTFS_DIR}/usr/share"
rsync -av "${TARGET_DIR}/usr/share/mime" "${ROOTFS_DIR}/usr/share"
rsync -av "${TARGET_DIR}/etc/playready" "${ROOTFS_DIR}/etc"
rsync -av "${TARGET_DIR}/etc/ssl" "${ROOTFS_DIR}/etc"
rsync -av "${TARGET_DIR}/etc/webbridge" "${ROOTFS_DIR}/etc"
rsync -av "${TARGET_DIR}/etc/fonts" "${ROOTFS_DIR}/etc"

mkdir -p "${ROOTFS_DIR}/root/Netflix/dpi"
ln -sfn /usr/share/fonts/netflix "${ROOTFS_DIR}/root/Netflix/fonts" && ln -sfn /etc/playready "${ROOTFS_DIR}/root/Netflix/dpi/playready"

mkdir -p "${ROOTFS_DIR}/NDS/config"
cp -Rpf "${BOARD_DIR}/horizon/usb_script.sh" "${ROOTFS_DIR}/NDS"
cp -Rpf "${BOARD_DIR}/horizon/app_start.cfg" "${ROOTFS_DIR}/NDS"
cp -Rpf "${BOARD_DIR}/horizon/diag.cfg" "${ROOTFS_DIR}/NDS/config"
cp -Rpf "${BOARD_DIR}/horizon/webbridge" "${ROOTFS_DIR}/NDS"
cp -Rpf "${BOARD_DIR}/horizon/webbridge-stub" "${ROOTFS_DIR}/NDS"

mkdir -p "${ROOTFS_DIR}/www"

rm -rf "${ROOTFS_DIR}/usr/lib/gstreamer-1.0/include"
rm -rf "${ROOTFS_DIR}/usr/lib/libstdc++.so.6.0.20-gdb.py"
rm -rf "${ROOTFS_DIR}/etc/ssl/man"

tar -cvf "${BINARIES_DIR}/horizon.tar" -C "${ROOTFS_DIR}" .

rm -rf "${BINARIES_DIR}/filter.rootfs"
rm -rf "${ROOTFS_DIR}"

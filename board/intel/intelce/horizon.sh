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

rsync -av --files-from="${BINARIES_DIR}/filter.rootfs" ${TARGET_DIR} ${ROOTFS_DIR}
rsync -av "${TARGET_DIR}/usr/share/webbridge" "${ROOTFS_DIR}/usr/share/webbridge"
rsync -av "${TARGET_DIR}/etc/webbridge" "${ROOTFS_DIR}/etc/webbridge"

tar -cvf "${BINARIES_DIR}/horizon.tar" -C "${ROOTFS_DIR}" .

rm -rf "${BINARIES_DIR}/filter.rootfs"
rm -rf "${ROOTFS_DIR}"

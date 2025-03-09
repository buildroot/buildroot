#!/bin/sh

set -e

BOARD_DIR="$(dirname "$0")"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"
rm -rf "${GENIMAGE_TMP}"

cp "${BINARIES_DIR}"/Image "${BINARIES_DIR}"/*.dtb "${BINARIES_DIR}"/fw_dynamic.bin "${ROOTPATH_TMP}"
cp -a "${BINARIES_DIR}"/bootbins/* "${ROOTPATH_TMP}"
cp -a "${BOARD_DIR}"/extlinux "${ROOTPATH_TMP}"

genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?

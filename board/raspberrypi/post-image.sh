#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# generate genimage from template if a board specific variant doesn't exists
if [ ! -e "${GENIMAGE_CFG}" ]; then
	GENIMAGE_CFG="${BINARIES_DIR}/genimage.cfg"
	FILES=()

	for i in "${BINARIES_DIR}"/*.dtb "${BINARIES_DIR}"/rpi-firmware/*; do
		FILES+=( "${i#${BINARIES_DIR}/}" )
	done

	KERNEL=$(sed -n 's/^kernel=//p' "${BINARIES_DIR}/rpi-firmware/config.txt")
	FILES+=( "${KERNEL}" )

	BOOT_FILES=$(printf '\\t\\t\\t"%s",\\n' "${FILES[@]}")
	sed "s|#BOOT_FILES#|${BOOT_FILES}|" "${BOARD_DIR}/genimage.cfg.in" \
		> "${GENIMAGE_CFG}"
fi

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?

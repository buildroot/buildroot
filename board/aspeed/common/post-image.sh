#!/bin/bash

BOARD_DIR="$(dirname $0)"
mkimage=$HOST_DIR/bin/mkimage

BOARD_DT=$(sed -n \
           's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([a-z0-9\-]*\).*"$/\1/p' \
           ${BR2_CONFIG})

sed -e "s/%BOARD_DTB%/${BOARD_DT}.dtb/" \
    $BOARD_DIR/image.its.template > $BINARIES_DIR/image.its

(cd $BINARIES_DIR && $mkimage -f image.its image.itb)

GENIMAGE_CFG="board/aspeed/${BOARD_DT#aspeed-*}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

rm -rf "${GENIMAGE_TMP}"

genimage \
  --rootpath "${TARGET_DIR}" \
  --tmppath "${GENIMAGE_TMP}" \
  --inputpath "${BINARIES_DIR}" \
  --outputpath "${BINARIES_DIR}" \
  --config "${GENIMAGE_CFG}"

rm -f $BINARIES_DIR/image.its

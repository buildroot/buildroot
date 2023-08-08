#!/bin/sh
HSS_PAYLOAD_GENERATOR=${HOST_DIR}/bin/hss-payload-generator
MKIMAGE=${HOST_DIR}/bin/mkimage

"${HSS_PAYLOAD_GENERATOR}" -c board/microchip/mpfs_icicle/config.yaml "${BINARIES_DIR}"/payload.bin
cp board/microchip/mpfs_icicle/mpfs_icicle.its "${BINARIES_DIR}"/mpfs_icicle.its
(cd "${BINARIES_DIR}" && "${MKIMAGE}" -f mpfs_icicle.its mpfs_icicle.itb)
support/scripts/genimage.sh -c board/microchip/mpfs_icicle/genimage.cfg

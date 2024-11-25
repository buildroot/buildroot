#!/bin/bash
set -e

HSS_PAYLOAD_GENERATOR="${HOST_DIR}"/bin/hss-payload-generator
MKIMAGE="${HOST_DIR}"/bin/mkimage
BOARD_DIR="$(pwd)"/"${0%/*}"

pushd "${BINARIES_DIR}"
"${HSS_PAYLOAD_GENERATOR}" -c "${BOARD_DIR}"/config.yaml payload.bin
cp "${BOARD_DIR}"/beaglev_fire.its "${BINARIES_DIR}"/beaglev_fire.its
gzip -9 Image -c > Image.gz
"${MKIMAGE}" -f beaglev_fire.its beaglev_fire.itb
popd
support/scripts/genimage.sh -c "${BOARD_DIR}"/genimage.cfg

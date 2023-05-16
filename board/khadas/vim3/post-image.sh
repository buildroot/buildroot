#!/bin/sh

BOARD_DIR="$(dirname "$0")"

support/scripts/genimage.sh -c "${BOARD_DIR}/genimage.cfg"

AMLOGIC_DIR=${BINARIES_DIR}/amlogic-boot-fip
FIP_DIR=${BINARIES_DIR}/fip

mkdir -p "${FIP_DIR}"

(cd "${AMLOGIC_DIR}" && \
	./build-fip.sh khadas-vim3 \
	"${BINARIES_DIR}"/u-boot.bin \
	"${FIP_DIR}")

dd if="${FIP_DIR}"/u-boot.bin.sd.bin \
   of="${BINARIES_DIR}"/sdcard.img \
   conv=fsync,notrunc bs=1 count=444

dd if="${FIP_DIR}"/u-boot.bin.sd.bin \
   of="${BINARIES_DIR}"/sdcard.img \
   conv=fsync,notrunc bs=512 skip=1 seek=1

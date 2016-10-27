#!/bin/sh
BOARD_DIR="$(dirname $0)"
${BOARD_DIR}/eos-package-utility/arris_package_oe.sh  ${BINARIES_DIR} zImage.cpio.xz

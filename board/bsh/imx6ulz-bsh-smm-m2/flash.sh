#!/bin/bash

if [ $# -eq 0 ]; then
    OUTPUT_DIR=output
else
    OUTPUT_DIR=$1
fi

if ! test -d "${OUTPUT_DIR}" ; then
    echo "ERROR: no output directory specified."
    echo "Usage: $0 OUTPUT_DIR"
    echo ""
    echo "Arguments:"
    echo "    OUTPUT_DIR    The Buildroot output directory."
    exit 1
fi

IMAGES_DIR="${OUTPUT_DIR}/images"

"${OUTPUT_DIR}"/host/bin/uuu -v -b "${IMAGES_DIR}/nand-full.lst" \
  "${IMAGES_DIR}/u-boot-with-spl.imx" \
  "${IMAGES_DIR}/u-boot-with-spl.imx" \
  "${IMAGES_DIR}/rootfs.ubifs" \
  "${IMAGES_DIR}/zImage" \
  "${IMAGES_DIR}/imx6ulz-bsh-smm-m2.dtb"

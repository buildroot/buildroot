#!/bin/sh

echo "Updating the zImage to load the device tree"
${HOST_DIR}/usr/bin/mkknlimg ${BINARIES_DIR}/zImage ${BINARIES_DIR}/zImage-dt

#!/bin/sh

# This is a temporary work around for generating kd240 u-boot.itb.
# The problem is there is no way to currently configure u-boot to apply
# the carrier board dtb overlay during build, so all kd240 carrier board
# drivers are missing.
# This will be removed when u-boot can build the kd240 u-boot.itb natively.

UBOOT_DIR="$4"

fdtoverlay -o "${UBOOT_DIR}/fit-dtb.blob" \
	   -i "${UBOOT_DIR}/arch/arm/dts/zynqmp-smk-k24-revA.dtb" \
	   "${UBOOT_DIR}/arch/arm/dts/zynqmp-sck-kd-g-revA.dtbo"

"${UBOOT_DIR}/tools/mkimage" -E -f "${UBOOT_DIR}/u-boot.its" \
			     -B 0x8 "${BINARIES_DIR}/u-boot.itb"

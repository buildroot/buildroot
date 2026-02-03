#!/usr/bin/env bash

# VERY IMPORTANT: a lot of this code here is hardcoded such that
# it's able to generate a flash.bin equivalent to the one generated
# by imx-mkimage by running:
#
#  make SOC=iMX95 OEI=YES LPDDR_TYPE=lpddr4x flash_a55
#
# As such, please be mindful of the fact that this script may not work
# if you wish to change the make target or one of its parameters.

set -eu

main ()
{
	CNTR_VERSION=2
	ATF_LOAD_ADDR=0x8A200000
	UBOOT_LOAD_ADDR=0x90200000
	OEI_M33_ENTR_ADDR=0x1ffc0001
	OEI_M33_LOAD_ADDR=0x1ffc0000
	MCU_TCM_ADDR=0x1FFC0000
	SPL_LOAD_ADDR_M33_VIEW=0x20480000
	V2X_DDR=0x8b000000

	# generate u-boot-hash.bin
	"${HOST_DIR}/bin/mkimage_imx8" -commit > "${BINARIES_DIR}/mkimg.commit"
	cat "${BINARIES_DIR}/u-boot.bin" "${BINARIES_DIR}/mkimg.commit" > "${BINARIES_DIR}/u-boot-hash.bin"
	rm -f "${BINARIES_DIR}/mkimg.commit"

	# generate u-boot-atf-container.img (no TEE support for now)
	"${HOST_DIR}/bin/mkimage_imx8" -soc IMX9 -cntr_version ${CNTR_VERSION} -c \
		-ap "${BINARIES_DIR}/bl31.bin" a55 ${ATF_LOAD_ADDR} \
		-ap "${BINARIES_DIR}/u-boot-hash.bin" a55 ${UBOOT_LOAD_ADDR} \
		-out "${BINARIES_DIR}/u-boot-atf-container.img"

	# generate m33-oei-ddrfw.bin
	dd if="${BINARIES_DIR}/oei-m33-ddr.bin" of="${BINARIES_DIR}/oei-m33-ddr.bin-pad" bs=4 conv=sync
	cat "${BINARIES_DIR}/oei-m33-ddr.bin-pad" "${BINARIES_DIR}/ddr_fw.bin" > "${BINARIES_DIR}/m33-oei-ddrfw.bin.unaligned"
	dd if="${BINARIES_DIR}/m33-oei-ddrfw.bin.unaligned" of="${BINARIES_DIR}/m33-oei-ddrfw.bin" bs=8 conv=sync
	rm -f "${BINARIES_DIR}/m33-oei-ddrfw.bin.unaligned" "${BINARIES_DIR}/oei-m33-ddr.bin-pad"

	# generate flash.bin
	"${HOST_DIR}/bin/mkimage_imx8" -soc IMX9 -cntr_version ${CNTR_VERSION} \
		-append "${BINARIES_DIR}/ahab-container.img" -c -ddr_dummy \
		-oei "${BINARIES_DIR}/m33-oei-ddrfw.bin" m33 ${OEI_M33_ENTR_ADDR} ${OEI_M33_LOAD_ADDR} -hold 65536 \
		-msel 0 \
		-m33 "${BINARIES_DIR}/m33_image.bin" 0 ${MCU_TCM_ADDR} \
		-ap "${BINARIES_DIR}/u-boot-spl.bin" a55 ${SPL_LOAD_ADDR_M33_VIEW} \
		-dummy ${V2X_DDR} \
		-out "${BINARIES_DIR}/flash.bin"

	# append u-boot-atf-container.img to flash.bin
	flashbin_size="$(wc -c "${BINARIES_DIR}/flash.bin" | awk '{print $1}')"
	pad_cnt=$(($((flashbin_size + 0x400 - 1)) / 0x400))
	dd if="${BINARIES_DIR}/u-boot-atf-container.img" of="${BINARIES_DIR}/flash.bin" bs=1K seek=${pad_cnt}

	exit $?
}

main "$@"

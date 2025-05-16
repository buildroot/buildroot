#!/usr/bin/env bash

main ()
{
	SPL_LOAD_ADDR=0x2049A000
	ATF_LOAD_ADDR=0x204E0000
	if grep -Eq "^BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX91=y$" "${BR2_CONFIG}"; then
		SPL_LOAD_ADDR=0x204A0000
		ATF_LOAD_ADDR=0x204C0000
	fi

	dd if="${BINARIES_DIR}/u-boot-spl.bin" of="${BINARIES_DIR}/u-boot-spl-padded.bin" bs=4 conv=sync
	cat "${BINARIES_DIR}/u-boot-spl-padded.bin" "${BINARIES_DIR}/ddr_fw.bin" > "${BINARIES_DIR}/u-boot-spl-ddr.bin"

	"${HOST_DIR}/bin/mkimage_imx8" -commit > "${BINARIES_DIR}/mkimg.commit"
	cat "${BINARIES_DIR}/u-boot.bin" "${BINARIES_DIR}/mkimg.commit" > "${BINARIES_DIR}/u-boot-hash.bin"
	rm -f "${BINARIES_DIR}/mkimg.commit"

	if grep -Eq "^BR2_TARGET_OPTEE_OS=y$" "${BR2_CONFIG}"; then
		"${HOST_DIR}/bin/mkimage_imx8" -soc IMX9 -c \
			-ap "${BINARIES_DIR}/bl31.bin" a55 ${ATF_LOAD_ADDR} \
			-ap "${BINARIES_DIR}/u-boot-hash.bin" a55 0x80200000 \
			-ap "${BINARIES_DIR}/tee.bin" a55 0x96000000 \
			-out "${BINARIES_DIR}/u-boot-atf-container.img"
	else
		"${HOST_DIR}/bin/mkimage_imx8" -soc IMX9 -c \
			-ap "${BINARIES_DIR}/bl31.bin" a55 ${ATF_LOAD_ADDR} \
			-ap "${BINARIES_DIR}/u-boot-hash.bin" a55 0x80200000 \
			-out "${BINARIES_DIR}/u-boot-atf-container.img"
	fi

	"${HOST_DIR}/bin/mkimage_imx8" -soc IMX9 -append "${BINARIES_DIR}/ahab-container.img" -c \
		-ap "${BINARIES_DIR}/u-boot-spl-ddr.bin" a55 ${SPL_LOAD_ADDR} \
		-out "${BINARIES_DIR}/imx9-boot-sd.bin"

	flashbin_size="$(wc -c "${BINARIES_DIR}/imx9-boot-sd.bin" | awk '{print $1}')"
	pad_cnt=$(($((flashbin_size + 0x400 - 1)) / 0x400))
	dd if="${BINARIES_DIR}/u-boot-atf-container.img" of="${BINARIES_DIR}/imx9-boot-sd.bin" bs=1K seek=${pad_cnt}

	exit $?
}

main "$@"

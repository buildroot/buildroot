#!/bin/sh
BOARD_DIR=$(dirname $0)

# The DTB to use is provided within the U-Boot source tree, so we grab
# it from there, and install it to TARGET_DIR/boot/.
eval $(make -C ${CONFIG_DIR} --no-print-directory QUOTED_VARS=YES VARS=UBOOT_DIR printvars)
install -D -m0644 ${UBOOT_DIR}/arch/riscv/dts/starfive_vic7100_beagle_v.dtb \
	${TARGET_DIR}/boot/starfive_vic7100_beagle_v.dtb

# Bring the extlinux.conf file in.
install -D -m 0644 ${BOARD_DIR}/extlinux.conf \
	${TARGET_DIR}/boot/extlinux/extlinux.conf

# To be reflashed through Xmodem, the bootloader needs to be prepended
# with a 4-byte header that contains the total size of the file.
perl -e 'print pack("l", (stat @ARGV[0])[7])' ${BINARIES_DIR}/fw_payload.bin > ${BINARIES_DIR}/fw_payload.bin.out
cat ${BINARIES_DIR}/fw_payload.bin >> ${BINARIES_DIR}/fw_payload.bin.out

#!/bin/sh
BOARD_DIR=$(dirname $0)

# Bring the extlinux.conf file in.
install -D -m 0644 ${BOARD_DIR}/extlinux.conf \
	${TARGET_DIR}/boot/extlinux/extlinux.conf

# To be reflashed through Xmodem, the bootloader needs to be prepended
# with a 4-byte header that contains the total size of the file.
perl -e 'print pack("l", (stat @ARGV[0])[7])' ${BINARIES_DIR}/fw_payload.bin > ${BINARIES_DIR}/fw_payload.bin.out
cat ${BINARIES_DIR}/fw_payload.bin >> ${BINARIES_DIR}/fw_payload.bin.out

#!/bin/sh

MKIMAGE=${HOST_DIR}/bin/mkimage

# Generate u-Boot kernel image
${MKIMAGE} -A riscv -O linux -T kernel -C none \
	-a 0x80000000 -e 0x80000000 \
	-n Linux -d ${BINARIES_DIR}/loader.bin ${BINARIES_DIR}/uImage

# Link the kernel-built board dtb file to using the k210.dtb generic
# name for use by genimage.cfg
BOARDDTBKPATH="$(grep BR2_LINUX_KERNEL_INTREE_DTS_NAME ${BR2_CONFIG} | cut -d'=' -f2 | tr -d \")"

BOARDDTB="$(basename ${BOARDDTBKPATH})"
if [ -z "${BOARDDTB}" ]; then
	echo "Board DTB file not specified"
	exit 1
fi

BOARDDTB="${BINARIES_DIR}/${BOARDDTB}.dtb"
if [ ! -f "${BOARDDTB}" ]; then
        echo "Board DTB file not found in ${BINARIES_DIR}"
        exit 1
fi

TARGETDTB=${BINARIES_DIR}/k210.dtb
rm -f ${TARGETDTB}
ln -s ${BOARDDTB} ${TARGETDTB}

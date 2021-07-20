#!/bin/sh

rm -rf ${BUILD_DIR}/linux-custom-modules
mkdir ${BUILD_DIR}/linux-custom-modules
INSTALL_MOD_PATH=${BUILD_DIR}/linux-custom-modules ARCH=mips make -C ${BUILD_DIR}/linux-custom modules_install
KERNEL_NAME=$(basename $(ls -d ${BUILD_DIR}/linux-custom-modules/lib/modules/*))
ln -s ${KERNEL_NAME} ${BUILD_DIR}/linux-custom-modules/lib/modules/${KERNEL_NAME}+
mksquashfs ${BUILD_DIR}/linux-custom-modules/lib/modules ${BINARIES_DIR}/modules.squashfs \
	-all-root -noappend -no-exports -no-xattrs

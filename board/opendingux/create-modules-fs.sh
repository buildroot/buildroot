#!/bin/sh

mksquashfs ${TARGET_DIR}/usr/lib/modules ${BINARIES_DIR}/modules.squashfs \
	-all-root -noappend -no-exports -no-xattrs
rm -rf ${TARGET_DIR}/usr/lib/modules/*
rm -f ${BUILD_DIR}/linux-custom/.stamp_target_installed

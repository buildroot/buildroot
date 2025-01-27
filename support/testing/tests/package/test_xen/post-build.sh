#!/bin/sh
set -eu

# Remove unnecessary Xen binaries to spare ramdisk size.
for ext in bin fd rom; do
	rm -vf "${TARGET_DIR}/usr/share/qemu-xen/qemu/"*."$ext"
done

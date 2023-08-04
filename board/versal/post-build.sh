#!/bin/sh

# genimage will need to find the extlinux.conf
# in the binaries directory

CONSOLE="$2"
ROOT="$3"

mkdir -p "${BINARIES_DIR}"
cat <<-__HEADER_EOF > "${BINARIES_DIR}/extlinux.conf"
	label linux
	  kernel /Image
	  devicetree /system.dtb
	  append console=${CONSOLE} clk_ignore_unused root=/dev/${ROOT} rw rootwait
	__HEADER_EOF

#!/bin/sh

# genimage will need to find the extlinux.conf
# in the binaries directory

BOARD_DIR="$(dirname $0)"
CONSOLE=$2
ROOT=$3

FILE=${BOARD_DIR}/extlinux.conf
if test -f "${FILE}"; then
  install -m 0644 -D "${FILE}" "${BINARIES_DIR}/extlinux.conf"
else
  mkdir -p "${BINARIES_DIR}"
  cat <<-__HEADER_EOF > "${BINARIES_DIR}/extlinux.conf"
	label linux
	  kernel /Image
	  devicetree /system.dtb
	  append console=${CONSOLE} root=/dev/${ROOT} rw rootwait
	__HEADER_EOF
fi

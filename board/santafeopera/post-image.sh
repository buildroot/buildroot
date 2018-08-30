#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"


#######################
## Testing to see if I understand the build concept to create
## New files in /boot.
## Petonic [2018-08-17 FRI 11:20]
#######################

CFGTXT="${BINARIES_DIR}/rpi-firmware/config.txt"

for arg in "$@"
do
	case "${arg}" in
		--add-pi3-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=' "${CFGTXT}"; then
			echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${CFGTXT}"

# fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${CFGTXT}"
		if ! grep -qE '^arm_control=0x200' "${CFGTXT}"; then
			cat << __EOF__ >> "${CFGTXT}"

# enable 64bits support
arm_control=0x200
__EOF__
		fi

		# Enable uart console
		if ! grep -qE '^enable_uart=1' "${CFGTXT}"; then
			cat << __EOF__ >> "${CFGTXT}"

# enable rpi3 ttyS0 serial console
enable_uart=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${CFGTXT}"
		;;

# disable console backlight during bootup (santafeopera)

		--console-noblank)
		if ! grep -qE 'consoleblank=0' "${CFGTXT}"; then
			echo -n 'consoleblank=0' >> ${CFGTXT}
		fi
		;;


##### --- End of customizations

	esac
done

rm -rf "${GENIMAGE_TMP}"

echo "ZYXXY: Current Directory is: `pwd`"
echo "		XYZZY:  TARGET_DIR = <${TARGET_DIR}>"
echo "		XYZZY:  GENIMAGE_TMP = <${GENIMAGE_TMP}>"
echo "		XYZZY:  BINARIES_DIR = <${BINARIES_DIR}>"
echo "		XYZZY:  BINARIES_DIR = <${BINARIES_DIR}>"
echo "		XYZZY:  GENIMAGE_CFG = <${GENIMAGE_CFG}>"


genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?

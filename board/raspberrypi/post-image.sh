#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

for arg in "$@"
do
	case "${arg}" in
		--add-miniuart-bt-overlay)
		if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtoverlay=miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# fixes rpi (3B, 3B+, 3A+, 4B and Zero W) ttyAMA0 serial console
dtoverlay=miniuart-bt
__EOF__
		fi
		;;
		--aarch64)
		# Run a 64bits kernel (armv8)
		sed -e '/^kernel=/s,=.*,=Image,' -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# enable 64bits support
arm_64bit=1
__EOF__
		fi
		;;
		--gpu_mem_256=*|--gpu_mem_512=*|--gpu_mem_1024=*)
		# Set GPU memory
		gpu_mem="${arg:2}"
		sed -e "/^${gpu_mem%=*}=/s,=.*,=${gpu_mem##*=}," -i "${BINARIES_DIR}/rpi-firmware/config.txt"
		;;
	        --tvmode-720)
	        if ! grep -qE '^hdmi_mode=4' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		    echo "Adding 'tvmode=720' to config.txt."
		    cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Force 720p
hdmi_group=1
hdmi_mode=4
__EOF__
	        fi
	        ;;
                --tvmode-1080)
                if ! grep -qE '^hdmi_mode=16' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
                    echo "Adding 'tvmode=1080' to config.txt."
                    cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Force 1080p
hdmi_group=1
hdmi_mode=16
__EOF__
                fi
	        ;;
	        --silent)
	        if ! grep -qE '^disable_splash=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
	            echo "Adding 'silent=1' to config.txt."
	            cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Silent
disable_splash=1
boot_delay=0
__EOF__
	        fi
	        ;;
	        --overclock*)
	        if ! grep -qE '^arm_freq=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		    echo "Adding 'overclock' to config.txt."
		    cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Overclock
force_turbo=1
[pi0]
[pi0w]
[pi1]
[pi2]
arm_freq=1000
gpu_freq=500
sdram_freq=500
over_voltage=6
[pi3]
arm_freq=1350
gpu_freq=500
sdram_freq=500
over_voltage=5
[pi3+]
arm_freq=1350
gpu_freq=500
sdram_freq=500
over_voltage=5
[all]
avoid_warnings=1
__EOF__
	        fi
		;;
		--add-vc4-fkms-v3d-overlay)
		# Enable VC4 overlay
		if ! grep -qE '^dtoverlay=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
			echo "Adding 'dtoverlay=vc4-fkms-v3d' to config.txt."
			cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Add VC4 GPU support
dtoverlay=vc4-fkms-v3d
__EOF__
		fi
		;;
	esac

done

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

if grep "^BR2_TARGET_ROOTFS_EXT2=y$" "${BR2_CONFIG}" &>/dev/null; then 

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

genimage \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"
fi

exit $?

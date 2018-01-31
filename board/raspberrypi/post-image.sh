#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}-noinitramfs.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

echo "Post-image: processing $@"

for i in "$@"
do
case "$i" in
	--add-pi3-miniuart-bt-overlay)
	if ! grep -qE '^dtoverlay=pi3-miniuart-bt' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'dtoverlay=pi3-miniuart-bt' to config.txt (fixes ttyAMA0 serial console)."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Fixes rpi3 ttyAMA0 serial console
dtoverlay=pi3-miniuart-bt
__EOF__
	fi
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
	--tvmode-dvi)
	if ! grep -qE '^hdmi_drive=2' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'tvmode=dvi' to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Force dvi output
hdmi_drive=2
__EOF__
	fi
	;;
	--overclock-pi012)
	if ! grep -qE '^arm_freq=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'overclock=pi012' to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Overclock
arm_freq=1000
gpu_freq=500
sdram_freq=500
over_voltage=6
avoid_warnings=1
__EOF__
	fi
	;;
	--overclock-pi3)
	if ! grep -qE '^arm_freq=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'overclock=pi3' to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Overclock
arm_freq=1350
gpu_freq=500
sdram_freq=500
over_voltage=5
avoid_warnings=1
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
	--i2c)
	if ! grep -qE '^dtparam=i2c_arm=on' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'i2c' functionality to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable i2c functionality
dtparam=i2c_arm=on,i2c_arm_baudrate=400000
dtparam=i2c1=on,i2c1_baudrate=50000
__EOF__
	fi
	;;
	--spi)
	if ! grep -qE '^dtparam=spi=on' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'spi' functionality to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable spi functionality
dtparam=spi=on
__EOF__
	fi
	;;
	--1w)
	if ! grep -qE '^dtoverlay=w1-gpio' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding '1w' functionality to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable 1Wire functionality
dtoverlay=w1-gpio,gpiopin=7
__EOF__
	fi
	;;
	--lirc)
	if ! grep -qE '^dtoverlay=lirc-rpi' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'lirc' functionality to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable 1Wire functionality
dtoverlay=lirc-rpi,gpio_in_pin=23,gpio_out_pin=22
__EOF__
	fi
	;;
	--rpi-wifi*)
	if ! grep -qE '^dtoverlay=sdtweak' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'rpi wifi' functionality to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Enable overlay for wifi functionality
dtoverlay=sdtweak,overclock_50=80
__EOF__
	fi
	if grep -qE '^dtoverlay=mmc' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Removing overlay for mmc due to wifi compatibilityin config.txt."
		cat "${BINARIES_DIR}/rpi-firmware/config.txt" | sed '/^# Enable mmc by default/,+2d' > "${BINARIES_DIR}/rpi-firmware/config_.txt"
		rm "${BINARIES_DIR}/rpi-firmware/config.txt"
		mv "${BINARIES_DIR}/rpi-firmware/config_.txt" "${BINARIES_DIR}/rpi-firmware/config.txt"
	fi
	;;
esac
done

AARCH64="$(grep ^BR2_aarch64=y ${BR2_CONFIG})"
if [ "x${AARCH64}" != "x" ]; then
	if ! grep -qE '^arm_64bit=1' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
		echo "Adding 'arm_64bit=1' to config.txt."
		cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Force 64bit
arm_64bit=1
__EOF__
	fi
fi

INITRAMFS="$(grep ^BR2_TARGET_ROOTFS_INITRAMFS=y ${BR2_CONFIG})"
ROOTFS_CPIO="$(grep ^BR2_TARGET_ROOTFS_CPIO=y ${BR2_CONFIG})"
ROOTFS_EXT4="$(grep ^BR2_TARGET_ROOTFS_EXT2_4=y ${BR2_CONFIG})"

if [ "x${ROOTFS_EXT4}" != "x" ]; then
	rm -rf "${GENIMAGE_TMP}"
	genimage                           \
		--rootpath "${TARGET_DIR}"     \
		--tmppath "${GENIMAGE_TMP}"    \
		--inputpath "${BINARIES_DIR}"  \
		--outputpath "${BINARIES_DIR}" \
		--config "${GENIMAGE_CFG}"
elif [ "x${INITRAMFS}" = "x" ] && [ "x${ROOTFS_CPIO}" != "x" ]; then
	CPIO_XZ=$(grep ^BR2_TARGET_ROOTFS_CPIO_XZ=y ${BR2_CONFIG})
	CPIO_GZIP=$(grep ^BR2_TARGET_ROOTFS_CPIO_GZIP=y ${BR2_CONFIG})
	sed -i 's/#initramfs/initramfs/g' "${BINARIES_DIR}/rpi-firmware/config.txt"
	if [ "x${CPIO_XZ}" != "x" ]; then
		sed -i 's/cpio.gz/cpio.xz/' "${BINARIES_DIR}/rpi-firmware/config.txt"
	elif [ "x${CPIO_GZIP}" = "x" ]; then
		sed -i 's/cpio.gz/rootfs.cpio/' "${BINARIES_DIR}/rpi-firmware/config.txt"
	fi
fi

exit $?

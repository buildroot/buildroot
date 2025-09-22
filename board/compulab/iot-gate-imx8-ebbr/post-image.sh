#!/bin/sh
set -eux

BOARD_DIR=$(dirname "$0")

# Override the default GRUB configuration file with our own.
cp -vf "${BOARD_DIR}/grub.cfg" "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"

BINMAN_DIR="$BINARIES_DIR/binman"
BINMAN_DTB="$BINMAN_DIR/u-boot.dtb"
UBOOT_DIR=$(find "$BUILD_DIR" -maxdepth 1 -type d -name 'uboot-*')

# Adjust binman dtb.
rm -fr "$BINMAN_DIR"
mkdir -v "$BINMAN_DIR"
cp -v "$UBOOT_DIR/u-boot.dtb" "$BINMAN_DTB"
# Add the fip image to the list of loadables.
fdtput -t s "$BINMAN_DTB" /binman/section/fit/configurations/@config-SEQ loadables atf fip
# Remove the tee node to avoid duplicate, as it is in the FIP image.
fdtput --remove "$BINMAN_DTB" /binman/section/fit/images/tee

# Generate flash image with binman.
# We do this here to break the build dependency loop involving tf-a, op-tee, and
# u-boot.
# We use BL2 instead of BL31 in this configuration.
(cd "${UBOOT_DIR}" && \
./tools/binman/binman \
	--toolpath ./tools \
	-v5 \
	build \
	-u \
	-d "$BINMAN_DTB" \
	-O . \
	-m \
	--allow-missing \
	--fake-ext-blobs \
	-I "$BINMAN_DIR" \
	-I . \
	-I ./board/compulab/imx8mm-cl-iot-gate \
	-I arch/arm/dts \
	-a of-list="imx8mm-cl-iot-gate-optee" \
	-I "$BINARIES_DIR" \
	-a atf-bl31-path=bl2.bin \
	-a tee-os-path= \
	-a ti-dm-path= \
	-a opensbi-path= \
	-a default-dt="imx8mm-cl-iot-gate-optee" \
	-a scp-path= \
	-a rockchip-tpl-path= \
	-a spl-bss-pad= \
	-a tpl-bss-pad=1 \
	-a vpl-bss-pad=1 \
	-a spl-dtb=y \
	-a tpl-dtb= \
	-a vpl-dtb= \
	-a pre-load-key-path= \
	-a of-spl-remove-props="interrupt-parent interrupts" \
	)

# Copy the flash image.
cp -v "$UBOOT_DIR/flash.bin" "$BINARIES_DIR/"

# Verify that it will fit in the eMMC boot partition.
size=$(du -b "$BINARIES_DIR/flash.bin" |cut -f 1)

if [ "$size" -gt 4160512 ]; then
	echo "Flash image is too big! (${size} bytes)" >&2
	exit 1
fi

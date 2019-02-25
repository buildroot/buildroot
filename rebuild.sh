#!/bin/sh
set -e

if [ -z "$CONFIG" ] ; then
	echo "\$CONFIG not set. Please set it to the variant to build."
	echo "Valid values are: gcw0, rs90"
	exit 1
fi

# Use the default config.
make od_${CONFIG}_defconfig BR2_EXTERNAL=board/opendingux

# Clear the install location.
echo "Clearing install location..."
mkdir -p /opt/${CONFIG}-toolchain
rm -rf /opt/${CONFIG}-toolchain/*

# Clear the build location.
echo "Clearing build location..."
rm -rf output/

# Perform the build.
echo "Starting build..."
nice make BR2_EXTERNAL=board/opendingux

# Create packages.
echo "Creating packages..."
nice tar -C$(dirname $(realpath /opt/${CONFIG}-toolchain)) --exclude='.fakeroot.*' -jcf opendingux-${CONFIG}-toolchain.`date +'%Y-%m-%d'`.tar.bz2 ${CONFIG}-toolchain

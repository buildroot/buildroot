#!/bin/sh
set -e

if [ -z "$CONFIG" ] ; then
	echo "\$CONFIG not set. Please set it to the variant to build."
	echo "Valid values are: gcw0, rs90"
	exit 1
fi

# Use the default config.
make od_${CONFIG}_defconfig BR2_EXTERNAL=board/opendingux

# Clear the build location.
echo "Clearing build location..."
rm -rf output/host

# Perform the build.
echo "Starting build..."
nice make sdk BR2_SDK_PREFIX=${CONFIG}-toolchain

ARCHIVE_NAME=opendingux-${CONFIG}-toolchain.`date +'%Y-%m-%d'`
mv output/images/${CONFIG}-toolchain.tar.gz "output/images/$ARCHIVE_NAME.tar.gz"

echo "The SDK has been built at:"
echo "output/images/$ARCHIVE_NAME.tar.gz"
echo
echo "Remember to run ./relocate-sdk.sh after extracting it to your desired location"

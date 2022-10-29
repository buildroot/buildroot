#!/bin/sh
set -e

if [ -z "$CONFIG" ] ; then
	echo "\$CONFIG not set. Please set it to the variant to build."
	echo "Valid values are: gcw0, rs90, lepus, installer"
	exit 1
fi

# Set TOP_MAKE_COMMAND to utils/brmake for compact output
TOP_MAKE_COMMAND="${TOP_MAKE_COMMAND:-make}"

if [ "$TOP_MAKE_COMMAND" = utils/brmake ]; then
	rm -f br.log
fi

# Clear the build location.
if [ "$1" = clean ]; then
  echo "Clearing build location..."
  rm -rf output/${CONFIG}
fi

# Unset client variables that cause issues with buildroot.
unset PERL_MM_OPT CMAKE_GENERATOR CMAKE_GENERATOR_PLATFORM CMAKE_GENERATOR_TOOLSET CMAKE_GENERATOR_INSTANCE

# Use the default config.
make od_${CONFIG}_defconfig BR2_EXTERNAL=board/opendingux O=output/${CONFIG}

echo "Copy .config to target"
mkdir output/${CONFIG}/host && cp output/${CONFIG}/.config output/${CONFIG}/host/

if [ "${CONFIG}" = "installer" ] ; then
	TARGETS="all host-odbootd"
else
	TARGETS=sdk
fi

# Perform the build.
echo "Starting build..."
PARALLELISM=$(getconf _NPROCESSORS_ONLN)
for target in $TARGETS; do
	nice ${TOP_MAKE_COMMAND} "$target" BR2_SDK_PREFIX=${CONFIG}-toolchain O=output/${CONFIG} -j $PARALLELISM
done

if [ "${TARGETS}" = sdk ] ; then
	echo "Recompressing SDK to XZ..."
	ARCHIVE_NAME=opendingux-${CONFIG}-toolchain.`date +'%Y-%m-%d'`
	gzip -d -c output/${CONFIG}/images/${CONFIG}-toolchain.tar.gz | xz -T0 -9 > output/${CONFIG}/images/$ARCHIVE_NAME.tar.xz
	rm output/${CONFIG}/images/${CONFIG}-toolchain.tar.gz

	echo "The SDK has been built at:"
	echo "output/${CONFIG}/images/$ARCHIVE_NAME.tar.xz"
	echo
	echo "Remember to run ./relocate-sdk.sh after extracting it to your desired location"
fi

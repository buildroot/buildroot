#!/bin/sh

# We run dropbear from inetd
rm -f $1/etc/init.d/S50dropbear

# No need for udev's HW database
rm -rf $1/etc/udev/hwdb.d

# We only support 240x160 and 320x240 in GMenu2X.
(
	cd $1/usr/share/gmenu2x/skins

	for each in *x* ; do
		[ "$each" != "240x160" -a "$each" != "320x240" ] && rm -rf "$each"
	done
)

if [ ! -h $1/usr/share/fonts/truetype ] ; then
	ln -s . $1/usr/share/fonts/truetype
fi

# Create cmake helpers
echo -e '#!/bin/sh\n\nexec cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=`dirname $0`/../share/buildroot/toolchainfile.cmake $*' > ${HOST_DIR}/usr/bin/mipsel-rs90-linux-musl-cmake
chmod +x ${HOST_DIR}/usr/bin/mipsel-rs90-linux-musl-cmake
ln -sf mipsel-rs90-linux-musl-cmake ${HOST_DIR}/usr/bin/mipsel-linux-cmake

# Create ccmake helpers
echo -e '#!/bin/sh\n\nexec ccmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=`dirname $0`/../share/buildroot/toolchainfile.cmake $*' > ${HOST_DIR}/usr/bin/mipsel-rs90-linux-musl-ccmake
chmod +x ${HOST_DIR}/usr/bin/mipsel-rs90-linux-musl-ccmake
ln -sf mipsel-rs90-linux-musl-ccmake ${HOST_DIR}/usr/bin/mipsel-linux-ccmake

#!/bin/sh

# We run dropbear from inetd
rm -f $1/etc/init.d/S50dropbear

# No need for udev's HW database
rm -rf $1/etc/udev/hwdb.d

# Create cmake helpers
echo -e '#!/bin/sh\n\nexec cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=`dirname $0`/../share/buildroot/toolchainfile.cmake $*' > ${HOST_DIR}/usr/bin/mipsel-lepus-linux-musl-cmake
chmod +x ${HOST_DIR}/usr/bin/mipsel-lepus-linux-musl-cmake
ln -sf mipsel-lepus-linux-musl-cmake ${HOST_DIR}/usr/bin/mipsel-linux-cmake

# Create ccmake helpers
echo -e '#!/bin/sh\n\nexec ccmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_TOOLCHAIN_FILE=`dirname $0`/../share/buildroot/toolchainfile.cmake $*' > ${HOST_DIR}/usr/bin/mipsel-lepus-linux-musl-ccmake
chmod +x ${HOST_DIR}/usr/bin/mipsel-lepus-linux-musl-ccmake
ln -sf mipsel-lepus-linux-musl-ccmake ${HOST_DIR}/usr/bin/mipsel-linux-ccmake

################################################################################
#
# binutils-bare-metal
#
################################################################################

HOST_BINUTILS_BARE_METAL_VERSION = 2.42
HOST_BINUTILS_BARE_METAL_SITE = $(BR2_GNU_MIRROR)/binutils
HOST_BINUTILS_BARE_METAL_SOURCE = binutils-$(HOST_BINUTILS_BARE_METAL_VERSION).tar.xz

HOST_BINUTILS_BARE_METAL_LICENSE = GPL-3.0+, libiberty LGPL-2.1+
HOST_BINUTILS_BARE_METAL_LICENSE_FILES = COPYING3 COPYING.LIB
HOST_BINUTILS_BARE_METAL_CPE_ID_VENDOR = gnu

HOST_BINUTILS_BARE_METAL_DEPENDENCIES = host-zlib

# Don't build documentation. It takes up extra space / build time,
# and sometimes needs specific makeinfo versions to work
HOST_BINUTILS_BARE_METAL_CONF_ENV += MAKEINFO=true
HOST_BINUTILS_BARE_METAL_MAKE_OPTS += MAKEINFO=true
HOST_BINUTILS_BARE_METAL_INSTALL_OPTS += MAKEINFO=true install

HOST_BINUTILS_BARE_METAL_CONF_OPTS = \
	--target=$(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE) \
	--disable-gprof \
	--disable-shared \
	--enable-lto \
	--enable-static \
	--disable-initfini-array \
	--disable-multilib \
	--disable-werror

$(eval $(host-autotools-package))

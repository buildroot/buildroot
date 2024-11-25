################################################################################
#
# binutils-bare-metal
#
################################################################################

BINUTILS_BARE_METAL_VERSION = 2.43.1
BINUTILS_BARE_METAL_SITE = $(BR2_GNU_MIRROR)/binutils
BINUTILS_BARE_METAL_SOURCE = binutils-$(BINUTILS_BARE_METAL_VERSION).tar.xz

BINUTILS_BARE_METAL_LICENSE = GPL-3.0+, libiberty LGPL-2.1+
BINUTILS_BARE_METAL_LICENSE_FILES = COPYING3 COPYING.LIB
BINUTILS_BARE_METAL_CPE_ID_VENDOR = gnu
BINUTILS_BARE_METAL_CPE_ID_PRODUCT = binutils

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

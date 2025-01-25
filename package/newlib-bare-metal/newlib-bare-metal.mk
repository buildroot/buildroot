################################################################################
#
# newlib-bare-metal
#
################################################################################

NEWLIB_BARE_METAL_VERSION = 4.5.0.20241231
NEWLIB_BARE_METAL_SITE = https://sourceware.org/ftp/newlib
NEWLIB_BARE_METAL_SOURCE = newlib-$(NEWLIB_BARE_METAL_VERSION).tar.gz
NEWLIB_BARE_METAL_DEPENDENCIES = host-gcc-bare-metal
NEWLIB_BARE_METAL_ADD_TOOLCHAIN_DEPENDENCY = NO
NEWLIB_BARE_METAL_LICENSE = GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0
NEWLIB_BARE_METAL_LICENSE_FILES = \
	COPYING \
	COPYING.LIB \
	COPYING.LIBGLOSS \
	COPYING.NEWLIB
NEWLIB_BARE_METAL_CPE_ID_VENDOR = newlib_project
NEWLIB_BARE_METAL_CPE_ID_PRODUCT = newlib

NEWLIB_BARE_METAL_INSTALL_STAGING = YES
NEWLIB_BARE_METAL_INSTALL_TARGET = NO
NEWLIB_BARE_METAL_MAKE_OPTS = MAKEINFO=true

define NEWLIB_BARE_METAL_CONFIGURE_CMDS
	(cd $(@D) && \
		PATH=$(BR_PATH) \
		./configure \
			--target=$(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE) \
			--prefix=/usr \
			--enable-newlib-io-c99-formats \
			--enable-newlib-io-long-long \
			--enable-newlib-io-float \
			--enable-newlib-io-long-double \
			--disable-multilib \
			--with-tooldir=/usr \
	)
endef

define NEWLIB_BARE_METAL_BUILD_CMDS
	PATH=$(BR_PATH) $(MAKE1) $(NEWLIB_BARE_METAL_MAKE_OPTS) -C $(@D)
endef

define NEWLIB_BARE_METAL_INSTALL_STAGING_CMDS
	PATH=$(BR_PATH) $(MAKE1) -C $(@D) $(NEWLIB_BARE_METAL_MAKE_OPTS) \
		DESTDIR=$(TOOLCHAIN_BARE_METAL_BUILDROOT_SYSROOT) install
endef

$(eval $(generic-package))

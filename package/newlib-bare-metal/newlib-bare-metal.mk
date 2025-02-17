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

NEWLIB_BARE_METAL_CONF_OPTS = \
	--build=$(GNU_HOST_NAME) \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--program-prefix="" \
	$(if $$($$(PKG)_OVERRIDE_SRCDIR),,--disable-dependency-tracking) \
	$(QUIET) \
	--enable-newlib-io-c99-formats \
	--enable-newlib-io-long-long \
	--enable-newlib-io-float \
	--enable-newlib-io-long-double \
	--disable-multilib \
	--with-tooldir=/usr

define NEWLIB_BARE_METAL_CONFIGURE_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		mkdir -p $(@D)/build-$(arch_tuple) && \
		cd $(@D)/build-$(arch_tuple) && \
		PATH=$(BR_PATH) \
		CONFIG_SITE=/dev/null \
		$(@D)/configure \
			$(NEWLIB_BARE_METAL_CONF_OPTS) \
			--target=$(arch_tuple)
	)
endef

define NEWLIB_BARE_METAL_BUILD_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		PATH=$(BR_PATH) $(MAKE1) \
			$(NEWLIB_BARE_METAL_MAKE_OPTS) \
			-C $(@D)/build-$(arch_tuple)
	)
endef

define NEWLIB_BARE_METAL_INSTALL_STAGING_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		PATH=$(BR_PATH) $(MAKE1) \
			$(NEWLIB_BARE_METAL_MAKE_OPTS) \
			-C $(@D)/build-$(arch_tuple) \
			DESTDIR=$(HOST_DIR)/$(arch_tuple)/sysroot install
	)
endef

$(eval $(generic-package))

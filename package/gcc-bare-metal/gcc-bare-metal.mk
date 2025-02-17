################################################################################
#
# gcc-bare-metal
#
################################################################################

GCC_BARE_METAL_VERSION = 14.2.0
GCC_BARE_METAL_SITE = $(BR2_GNU_MIRROR)/gcc/gcc-$(GCC_BARE_METAL_VERSION)
GCC_BARE_METAL_SOURCE = gcc-$(GCC_BARE_METAL_VERSION).tar.xz

GCC_BARE_METAL_LICENSE = GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0
GCC_BARE_METAL_LICENSE_FILES = COPYING COPYING3 COPYING.LIB COPYING3.LIB
GCC_BARE_METAL_CPE_ID_VENDOR = gnu
GCC_BARE_METAL_CPE_ID_PRODUCT = gcc

HOST_GCC_BARE_METAL_DEPENDENCIES = \
	host-binutils-bare-metal \
	host-gmp \
	host-mpc \
	host-mpfr \
	host-isl

# Don't build documentation. It takes up extra space / build time,
# and sometimes needs specific makeinfo versions to work
HOST_GCC_BARE_METAL_CONF_ENV = MAKEINFO=missing

HOST_GCC_BARE_METAL_MAKE_OPTS = \
	$(HOST_GCC_COMMON_MAKE_OPTS) \
	all-gcc \
	all-target-libgcc

HOST_GCC_BARE_METAL_INSTALL_OPTS = install-gcc install-target-libgcc

HOST_GCC_BARE_METAL_CONF_OPTS = \
	--prefix=$(HOST_DIR) \
	--sysconfdir=$(HOST_DIR)/etc \
	--localstatedir=$(HOST_DIR)/var \
	$(if $$($$(PKG)_OVERRIDE_SRCDIR),,--disable-dependency-tracking) \
	$(QUIET) \
	--disable-shared \
	--disable-initfini-array \
	--disable-__cxa_atexit \
	--disable-libstdcxx-pch \
	--with-newlib \
	--disable-threads \
	--enable-plugins \
	--with-gnu-as \
	--disable-libitm \
	--without-long-double-128 \
	--without-headers \
	--enable-languages=c \
	--disable-multilib \
	--with-gmp=$(HOST_DIR) \
	--with-mpc=$(HOST_DIR) \
	--with-mpfr=$(HOST_DIR) \
	--with-isl=$(HOST_DIR)

define HOST_GCC_BARE_METAL_CONFIGURE_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		mkdir -p $(@D)/build-$(arch_tuple) && \
		cd $(@D)/build-$(arch_tuple) && \
		$(HOST_CONFIGURE_OPTS) \
		$(HOST_GCC_BARE_METAL_CONF_ENV) \
		CONFIG_SITE=/dev/null \
		$(@D)/configure \
			$(HOST_GCC_BARE_METAL_CONF_OPTS) \
			--target=$(arch_tuple) \
			--with-sysroot=$(HOST_DIR)/$(arch_tuple)/sysroot \
			AR_FOR_TARGET=$(HOST_DIR)/bin/$(arch_tuple)-ar \
			RANLIB_FOR_TARGET=$(HOST_DIR)/bin/$(arch_tuple)-ranlib
	)
endef

define HOST_GCC_BARE_METAL_BUILD_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		$(HOST_MAKE_ENV) $(MAKE) \
			$(HOST_GCC_BARE_METAL_MAKE_OPTS) \
			-C $(@D)/build-$(arch_tuple)
	)
endef

define HOST_GCC_BARE_METAL_INSTALL_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		$(HOST_MAKE_ENV) $(MAKE) \
			$(HOST_GCC_BARE_METAL_INSTALL_OPTS) \
			-C $(@D)/build-$(arch_tuple)
	)
endef

$(eval $(host-autotools-package))

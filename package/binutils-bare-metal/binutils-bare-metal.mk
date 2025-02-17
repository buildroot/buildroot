################################################################################
#
# binutils-bare-metal
#
################################################################################

BINUTILS_BARE_METAL_VERSION = 2.44
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
	--prefix=$(HOST_DIR) \
	--sysconfdir=$(HOST_DIR)/etc \
	--localstatedir=$(HOST_DIR)/var \
	$(if $$($$(PKG)_OVERRIDE_SRCDIR),,--disable-dependency-tracking) \
	$(QUIET) \
	--disable-gprof \
	--disable-shared \
	--enable-lto \
	--disable-initfini-array \
	--disable-multilib \
	--disable-werror

define HOST_BINUTILS_BARE_METAL_CONFIGURE_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		mkdir -p $(@D)/build-$(arch_tuple) && \
		cd $(@D)/build-$(arch_tuple) && \
		$(HOST_CONFIGURE_OPTS) \
		$(HOST_BINUTILS_BARE_METAL_CONF_ENV) \
		CONFIG_SITE=/dev/null \
		$(@D)/configure \
			$(HOST_BINUTILS_BARE_METAL_CONF_OPTS) \
			--target=$(arch_tuple)
	)
endef

define HOST_BINUTILS_BARE_METAL_BUILD_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		$(HOST_MAKE_ENV) $(MAKE) \
			$(HOST_BINUTILS_BARE_METAL_MAKE_OPTS) \
			-C $(@D)/build-$(arch_tuple)
	)
endef

define HOST_BINUTILS_BARE_METAL_INSTALL_CMDS
	$(foreach arch_tuple, $(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE), \
		$(HOST_MAKE_ENV) $(MAKE) \
			$(HOST_BINUTILS_BARE_METAL_INSTALL_OPTS) \
			-C $(@D)/build-$(arch_tuple)
	)
endef

$(eval $(host-autotools-package))

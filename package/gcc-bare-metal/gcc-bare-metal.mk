################################################################################
#
# gcc-bare-metal
#
################################################################################

HOST_GCC_BARE_METAL_VERSION = 13.2.0
HOST_GCC_BARE_METAL_SITE = \
	https://ftp.gnu.org/gnu/gcc/gcc-$(HOST_GCC_BARE_METAL_VERSION)
HOST_GCC_BARE_METAL_SOURCE = gcc-$(HOST_GCC_BARE_METAL_VERSION).tar.xz

HOST_GCC_BARE_METAL_LICENSE = GPL-2.0, GPL-3.0, LGPL-2.1, LGPL-3.0
HOST_GCC_BARE_METAL_LICENSE_FILES = COPYING COPYING3 COPYING.LIB COPYING3.LIB

HOST_GCC_BARE_METAL_DEPENDENCIES = \
	host-binutils-bare-metal \
	host-gmp \
	host-mpc \
	host-mpfr \
	host-isl

# gcc doesn't support in-tree build, so we create a 'build'
# subdirectory in the gcc sources, and build from there.
define GCC_BARE_METAL_CONFIGURE_SYMLINK
	mkdir -p $(@D)/build
	ln -sf ../configure $(@D)/build/configure
endef

HOST_GCC_BARE_METAL_PRE_CONFIGURE_HOOKS += GCC_BARE_METAL_CONFIGURE_SYMLINK
HOST_GCC_BARE_METAL_SUBDIR = build

HOST_GCC_BARE_METAL_MAKE_OPTS = \
	$(HOST_GCC_COMMON_MAKE_OPTS) \
	all-gcc \
	all-target-libgcc

HOST_GCC_BARE_METAL_INSTALL_OPTS = install-gcc install-target-libgcc

HOST_GCC_BARE_METAL_CONF_OPTS = \
	--target=$(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE) \
	--disable-initfini_array \
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
	--with-isl=$(HOST_DIR) \
	--with-sysroot=$(TOOLCHAIN_BARE_METAL_BUILDROOT_SYSROOT) \
	AR_FOR_TARGET=$(HOST_DIR)/bin/$(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE)-ar \
	RANLIB_FOR_TARGET=$(HOST_DIR)/bin/$(TOOLCHAIN_BARE_METAL_BUILDROOT_ARCH_TUPLE)-ranlib

$(eval $(host-autotools-package))

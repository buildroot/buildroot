################################################################################
#
# gcc-final
#
################################################################################

GCC_FINAL_VERSION = $(GCC_VERSION)
GCC_FINAL_SITE = $(GCC_SITE)
GCC_FINAL_SOURCE = $(GCC_SOURCE)
GCC_FINAL_LICENSE = GPL-3.0-with-GCC-exception
GCC_FINAL_LICENSE_FILES = COPYING.RUNTIME
HOST_GCC_FINAL_LICENSE = $(HOST_GCC_LICENSE)
HOST_GCC_FINAL_LICENSE_FILES = $(HOST_GCC_LICENSE_FILES)

GCC_FINAL_DEPENDENCIES = host-gcc-final
GCC_FINAL_ADD_TOOLCHAIN_DEPENDENCY = NO
GCC_FINAL_INSTALL_STAGING = YES

GCC_FINAL_DL_SUBDIR = gcc
HOST_GCC_FINAL_DL_SUBDIR = gcc

HOST_GCC_FINAL_DEPENDENCIES = \
	$(HOST_GCC_COMMON_DEPENDENCIES) \
	$(BR_LIBC)

HOST_GCC_FINAL_EXCLUDES = $(HOST_GCC_EXCLUDES)

ifneq ($(ARCH_XTENSA_OVERLAY_FILE),)
HOST_GCC_FINAL_POST_EXTRACT_HOOKS += HOST_GCC_XTENSA_OVERLAY_EXTRACT
HOST_GCC_FINAL_EXTRA_DOWNLOADS += $(ARCH_XTENSA_OVERLAY_URL)
endif

HOST_GCC_FINAL_POST_PATCH_HOOKS += HOST_GCC_APPLY_PATCHES

# gcc doesn't support in-tree build, so we create a 'build'
# subdirectory in the gcc sources, and build from there.
HOST_GCC_FINAL_SUBDIR = build

HOST_GCC_FINAL_PRE_CONFIGURE_HOOKS += HOST_GCC_CONFIGURE_SYMLINK

# We want to always build the static variants of all the gcc libraries,
# of which libstdc++, libgomp, libmudflap...
# To do so, we can not just pass --enable-static to override the generic
# --disable-static flag, otherwise gcc fails to build some of those
# libraries, see;
#   http://lists.busybox.net/pipermail/buildroot/2013-October/080412.html
#
# So we must completely override the generic commands and provide our own.
#
define HOST_GCC_FINAL_CONFIGURE_CMDS
	(cd $(HOST_GCC_FINAL_SRCDIR) && rm -rf config.cache; \
		$(HOST_CONFIGURE_OPTS) \
		CFLAGS="$(HOST_CFLAGS)" \
		LDFLAGS="$(HOST_LDFLAGS)" \
		$(HOST_GCC_FINAL_CONF_ENV) \
		./configure \
		--prefix="$(HOST_DIR)" \
		--sysconfdir="$(HOST_DIR)/etc" \
		--enable-static \
		$(QUIET) $(HOST_GCC_FINAL_CONF_OPTS) \
	)
endef

# Languages supported by the cross-compiler
GCC_FINAL_CROSS_LANGUAGES-y = c
GCC_FINAL_CROSS_LANGUAGES-$(BR2_INSTALL_LIBSTDCPP) += c++
GCC_FINAL_CROSS_LANGUAGES-$(BR2_TOOLCHAIN_BUILDROOT_DLANG) += d
GCC_FINAL_CROSS_LANGUAGES-$(BR2_TOOLCHAIN_BUILDROOT_FORTRAN) += fortran
GCC_FINAL_CROSS_LANGUAGES = $(subst $(space),$(comma),$(GCC_FINAL_CROSS_LANGUAGES-y))

HOST_GCC_FINAL_CONF_OPTS = \
	$(HOST_GCC_COMMON_CONF_OPTS) \
	--enable-languages=$(GCC_FINAL_CROSS_LANGUAGES) \
	--with-build-time-tools=$(HOST_DIR)/$(GNU_TARGET_NAME)/bin

# The kernel wants to use the -m4-nofpu option to make sure that it
# doesn't use floating point operations.
ifeq ($(BR2_sh4)$(BR2_sh4eb),y)
HOST_GCC_FINAL_CONF_OPTS += "--with-multilib-list=m4,m4-nofpu"
HOST_GCC_FINAL_GCC_LIB_DIR = $(HOST_DIR)/$(GNU_TARGET_NAME)/lib/!m4*
else ifeq ($(BR2_sh4a)$(BR2_sh4aeb),y)
HOST_GCC_FINAL_CONF_OPTS += "--with-multilib-list=m4a,m4a-nofpu"
HOST_GCC_FINAL_GCC_LIB_DIR = $(HOST_DIR)/$(GNU_TARGET_NAME)/lib/!m4*
else
HOST_GCC_FINAL_GCC_LIB_DIR = $(HOST_DIR)/$(GNU_TARGET_NAME)/lib*
endif

ifeq ($(BR2_GCC_SUPPORTS_LIBCILKRTS),y)

# libcilkrts does not support v8
ifeq ($(BR2_sparc),y)
HOST_GCC_FINAL_CONF_OPTS += --disable-libcilkrts
endif

# Pthreads are required to build libcilkrts
ifeq ($(BR2_PTHREADS_NONE),y)
HOST_GCC_FINAL_CONF_OPTS += --disable-libcilkrts
endif

ifeq ($(BR2_STATIC_LIBS),y)
# disable libcilkrts as there is no static version
HOST_GCC_FINAL_CONF_OPTS += --disable-libcilkrts
endif

endif # BR2_GCC_SUPPORTS_LIBCILKRTS

# Disable shared libs like libstdc++ if we do static since it confuses linking
ifeq ($(BR2_STATIC_LIBS),y)
HOST_GCC_FINAL_CONF_OPTS += --disable-shared
else
HOST_GCC_FINAL_CONF_OPTS += --enable-shared
endif

ifeq ($(BR2_GCC_ENABLE_OPENMP),y)
HOST_GCC_FINAL_CONF_OPTS += --enable-libgomp
else
HOST_GCC_FINAL_CONF_OPTS += --disable-libgomp
endif

# End with user-provided options, so that they can override previously
# defined options.
HOST_GCC_FINAL_CONF_OPTS += \
	$(call qstrip,$(BR2_EXTRA_GCC_CONFIG_OPTIONS))

HOST_GCC_FINAL_CONF_ENV = \
	$(HOST_GCC_COMMON_CONF_ENV)

HOST_GCC_FINAL_MAKE_OPTS += $(HOST_GCC_COMMON_MAKE_OPTS)

# Make sure we have 'cc'
define HOST_GCC_FINAL_CREATE_CC_SYMLINKS
	if [ ! -e $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-cc ]; then \
		ln -f $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-gcc \
			$(HOST_DIR)/bin/$(GNU_TARGET_NAME)-cc; \
	fi
endef

HOST_GCC_FINAL_POST_INSTALL_HOOKS += HOST_GCC_FINAL_CREATE_CC_SYMLINKS

HOST_GCC_FINAL_TOOLCHAIN_WRAPPER_ARGS += $(HOST_GCC_COMMON_TOOLCHAIN_WRAPPER_ARGS)
HOST_GCC_FINAL_POST_BUILD_HOOKS += TOOLCHAIN_WRAPPER_BUILD
HOST_GCC_FINAL_POST_INSTALL_HOOKS += TOOLCHAIN_WRAPPER_INSTALL
# Note: this must be done after CREATE_CC_SYMLINKS, otherwise the
# -cc symlink to the wrapper is not created.
HOST_GCC_FINAL_POST_INSTALL_HOOKS += HOST_GCC_INSTALL_WRAPPER_AND_SIMPLE_SYMLINKS

GCC_FINAL_LIBS =

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GCC_FINAL_LIBS += libatomic
endif

ifeq ($(BR2_STATIC_LIBS),)
GCC_FINAL_LIBS += libgcc_s
endif

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
GCC_FINAL_USR_LIBS += libstdc++
endif

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_DLANG),y)
GCC_FINAL_USR_LIBS += libgdruntime libgphobos
endif

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_FORTRAN),y)
GCC_FINAL_USR_LIBS += libgfortran
# fortran needs quadmath on x86 and x86_64
ifeq ($(BR2_TOOLCHAIN_HAS_LIBQUADMATH),y)
GCC_FINAL_USR_LIBS += libquadmath
endif
endif

ifeq ($(BR2_GCC_ENABLE_OPENMP),y)
GCC_FINAL_USR_LIBS += libgomp
endif

GCC_FINAL_USR_LIBS += $(call qstrip,$(BR2_TOOLCHAIN_EXTRA_LIBS))

define GCC_FINAL_INSTALL_STAGING_CMDS
	$(foreach lib,$(GCC_FINAL_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib)* \
			$(STAGING_DIR)/lib/
	)
	$(foreach lib,$(GCC_FINAL_USR_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib)* \
			$(STAGING_DIR)/usr/lib/
	)
endef

ifeq ($(BR2_STATIC_LIBS),)
define GCC_FINAL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib $(TARGET_DIR)/usr/lib
	$(foreach lib,$(GCC_FINAL_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib).so* \
			$(TARGET_DIR)/lib/
	)
	$(foreach lib,$(GCC_FINAL_USR_LIBS), \
		cp -dpf $(HOST_GCC_FINAL_GCC_LIB_DIR)/$(lib).so* \
			$(TARGET_DIR)/usr/lib/
	)
endef
endif

# coldfire is not working without removing these object files from libgcc.a
ifeq ($(BR2_m68k_cf),y)
define GCC_FINAL_M68K_LIBGCC_FIXUP
	find $(STAGING_DIR) -name libgcc.a -print | \
		while read t; do $(GNU_TARGET_NAME)-ar dv "$t" _ctors.o; done
endef
GCC_FINAL_POST_INSTALL_STAGING_HOOKS += HOST_GCC_FINAL_M68K_LIBGCC_FIXUP
endif

$(eval $(generic-package))
$(eval $(host-autotools-package))

################################################################################
#
# libfutils
#
################################################################################

LIBFUTILS_VERSION = c326ce0cc2a7354381265a7664bb215be587fac6
LIBFUTILS_SITE = $(call github,Parrot-Developers,libfutils,$(LIBFUTILS_VERSION))
LIBFUTILS_LICENSE = BSD-3-Clause
LIBFUTILS_LICENSE_FILES = COPYING
LIBFUTILS_DEPENDENCIES = host-alchemy ulog
LIBFUTILS_INSTALL_STAGING = YES

LIBFUTILS_TARGET_ENV = \
	$(ALCHEMY_TARGET_ENV) \
	ALCHEMY_TARGET_SDK_DIRS="$(ALCHEMY_SDK_BASEDIR)/ulog"

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBFUTILS_TARGET_ENV += TARGET_GLOBAL_LDLIBS='-latomic'
endif

define LIBFUTILS_BUILD_CMDS
	$(LIBFUTILS_TARGET_ENV) $(ALCHEMY_MAKE) libfutils
endef

ifeq ($(BR2_STATIC_LIBS),)
# $(1): destination directory: target or staging
define LIBFUTILS_INSTALL_SHARED_LIBS
	mkdir -p $(1)/usr/lib/
	$(INSTALL) -m 644 $(@D)/alchemy-out/staging/usr/lib/libfutils.so* \
		$(1)/usr/lib/
endef
endif

ifeq ($(BR2_SHARED_LIBS),)
define LIBFUTILS_INSTALL_STATIC_LIBS
	mkdir -p $(1)/usr/lib/
	$(INSTALL) -D -m 644 $(@D)/alchemy-out/staging/usr/lib/libfutils.a \
		$(STAGING_DIR)/usr/lib/libfutils.a
endef
endif

define LIBFUTILS_INSTALL_TARGET_CMDS
	$(call LIBFUTILS_INSTALL_SHARED_LIBS, $(TARGET_DIR))
endef

define LIBFUTILS_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/futils
	$(INSTALL) -m 644 $(@D)/include/futils/* \
		$(STAGING_DIR)/usr/include/futils/
	$(LIBFUTILS_INSTALL_STATIC_LIBS)
	$(call LIBFUTILS_INSTALL_SHARED_LIBS, $(STAGING_DIR))
	$(call ALCHEMY_INSTALL_LIB_SDK_FILE, libfutils, libfutils.so, libulog)
endef

$(eval $(generic-package))

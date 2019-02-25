#############################################################
#
# libxdgmime
#
#############################################################
LIBXDGMIME_VERSION = db79e7c
LIBXDGMIME_SITE = $(call github,pcercuei,libxdgmime,$(LIBXDGMIME_VERSION))
LIBXDGMIME_DEPENDENCIES = shared-mime-info
LIBXDGMIME_INSTALL_STAGING = YES

LIBXDGMIME_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				  CROSS_COMPILE="$(TARGET_CROSS)" PREFIX=/usr \
				  PLATFORM="$(BR2_VENDOR)"

define LIBXDGMIME_BUILD_CMDS
	$(LIBXDGMIME_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LIBXDGMIME_INSTALL_STAGING_CMDS
	$(LIBXDGMIME_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install
endef

define LIBXDGMIME_INSTALL_TARGET_CMDS
	$(LIBXDGMIME_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-lib
endef

$(eval $(generic-package))

################################################################################
#
# ulog
#
################################################################################

ULOG_VERSION = 0389d243352255f6182326dccdae3d56dadc078f
ULOG_SITE = $(call github,Parrot-Developers,ulog,$(ULOG_VERSION))
ULOG_LICENSE = Apache-2.0
ULOG_LICENSE_FILES = COPYING
ULOG_DEPENDENCIES = host-alchemy
ULOG_INSTALL_STAGING = YES

define ULOG_BUILD_CMDS
	$(ALCHEMY_TARGET_ENV) $(ALCHEMY_MAKE) libulog
endef

ifeq ($(BR2_SHARED_LIBS),)
define ULOG_INSTALL_STATIC_LIBS
	$(INSTALL) -D -m 644 $(@D)/alchemy-out/staging/usr/lib/libulog.a \
		$(STAGING_DIR)/usr/lib/libulog.a
endef
endif

ifeq ($(BR2_STATIC_LIBS),)
# $(1): destination directory: target or staging
define ULOG_INSTALL_SHARED_LIBS
	mkdir -p $(1)/usr/lib/
	$(INSTALL) -m 644 $(@D)/alchemy-out/staging/usr/lib/libulog.so* \
		$(1)/usr/lib/
endef
endif

define ULOG_INSTALL_TARGET_CMDS
	$(call ULOG_INSTALL_SHARED_LIBS, $(TARGET_DIR))
endef

define ULOG_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/libulog/include/* $(STAGING_DIR)/usr/include/
	$(ULOG_INSTALL_STATIC_LIBS)
	$(call ULOG_INSTALL_SHARED_LIBS, $(STAGING_DIR))
	$(call ALCHEMY_INSTALL_LIB_SDK_FILE, libulog, libulog.so)
endef

$(eval $(generic-package))

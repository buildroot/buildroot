################################################################################
#
# zlog
#
################################################################################

ZLOG_VERSION = 1.2.18
ZLOG_SITE = $(call github,HardySimpson,zlog,$(ZLOG_VERSION))
ZLOG_LICENSE = Apache-2.0
ZLOG_LICENSE_FILES = LICENSE
ZLOG_CPE_ID_VALID = YES
ZLOG_INSTALL_STAGING = YES

define ZLOG_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
		WARNINGS="" -C $(@D) all
endef

define ZLOG_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) PREFIX=$(STAGING_DIR)/usr -C $(@D) install
endef

define ZLOG_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) PREFIX=$(TARGET_DIR)/usr -C $(@D) install
endef

$(eval $(generic-package))

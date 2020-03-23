################################################################################
#
# iniparser
#
################################################################################

INIPARSER_VERSION = 4.1
INIPARSER_SITE = $(call github,ndevilla,iniparser,v$(INIPARSER_VERSION))
INIPARSER_INSTALL_STAGING = YES
INIPARSER_LICENSE = MIT
INIPARSER_LICENSE_FILES = LICENSE
INIPARSER_SO_TARGET = libiniparser.so.1
INIPARSER_A_TARGET = libiniparser.a

INIPARSER_CONFIGURE_OPTS = $(TARGET_CONFIGURE_OPTS)

define INIPARSER_BUILD_CMDS
	$(INIPARSER_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define INIPARSER_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_SO_TARGET) $(STAGING_DIR)/usr/lib/
	$(INSTALL) -D -m 0644 $(@D)/src/iniparser.h $(@D)/src/dictionary.h $(STAGING_DIR)/usr/include/
$(if ifeq ($(BR2_STATIC_LIBS),y),$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_A_TARGET) $(STAGING_DIR)/usr/lib/)
endef

define INIPARSER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_SO_TARGET) $(TARGET_DIR)/usr/lib/
$(if ifeq ($(BR2_STATIC_LIBS),y),$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_A_TARGET) $(TARGET_DIR)/usr/lib/)
endef

define HOST_INIPARSER_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_INIPARSER_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_SO_TARGET) $(HOST_DIR)/usr/lib/
$(if ifeq ($(BR2_STATIC_LIBS),y),$(INSTALL) -D -m 0755 $(@D)/$(INIPARSER_A_TARGET) $(HOST_DIR)/usr/lib/)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

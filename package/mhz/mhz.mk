################################################################################
#
# mhz
#
################################################################################

MHZ_VERSION = 11aac2399780a1f7ea9f007b14af0464797d5cf1
MHZ_SITE = $(call github,wtarreau,mhz,$(MHZ_VERSION))
MHZ_LICENSE = MIT
MHZ_LICENSE_FILES = LICENSE

define MHZ_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define MHZ_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/mhz $(TARGET_DIR)/usr/bin/mhz
endef

$(eval $(generic-package))

################################################################################
#
# p910nd
#
################################################################################

P910ND_VERSION = 0.97
P910ND_SITE = $(call github,kenyapcomau,p910nd,$(P910ND_VERSION))
P910ND_LICENSE = GPL-2.0
P910ND_LICENSE_FILES = LICENSE.md

define P910ND_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define P910ND_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/p910nd $(TARGET_DIR)/usr/sbin/p910nd
endef

$(eval $(generic-package))

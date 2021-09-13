################################################################################
#
# apg
#
################################################################################

APG_VERSION = 2.3.0b
APG_SITE = $(call github,wilx,apg,v$(APG_VERSION))
APG_LICENSE = BSD-3-Clause
APG_LICENSE_FILES = COPYING

define APG_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(APG_CFLAGS)" \
		-C $(@D)
endef

define APG_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/apg $(TARGET_DIR)/usr/bin/apg
endef

$(eval $(generic-package))

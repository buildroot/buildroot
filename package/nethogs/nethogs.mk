################################################################################
#
# nethogs
#
################################################################################

NETHOGS_VERSION = 0.8.8
NETHOGS_SITE = $(call github,raboof,nethogs,v$(NETHOGS_VERSION))
NETHOGS_LICENSE = GPL-2.0+
NETHOGS_LICENSE_FILES = COPYING
NETHOGS_DEPENDENCIES = libpcap ncurses

define NETHOGS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) nethogs
endef

define NETHOGS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/nethogs $(TARGET_DIR)/usr/sbin/nethogs
endef

$(eval $(generic-package))

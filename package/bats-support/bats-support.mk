################################################################################
#
# bats-support
#
################################################################################

BATS_SUPPORT_VERSION = 0.3.0
BATS_SUPPORT_SITE = $(call github,bats-core,bats-support,v$(BATS_SUPPORT_VERSION))
BATS_SUPPORT_LICENSE = CC0-1.0
BATS_SUPPORT_LICENSE_FILES = LICENSE

define BATS_SUPPORT_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/bats/bats-support/src
	$(INSTALL) -m 0755 $(@D)/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-support
	$(INSTALL) -m 0755 $(@D)/src/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-support/src
endef

$(eval $(generic-package))

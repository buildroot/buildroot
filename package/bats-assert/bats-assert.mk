################################################################################
#
# bats-assert
#
################################################################################

BATS_ASSERT_VERSION = 2.1.0
BATS_ASSERT_SITE = $(call github,bats-core,bats-assert,v$(BATS_ASSERT_VERSION))
BATS_ASSERT_LICENSE = CC0-1.0
BATS_ASSERT_LICENSE_FILES = LICENSE

define BATS_ASSERT_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/bats/bats-assert/src
	$(INSTALL) -m 0755 $(@D)/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-assert
	$(INSTALL) -m 0755 $(@D)/src/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-assert/src
endef

$(eval $(generic-package))

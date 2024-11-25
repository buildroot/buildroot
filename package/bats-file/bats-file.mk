################################################################################
#
# bats-file
#
################################################################################

BATS_FILE_VERSION = 0.4.0
BATS_FILE_SITE = $(call github,bats-core,bats-file,v$(BATS_FILE_VERSION))
BATS_FILE_LICENSE = CC0-1.0
BATS_FILE_LICENSE_FILES = LICENSE

define BATS_FILE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/lib/bats/bats-file/src
	$(INSTALL) -m 0755 $(@D)/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-file
	$(INSTALL) -m 0755 $(@D)/src/*.bash -t $(TARGET_DIR)/usr/lib/bats/bats-file/src
endef

$(eval $(generic-package))

################################################################################
#
# bfscripts
#
################################################################################

BFSCRIPTS_VERSION = 3.9.7-1
BFSCRIPTS_SITE = $(call github,Mellanox,bfscripts,$(BFSCRIPTS_VERSION))
BFSCRIPTS_LICENSE = BSD-2-Clause
BFSCRIPTS_LICENSE_FILES = LICENSE

BFSCRIPTS_FILES_TO_INSTALL = \
	bfcfg \
	bfrshlog \
	bfup

define BFSCRIPTS_INSTALL_TARGET_CMDS
	$(foreach f,$(BFSCRIPTS_FILES_TO_INSTALL),\
		$(INSTALL) -D -m 0755 $(@D)/$(f) $(TARGET_DIR)/usr/bin/$(f)
	)
endef

define BFSCRIPTS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/bfscripts/S99bfup \
		$(TARGET_DIR)/etc/init.d/S99bfup
endef

$(eval $(generic-package))

################################################################################
#
# Websocketd
#
################################################################################

WEBSOCKETD_VERSION = 0.4.1
WEBSOCKETD_SOURCE = websocketd-$(WEBSOCKETD_VERSION)-linux_arm.zip
WEBSOCKETD_SITE = https://github.com/joewalnes/websocketd/releases/download/v$(WEBSOCKETD_VERSION)
WEBSOCKETD_LICENSE = BSD-2-Clause
WEBSOCKETD_LICENSE_FILES = LICENSE

define WEBSOCKETD_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(WEBSOCKETD_DL_DIR)/$(WEBSOCKETD_SOURCE)
endef

define WEBSOCKETD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/websocketd $(TARGET_DIR)/usr/sbin/websocketd
endef

$(eval $(generic-package))

################################################################################
#
# odhcp6c
#
################################################################################

ODHCP6C_VERSION = f19dd37fb467c9cf10cad57aefa0d048312d7dfd
ODHCP6C_SITE = https://git.openwrt.org/project/odhcp6c.git
ODHCP6C_SITE_METHOD = git
ODHCP6C_LICENSE = GPL-2.0
ODHCP6C_LICENSE_FILES = COPYING
ODHCP6C_DEPENDENCIES = libubox

define ODHCP6C_INSTALL_SCRIPT
	$(INSTALL) -m 0755 -D $(@D)/odhcp6c-example-script.sh \
		$(TARGET_DIR)/usr/sbin/odhcp6c-update
endef

ODHCP6C_POST_INSTALL_TARGET_HOOKS += ODHCP6C_INSTALL_SCRIPT

$(eval $(cmake-package))

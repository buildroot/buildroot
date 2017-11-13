################################################################################
#
# peervpn
#
################################################################################

PEERVPN_VERSION = 0.044
PEERVPN_SOURCE = peervpn-$(subst .,-,$(PEERVPN_VERSION)).tar.gz
PEERVPN_SITE = https://peervpn.net/files
PEERVPN_DEPENDENCIES = openssl zlib
PEERVPN_LICENSE = GPLv3
PEERVPN_LICENSE_FILES = license.txt

define PEERVPN_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define PEERVPN_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/peervpn $(TARGET_DIR)/usr/sbin/peervpn
	$(INSTALL) -m 0644 -D $(@D)/peervpn.conf $(TARGET_DIR)/etc/peervpn.conf
endef

$(eval $(generic-package))

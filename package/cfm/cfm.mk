################################################################################
#
# cfm
#
################################################################################

CFM_VERSION = 0.3
CFM_SITE = $(call github,microchip-ung,cfm,v$(CFM_VERSION))
CFM_DEPENDENCIES = libev libmnl libnl
CFM_LICENSE = GPL-2.0
CFM_LICENSE_FILES = LICENSE
CFM_INSTALL_STAGING = YES

define CFM_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D $(CFM_PKGDIR)/S65cfm \
		$(TARGET_DIR)/etc/init.d/S65cfm
endef

define CFM_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(CFM_PKGDIR)/cfm.service \
		$(TARGET_DIR)/usr/lib/systemd/system/cfm.service
endef

$(eval $(cmake-package))

################################################################################
#
# hwdata
#
################################################################################

HWDATA_VERSION = 0.373
HWDATA_SITE = $(call github,vcrhonek,hwdata,v$(HWDATA_VERSION))
HWDATA_LICENSE = GPL-2.0+, BSD-3-Clause, XFree86 1.0
HWDATA_LICENSE_FILES = COPYING LICENSE
HWDATA_INSTALL_STAGING = YES

HWDATA_FILES = \
	$(if $(BR2_PACKAGE_HWDATA_IAB_OUI_TXT),iab.txt oui.txt) \
	$(if $(BR2_PACKAGE_HWDATA_PCI_IDS),pci.ids) \
	$(if $(BR2_PACKAGE_HWDATA_PNP_IDS),pnp.ids) \
	$(if $(BR2_PACKAGE_HWDATA_USB_IDS),usb.ids)

define HWDATA_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./configure)
endef

define HWDATA_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) hwdata.pc
endef

ifneq ($(strip $(HWDATA_FILES)),)
define HWDATA_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/hwdata.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/hwdata.pc
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/share/hwdata
	$(INSTALL) -m 644 -t $(STAGING_DIR)/usr/share/hwdata \
		$(addprefix $(@D)/,$(HWDATA_FILES))
endef
define HWDATA_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 755 $(TARGET_DIR)/usr/share/hwdata
	$(INSTALL) -m 644 -t $(TARGET_DIR)/usr/share/hwdata \
		$(addprefix $(@D)/,$(HWDATA_FILES))
endef
endif

$(eval $(generic-package))

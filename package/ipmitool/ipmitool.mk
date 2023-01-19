################################################################################
#
# ipmitool
#
################################################################################

IPMITOOL_VERSION = 1_8_19
IPMITOOL_SITE = $(call github,ipmitool,ipmitool,IPMITOOL_$(IPMITOOL_VERSION))
IPMITOOL_LICENSE = BSD-3-Clause
IPMITOOL_LICENSE_FILES = COPYING
IPMITOOL_CPE_ID_VENDOR = ipmitool_project
# From git
IPMITOOL_AUTORECONF = YES
IPMITOOL_DEPENDENCIES = host-pkgconf

IPMITOOL_CONF_OPTS = --disable-registry-download

ifeq ($(BR2_PACKAGE_FREEIPMI),y)
IPMITOOL_DEPENDENCIES += freeipmi
IPMITOOL_CONF_OPTS += --enable-intf-free
else
IPMITOOL_CONF_OPTS += --disable-intf-free
endif

ifeq ($(BR2_PACKAGE_IPMITOOL_LANPLUS),y)
IPMITOOL_DEPENDENCIES += openssl
IPMITOOL_CONF_OPTS += --enable-intf-lanplus
else
IPMITOOL_CONF_OPTS += --disable-intf-lanplus
endif

ifeq ($(BR2_PACKAGE_IPMITOOL_USB),y)
IPMITOOL_CONF_OPTS += --enable-intf-usb
else
IPMITOOL_CONF_OPTS += --disable-intf-usb
endif

ifeq ($(BR2_PACKAGE_IPMITOOL_IPMISHELL),y)
IPMITOOL_DEPENDENCIES += readline
IPMITOOL_CONF_OPTS += --enable-ipmishell
else
IPMITOOL_CONF_OPTS += --disable-ipmishell
endif

ifeq ($(BR2_PACKAGE_IPMITOOL_IPMIEVD),)
define IPMITOOL_REMOVE_IPMIEVD
	$(RM) -f $(TARGET_DIR)/usr/sbin/ipmievd
endef
IPMITOOL_POST_INSTALL_TARGET_HOOKS += IPMITOOL_REMOVE_IPMIEVD
endif

IPMITOOL_PEN_REG_URI = $(call qstrip,$(BR2_PACKAGE_IPMITOOL_PEN_REG_URI))
ifneq ($(IPMITOOL_PEN_REG_URI),)
ifneq ($(findstring ://,$(IPMITOOL_PEN_REG_URI)),)
IPMITOOL_EXTRA_DOWNLOADS += $(IPMITOOL_PEN_REG_URI)
BR_NO_CHECK_HASH_FOR += $(notdir $(IPMITOOL_PEN_REG_URI))
IPMITOOL_PEN_REG = $(IPMITOOL_DL_DIR)/$(notdir $(IPMITOOL_PEN_REG_URI))
else
IPMITOOL_PEN_REG = $(IPMITOOL_PEN_REG_URI)
endif #findstring
define IPMITOOL_INSTALL_PEN_REG
	$(INSTALL) -D -m 0644 $(IPMITOOL_PEN_REG) \
		$(TARGET_DIR)/usr/share/misc/enterprise-numbers
endef
IPMITOOL_POST_INSTALL_TARGET_HOOKS += IPMITOOL_INSTALL_PEN_REG
endif # IPMITOOL_PEN_REG_URI !empty

$(eval $(autotools-package))

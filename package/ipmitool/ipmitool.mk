################################################################################
#
# ipmitool
#
################################################################################

IPMITOOL_VERSION = 1_8_19
IPMITOOL_SOURCE = IPMITOOL_$(IPMITOOL_VERSION).tar.gz
IPMITOOL_SITE = https://github.com/ipmitool/ipmitool/archive/refs/tags
IPMITOOL_LICENSE = BSD-3-Clause
IPMITOOL_LICENSE_FILES = COPYING
IPMITOOL_CPE_ID_VENDOR = ipmitool_project
# From git
IPMITOOL_AUTORECONF = YES

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
IPMITOOL_DEPENDENCIES += host-pkgconf readline
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

$(eval $(autotools-package))

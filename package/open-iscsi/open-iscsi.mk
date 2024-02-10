################################################################################
#
# open-iscsi
#
################################################################################

OPEN_ISCSI_VERSION = 2.1.9
OPEN_ISCSI_SITE = $(call github,open-iscsi,open-iscsi,$(OPEN_ISCSI_VERSION))
OPEN_ISCSI_LICENSE = GPL-2.0+, GPL-3.0+, LGPL-3.0+
OPEN_ISCSI_LICENSE_FILES = COPYING README libopeniscsiusr/COPYING
OPEN_ISCSI_CPE_ID_VALID = YES
OPEN_ISCSI_DEPENDENCIES = kmod open-isns openssl util-linux

OPEN_ISCSI_CONF_OPTS = -Ddbroot=/var/lib/iscsi

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
OPEN_ISCSI_DEPENDENCIES += systemd
OPEN_ISCSI_CONF_OPTS += -Dno_systemd=false
else
OPEN_ISCSI_CONF_OPTS += -Dno_systemd=true
endif

define OPEN_ISCSI_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_SCSI_LOWLEVEL)
	$(call KCONFIG_ENABLE_OPT,CONFIG_ISCSI_TCP)
endef

$(eval $(meson-package))

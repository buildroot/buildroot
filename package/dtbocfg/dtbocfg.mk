################################################################################
#
# dtbocfg
#
################################################################################

DTBOCFG_VERSION = 0.1.0
DTBOCFG_SITE = $(call github,ikwzm,dtbocfg,v$(DTBOCFG_VERSION))
DTBOCFG_LICENSE = BSD-2-Clause
DTBOCFG_LICENSE_FILES = LICENSE

define DTBOCFG_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_OF_OVERLAY)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CONFIGFS_FS)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

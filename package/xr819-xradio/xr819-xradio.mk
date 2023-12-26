################################################################################
#
# xr819-xradio
#
################################################################################

XR819_XRADIO_VERSION = 3a1f77fb2db248b7d18d93b67b16e0d6c91db184
XR819_XRADIO_SITE = $(call github,fifteenhex,xradio,$(XR819_XRADIO_VERSION))
XR819_XRADIO_LICENSE = GPL-2.0
XR819_XRADIO_LICENSE_FILES = LICENSE

define XR819_XRADIO_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PM)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

################################################################################
#
# rtl8821au
#
################################################################################

RTL8821AU_VERSION = e0b443940471c166a5cc6280d3608f95228e017f
RTL8821AU_SITE = $(call github,lwfinger,rtl8812au,$(RTL8821AU_VERSION))
RTL8821AU_LICENSE = GPL-2.0
RTL8821AU_LICENSE_FILES = LICENSE

define RTL8821AU_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
endef

RTL8821AU_MODULE_MAKE_OPTS = \
	CONFIG_RTL8812AU_8821AU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
		-Wno-error"

$(eval $(kernel-module))
$(eval $(generic-package))

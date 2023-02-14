################################################################################
#
# rtl8812au-aircrack-ng
#
################################################################################

RTL8812AU_AIRCRACK_NG_VERSION = d98018d038a5db96066e79f26ed4a72f2fe1774e
RTL8812AU_AIRCRACK_NG_SITE = $(call github,aircrack-ng,rtl8812au,$(RTL8812AU_AIRCRACK_NG_VERSION))
RTL8812AU_AIRCRACK_NG_LICENSE = GPL-2.0
RTL8812AU_AIRCRACK_NG_LICENSE_FILES = LICENSE

RTL8812AU_AIRCRACK_NG_EXTRA_CFLAGS = \
	-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
	-DCONFIG_IOCTL_CFG80211 \
	-DRTW_USE_CFG80211_STA_EVENT \
	-Wno-error=address \
	-Wno-error=array-bounds \
	-Wno-error=cast-function-type

RTL8812AU_AIRCRACK_NG_MODULE_MAKE_OPTS = \
	CONFIG_PLATFORM_I386_PC=n \
	CONFIG_88XXAU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="$(RTL8812AU_AIRCRACK_NG_EXTRA_CFLAGS)"

define RTL8812AU_AIRCRACK_NG_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

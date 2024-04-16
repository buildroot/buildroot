################################################################################
#
# rtl8723ds
#
################################################################################

RTL8723DS_VERSION = 52e593e8c889b68ba58bd51cbdbcad7fe71362e4
RTL8723DS_SITE = $(call github,lwfinger,rtl8723ds,$(RTL8723DS_VERSION))
RTL8723DS_LICENSE = GPL-2.0
RTL8723DS_LICENSE_FILES = COPYING

RTL8723DS_USER_EXTRA_CFLAGS = \
	-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
	-DCONFIG_IOCTL_CFG80211 \
	-DRTW_USE_CFG80211_STA_EVENT \
	-Wno-error

RTL8723DS_MODULE_MAKE_OPTS = \
	CONFIG_PLATFORM_I386_PC=n \
	CONFIG_RTL8723DS=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR) \
	USER_EXTRA_CFLAGS="$(RTL8723DS_USER_EXTRA_CFLAGS)"

define RTL8723DS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

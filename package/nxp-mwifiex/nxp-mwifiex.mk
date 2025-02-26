################################################################################
#
# nxp-mwifiex
#
################################################################################

NXP_MWIFIEX_VERSION = lf-6.6.52_2.2.0
NXP_MWIFIEX_SITE = $(call github,nxp-imx,mwifiex,$(NXP_MWIFIEX_VERSION))
NXP_MWIFIEX_LICENSE = GPL-2.0
NXP_MWIFIEX_LICENSE_FILES = LICENSE

NXP_MWIFIEX_MAKE_OPTS = KERNELDIR=$(LINUX_DIR)

define NXP_MWIFIEX_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MMC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PCI)
	$(call KCONFIG_ENABLE_OPT,CONFIG_RTC_CLASS)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

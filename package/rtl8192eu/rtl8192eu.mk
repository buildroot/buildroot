################################################################################
#
# rtl8192eu
#
################################################################################

RTL8192EU_VERSION = 1e15b6d451731bc4d3ffd587194dc4bd0f286ac0
RTL8192EU_SITE = $(call github,clnhub,rtl8192eu-linux,$(RTL8192EU_VERSION))
RTL8192EU_LICENSE = GPL-2.0
RTL8192EU_MODULE_MAKE_OPTS = \
	CONFIG_RTL8192EU=m \
	USER_EXTRA_CFLAGS="-Wno-error"

define RTL8192EU_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
endef

$(eval $(kernel-module))
$(eval $(generic-package))

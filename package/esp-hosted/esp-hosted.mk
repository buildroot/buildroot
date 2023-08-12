################################################################################
#
# esp-hosted
#
################################################################################

ESP_HOSTED_VERSION = 11e90f185a5a9922343e73e44032816a0e3ddedb
ESP_HOSTED_SITE = $(call github,espressif,esp-hosted,$(ESP_HOSTED_VERSION))
ESP_HOSTED_DEPENDENCIES = linux
ESP_HOSTED_LICENSE = GPL-2.0
ESP_HOSTED_LICENSE_FILE = LICENSE
ESP_HOSTED_MODULE_SUBDIRS = esp_hosted_ng/host

define ESP_HOSTED_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_BT)
	$(if $(BR2_PACKAGE_ESP_HOSTED_SPI),
		$(call KCONFIG_ENABLE_OPT,CONFIG_SPI),
		$(call KCONFIG_ENABLE_OPT,CONFIG_MMC))
endef

ifeq ($(BR2_PACKAGE_ESP_HOSTED_SPI),y)
ESP_HOSTED_MODULE_MAKE_OPTS = target=spi
else
ESP_HOSTED_MODULE_MAKE_OPTS = target=sdio
endif

$(eval $(kernel-module))
$(eval $(generic-package))

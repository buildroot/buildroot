################################################################################
#
# rtl8189es
#
################################################################################

RTL8189ES_VERSION = 2c8d44ae26485052f39d933a3a132b3ff395803a
RTL8189ES_SITE = $(call github,jwrdegoede,rtl8189ES_linux,$(RTL8189ES_VERSION))
RTL8189ES_LICENSE = GPL-2.0

RTL8189ES_MODULE_MAKE_OPTS = \
	CONFIG_RTL8189ES=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))

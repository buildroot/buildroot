################################################################################
#
# rtl8812au-aircrack-ng
#
################################################################################

RTL8812AU_AIRCRACK_NG_VERSION = 3a6402e9e79802891f1531b435be54f4d8b71f0b
RTL8812AU_AIRCRACK_NG_SITE = $(call github,aircrack-ng,rtl8812au,$(RTL8812AU_AIRCRACK_NG_VERSION))
RTL8812AU_AIRCRACK_NG_LICENSE = GPL-2.0
RTL8812AU_AIRCRACK_NG_LICENSE_FILES = LICENSE

RTL8812AU_AIRCRACK_NG_MODULE_MAKE_OPTS = \
	CONFIG_88XXAU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN"

$(eval $(kernel-module))
$(eval $(generic-package))

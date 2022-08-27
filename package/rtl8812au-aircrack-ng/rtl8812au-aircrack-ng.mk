################################################################################
#
# rtl8812au-aircrack-ng
#
################################################################################

RTL8812AU_AIRCRACK_NG_VERSION = e7a4a390ccbdd768411e1b2a8922c47837f76b47
RTL8812AU_AIRCRACK_NG_SITE = $(call github,aircrack-ng,rtl8812au,$(RTL8812AU_AIRCRACK_NG_VERSION))
RTL8812AU_AIRCRACK_NG_LICENSE = GPL-2.0
RTL8812AU_AIRCRACK_NG_LICENSE_FILES = LICENSE

RTL8812AU_AIRCRACK_NG_EXTRA_CFLAGS = \
	-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
	-Wno-error=address \
	-Wno-error=array-bounds \
	-Wno-error=cast-function-type

RTL8812AU_AIRCRACK_NG_MODULE_MAKE_OPTS = \
	CONFIG_88XXAU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="$(RTL8812AU_AIRCRACK_NG_EXTRA_CFLAGS)"

$(eval $(kernel-module))
$(eval $(generic-package))

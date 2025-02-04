################################################################################
#
# cross-ldd
#
################################################################################

CROSS_LDD_VERSION = 1.26.0
CROSS_LDD_SITE = https://github.com/crosstool-ng/crosstool-ng/releases/download/crosstool-ng-$(CROSS_LDD_VERSION)
CROSS_LDD_SOURCE = crosstool-ng-$(CROSS_LDD_VERSION).tar.xz
CROSS_LDD_LICENSE = GPL-2.0
CROSS_LDD_LICENSE_FILES = COPYING

ifeq ($(BR2_ARCH_IS_64),y)
CROSS_LDD_BITNESS = 64
else
CROSS_LDD_BITNESS = 32
endif

CROSS_LDD_TOOLS_PREFIX = $(patsubst %-,%,$(TARGET_CROSS))

define HOST_CROSS_LDD_CONFIGURE_CMDS
	sed \
		-e "s%@@CT_bash@@%/usr/bin/env bash%" \
		-e "s%@@CT_VERSION@@%$(CROSS_LDD_VERSION)%" \
		-e "s%@@CT_BITS@@%$(CROSS_LDD_BITNESS)%" \
		-e "s%@@CT_sed@@%sed%" \
		-e "s%@@CT_grep@@%grep%" \
		-e "s%^prefix=.*%prefix=$(CROSS_LDD_TOOLS_PREFIX)%" \
		$(@D)/scripts/xldd.in > \
		$(@D)/scripts/xldd
endef

define HOST_CROSS_LDD_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/scripts/xldd $(TARGET_CROSS)xldd
endef

$(eval $(host-generic-package))

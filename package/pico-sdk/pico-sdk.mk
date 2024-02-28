################################################################################
#
# pico-sdk
#
################################################################################

PICO_SDK_VERSION = 1.5.1
PICO_SDK_SITE = $(call github,raspberrypi,pico-sdk,$(PICO_SDK_VERSION))
PICO_SDK_LICENSE = BSD-3-Clause
PICO_SDK_LICENSE_FILES = LICENSE.TXT
PICO_SDK_INSTALL_STAGING = YES
# Header-only lib, as far as buildroot is concerned
PICO_SDK_INSTALL_TARGET = NO

define PICO_SDK_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/share/pico-sdk
	cp -r $(@D)/* $(STAGING_DIR)/usr/share/pico-sdk
endef

$(eval $(generic-package))

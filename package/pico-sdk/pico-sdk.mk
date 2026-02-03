################################################################################
#
# pico-sdk
#
################################################################################

PICO_SDK_VERSION = 2.2.0
PICO_SDK_SITE = https://github.com/raspberrypi/pico-sdk.git
PICO_SDK_SITE_METHOD = git
PICO_SDK_GIT_SUBMODULES = YES
PICO_SDK_LICENSE = BSD-3-Clause
PICO_SDK_LICENSE_FILES = LICENSE.TXT
PICO_SDK_INSTALL_STAGING = YES
# Header-only lib, as far as buildroot is concerned
PICO_SDK_INSTALL_TARGET = NO

define PICO_SDK_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/share/pico-sdk
	cp -r $(@D)/* $(STAGING_DIR)/usr/share/pico-sdk
endef

define HOST_PICO_SDK_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/share/pico-sdk
	cp -r $(@D)/* $(HOST_DIR)/share/pico-sdk
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

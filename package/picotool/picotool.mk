################################################################################
#
# picotool
#
################################################################################

PICOTOOL_VERSION = 2.2.0-a4
PICOTOOL_SITE = $(call github,raspberrypi,picotool,$(PICOTOOL_VERSION))
PICOTOOL_LICENSE = BSD-3-Clause
PICOTOOL_LICENSE_FILES = LICENSE.TXT

PICOTOOL_CONF_OPTS = -DPICO_SDK_PATH=$(STAGING_DIR)/usr/share/pico-sdk
PICOTOOL_DEPENDENCIES = libusb pico-sdk

HOST_PICOTOOL_CONF_OPTS = -DPICO_SDK_PATH=$(HOST_DIR)/usr/share/pico-sdk
HOST_PICOTOOL_DEPENDENCIES = host-libusb host-pico-sdk

$(eval $(cmake-package))
$(eval $(host-cmake-package))

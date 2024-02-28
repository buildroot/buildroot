################################################################################
#
# picotool
#
################################################################################

PICOTOOL_VERSION = 1.1.2
PICOTOOL_SITE = $(call github,raspberrypi,picotool,$(PICOTOOL_VERSION))
PICOTOOL_CONF_OPTS = -DPICO_SDK_PATH=$(STAGING_DIR)/usr/share/pico-sdk
PICOTOOL_DEPENDENCIES = libusb pico-sdk
PICOTOOL_LICENSE = BSD-3-Clause
PICOTOOL_LICENSE_FILES = LICENSE.TXT

$(eval $(cmake-package))

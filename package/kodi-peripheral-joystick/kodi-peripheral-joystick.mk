################################################################################
#
# kodi-peripheral-joystick
#
################################################################################

KODI_PERIPHERAL_JOYSTICK_VERSION = 19.0.1-Matrix
KODI_PERIPHERAL_JOYSTICK_SITE = $(call github,xbmc,peripheral.joystick,$(KODI_PERIPHERAL_JOYSTICK_VERSION))
KODI_PERIPHERAL_JOYSTICK_LICENSE = GPL-2.0+
KODI_PERIPHERAL_JOYSTICK_LICENSE_FILES = LICENSE.md
KODI_PERIPHERAL_JOYSTICK_DEPENDENCIES = kodi tinyxml udev

$(eval $(cmake-package))

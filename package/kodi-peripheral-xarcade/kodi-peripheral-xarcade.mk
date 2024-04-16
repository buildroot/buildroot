################################################################################
#
# kodi-peripheral-xarcade
#
################################################################################

KODI_PERIPHERAL_XARCADE_VERSION = 20.1.3-Nexus
KODI_PERIPHERAL_XARCADE_SITE = $(call github,kodi-game,peripheral.xarcade,$(KODI_PERIPHERAL_XARCADE_VERSION))
KODI_PERIPHERAL_XARCADE_LICENSE = GPL-2.0+
KODI_PERIPHERAL_XARCADE_LICENSE_FILES = LICENSE.md
KODI_PERIPHERAL_XARCADE_DEPENDENCIES = kodi

$(eval $(cmake-package))

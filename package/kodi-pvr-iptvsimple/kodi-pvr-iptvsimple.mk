################################################################################
#
# kodi-pvr-iptvsimple
#
################################################################################

KODI_PVR_IPTVSIMPLE_VERSION = 21.10.2-Omega
KODI_PVR_IPTVSIMPLE_SITE = $(call github,kodi-pvr,pvr.iptvsimple,$(KODI_PVR_IPTVSIMPLE_VERSION))
KODI_PVR_IPTVSIMPLE_LICENSE = GPL-2.0+
KODI_PVR_IPTVSIMPLE_LICENSE_FILES = LICENSE.md
KODI_PVR_IPTVSIMPLE_DEPENDENCIES = kodi pugixml xz zlib

$(eval $(cmake-package))

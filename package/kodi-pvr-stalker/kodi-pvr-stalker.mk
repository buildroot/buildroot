################################################################################
#
# kodi-pvr-stalker
#
################################################################################

KODI_PVR_STALKER_VERSION = 19.0.2-Matrix
KODI_PVR_STALKER_SITE = $(call github,kodi-pvr,pvr.stalker,$(KODI_PVR_STALKER_VERSION))
KODI_PVR_STALKER_LICENSE = GPL-2.0+
KODI_PVR_STALKER_LICENSE_FILES = LICENSE.md
KODI_PVR_STALKER_DEPENDENCIES = jsoncpp kodi libxml2

$(eval $(cmake-package))

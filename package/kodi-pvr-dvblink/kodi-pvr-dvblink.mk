################################################################################
#
# kodi-pvr-dvblink
#
################################################################################

KODI_PVR_DVBLINK_VERSION = 20.3.0-Nexus
KODI_PVR_DVBLINK_SITE = $(call github,kodi-pvr,pvr.dvblink,$(KODI_PVR_DVBLINK_VERSION))
KODI_PVR_DVBLINK_LICENSE = GPL-2.0+
KODI_PVR_DVBLINK_LICENSE_FILES = LICENSE.md
KODI_PVR_DVBLINK_DEPENDENCIES = kodi tinyxml2

$(eval $(cmake-package))

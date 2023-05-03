################################################################################
#
# kodi-pvr-plutotv
#
################################################################################

KODI_PVR_PLUTOTV_VERSION = 20.3.0-Nexus
KODI_PVR_PLUTOTV_SITE = $(call github,kodi-pvr,pvr.plutotv,$(KODI_PVR_PLUTOTV_VERSION))
KODI_PVR_PLUTOTV_LICENSE = GPL-2.0+
KODI_PVR_PLUTOTV_LICENSE_FILES = LICENSE.md
KODI_PVR_PLUTOTV_DEPENDENCIES = kodi rapidjson

$(eval $(cmake-package))

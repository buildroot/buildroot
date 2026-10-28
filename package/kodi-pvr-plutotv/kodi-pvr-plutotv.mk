################################################################################
#
# kodi-pvr-plutotv
#
################################################################################

KODI_PVR_PLUTOTV_VERSION = 22.3.2-Piers
KODI_PVR_PLUTOTV_SITE = $(call github,kodi-pvr,pvr.plutotv,$(KODI_PVR_PLUTOTV_VERSION))
KODI_PVR_PLUTOTV_LICENSE = GPL-2.0+
KODI_PVR_PLUTOTV_LICENSE_FILES = LICENSE.md
KODI_PVR_PLUTOTV_DEPENDENCIES = json-for-modern-cpp kodi

$(eval $(cmake-package))

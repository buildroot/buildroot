################################################################################
#
# kodi-pvr-njoy
#
################################################################################

KODI_PVR_NJOY_VERSION = 19.0.1-Matrix
KODI_PVR_NJOY_SITE = $(call github,kodi-pvr,pvr.njoy,$(KODI_PVR_NJOY_VERSION))
KODI_PVR_NJOY_LICENSE = GPL-2.0+
KODI_PVR_NJOY_LICENSE_FILES = LICENSE.md
KODI_PVR_NJOY_DEPENDENCIES = kodi tinyxml

$(eval $(cmake-package))

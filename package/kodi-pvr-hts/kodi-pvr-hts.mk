################################################################################
#
# kodi-pvr-hts
#
################################################################################

KODI_PVR_HTS_VERSION = 21.2.6-Omega
KODI_PVR_HTS_SITE = $(call github,kodi-pvr,pvr.hts,$(KODI_PVR_HTS_VERSION))
KODI_PVR_HTS_LICENSE = GPL-2.0+
KODI_PVR_HTS_LICENSE_FILES = LICENSE.md
KODI_PVR_HTS_DEPENDENCIES = kodi

$(eval $(cmake-package))

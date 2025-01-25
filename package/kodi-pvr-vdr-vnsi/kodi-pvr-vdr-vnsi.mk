################################################################################
#
# kodi-pvr-vdr-vnsi
#
################################################################################

KODI_PVR_VDR_VNSI_VERSION = 21.1.3-Omega
KODI_PVR_VDR_VNSI_SITE = $(call github,kodi-pvr,pvr.vdr.vnsi,$(KODI_PVR_VDR_VNSI_VERSION))
KODI_PVR_VDR_VNSI_LICENSE = GPL-2.0+
KODI_PVR_VDR_VNSI_LICENSE_FILES = LICENSE.md
KODI_PVR_VDR_VNSI_DEPENDENCIES = kodi

$(eval $(cmake-package))

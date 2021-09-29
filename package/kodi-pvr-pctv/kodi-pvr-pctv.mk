################################################################################
#
# kodi-pvr-pctv
#
################################################################################

KODI_PVR_PCTV_VERSION = 6.1.1-Matrix
KODI_PVR_PCTV_SITE = $(call github,kodi-pvr,pvr.pctv,$(KODI_PVR_PCTV_VERSION))
KODI_PVR_PCTV_LICENSE = GPL-2.0+
KODI_PVR_PCTV_LICENSE_FILES = LICENSE.md
KODI_PVR_PCTV_DEPENDENCIES = jsoncpp kodi

$(eval $(cmake-package))

################################################################################
#
# kodi-pvr-vuplus
#
################################################################################

KODI_PVR_VUPLUS_VERSION = 7.4.11-Matrix
KODI_PVR_VUPLUS_SITE = $(call github,kodi-pvr,pvr.vuplus,$(KODI_PVR_VUPLUS_VERSION))
KODI_PVR_VUPLUS_LICENSE = GPL-2.0+
KODI_PVR_VUPLUS_LICENSE_FILES = LICENSE.md
KODI_PVR_VUPLUS_DEPENDENCIES = json-for-modern-cpp kodi tinyxml

$(eval $(cmake-package))

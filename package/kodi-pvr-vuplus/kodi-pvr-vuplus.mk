################################################################################
#
# kodi-pvr-vuplus
#
################################################################################

KODI_PVR_VUPLUS_VERSION = 21.3.2-Omega
KODI_PVR_VUPLUS_SITE = $(call github,kodi-pvr,pvr.vuplus,$(KODI_PVR_VUPLUS_VERSION))
KODI_PVR_VUPLUS_LICENSE = GPL-2.0+
KODI_PVR_VUPLUS_LICENSE_FILES = LICENSE.md
KODI_PVR_VUPLUS_DEPENDENCIES = json-for-modern-cpp kodi tinyxml

$(eval $(cmake-package))

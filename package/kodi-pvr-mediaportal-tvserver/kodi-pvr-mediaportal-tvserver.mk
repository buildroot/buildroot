################################################################################
#
# kodi-pvr-mediaportal-tvserver
#
################################################################################

KODI_PVR_MEDIAPORTAL_TVSERVER_VERSION = 19.0.2-Matrix
KODI_PVR_MEDIAPORTAL_TVSERVER_SITE = $(call github,kodi-pvr,pvr.mediaportal.tvserver,$(KODI_PVR_MEDIAPORTAL_TVSERVER_VERSION))
KODI_PVR_MEDIAPORTAL_TVSERVER_LICENSE = GPL-2.0+
KODI_PVR_MEDIAPORTAL_TVSERVER_LICENSE_FILES = LICENSE.md
KODI_PVR_MEDIAPORTAL_TVSERVER_DEPENDENCIES = kodi tinyxml

$(eval $(cmake-package))

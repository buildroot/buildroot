################################################################################
#
# kodi-pvr-argustv
#
################################################################################

KODI_PVR_ARGUSTV_VERSION = 19.2.1-Matrix
KODI_PVR_ARGUSTV_SITE = $(call github,kodi-pvr,pvr.argustv,$(KODI_PVR_ARGUSTV_VERSION))
KODI_PVR_ARGUSTV_LICENSE = GPL-2.0+
KODI_PVR_ARGUSTV_LICENSE_FILES = LICENSE.md
KODI_PVR_ARGUSTV_DEPENDENCIES = jsoncpp kodi

$(eval $(cmake-package))

################################################################################
#
# kodi-pvr-waipu
#
################################################################################

KODI_PVR_WAIPU_VERSION = 20.9.0-Nexus
KODI_PVR_WAIPU_SITE = $(call github,flubshi,pvr.waipu,$(KODI_PVR_WAIPU_VERSION))
KODI_PVR_WAIPU_LICENSE = GPL-2.0+
KODI_PVR_WAIPU_LICENSE_FILES = pvr.waipu/LICENSE.txt
KODI_PVR_WAIPU_DEPENDENCIES = kodi rapidjson

$(eval $(cmake-package))

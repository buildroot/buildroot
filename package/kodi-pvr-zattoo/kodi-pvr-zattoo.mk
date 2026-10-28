################################################################################
#
# kodi-pvr-zattoo
#
################################################################################

KODI_PVR_ZATTOO_VERSION = 22.2.3-Piers
KODI_PVR_ZATTOO_SITE = $(call github,rbuehlma,pvr.zattoo,$(KODI_PVR_ZATTOO_VERSION))
KODI_PVR_ZATTOO_LICENSE = GPL-2.0+
KODI_PVR_ZATTOO_LICENSE_FILES = LICENSE.md
KODI_PVR_ZATTOO_DEPENDENCIES = json-for-modern-cpp kodi tinyxml2

$(eval $(cmake-package))

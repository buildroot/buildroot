################################################################################
#
# kodi-pvr-octonet
#
################################################################################

KODI_PVR_OCTONET_VERSION = 21.0.1-Omega
KODI_PVR_OCTONET_SITE = $(call github,DigitalDevices,pvr.octonet,$(KODI_PVR_OCTONET_VERSION))
KODI_PVR_OCTONET_LICENSE = GPL-2.0+
KODI_PVR_OCTONET_LICENSE_FILES = LICENSE.md
KODI_PVR_OCTONET_DEPENDENCIES = jsoncpp kodi

$(eval $(cmake-package))

################################################################################
#
# kodi-visualisation-fishbmc
#
################################################################################

KODI_VISUALISATION_FISHBMC_VERSION = 19.0.0-Matrix
KODI_VISUALISATION_FISHBMC_SITE = $(call github,xbmc,visualization.fishbmc,$(KODI_VISUALISATION_FISHBMC_VERSION))
KODI_VISUALISATION_FISHBMC_LICENSE = GPL-2.0+
KODI_VISUALISATION_FISHBMC_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_FISHBMC_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

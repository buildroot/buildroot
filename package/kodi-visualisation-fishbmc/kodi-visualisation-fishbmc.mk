################################################################################
#
# kodi-visualisation-fishbmc
#
################################################################################

KODI_VISUALISATION_FISHBMC_VERSION = daa4e6b3e952075b813768e3518ac6e6b0724f55
KODI_VISUALISATION_FISHBMC_SITE = $(call github,xbmc,visualization.fishbmc,$(KODI_VISUALISATION_FISHBMC_VERSION))
KODI_VISUALISATION_FISHBMC_LICENSE = GPL-2.0+
KODI_VISUALISATION_FISHBMC_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_FISHBMC_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

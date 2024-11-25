################################################################################
#
# kodi-visualisation-starburst
#
################################################################################

KODI_VISUALISATION_STARBURST_VERSION = 7923772cd986849531bdfee0a0bc989842b41996
KODI_VISUALISATION_STARBURST_SITE = $(call github,xbmc,visualization.starburst,$(KODI_VISUALISATION_STARBURST_VERSION))
KODI_VISUALISATION_STARBURST_LICENSE = GPL-2.0+
KODI_VISUALISATION_STARBURST_LICENSE_FILES = LICENSE.md
KODI_VISUALISATION_STARBURST_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

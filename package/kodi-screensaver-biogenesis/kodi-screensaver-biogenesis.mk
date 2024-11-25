################################################################################
#
# kodi-screensaver-biogenesis
#
################################################################################

KODI_SCREENSAVER_BIOGENESIS_VERSION = 953947d07fdf69967e2dc64b289631c57c79e800
KODI_SCREENSAVER_BIOGENESIS_SITE = $(call github,xbmc,screensaver.biogenesis,$(KODI_SCREENSAVER_BIOGENESIS_VERSION))
KODI_SCREENSAVER_BIOGENESIS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_BIOGENESIS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_BIOGENESIS_DEPENDENCIES = kodi

$(eval $(cmake-package))

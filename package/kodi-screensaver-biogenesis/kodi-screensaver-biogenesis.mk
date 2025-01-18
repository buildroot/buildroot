################################################################################
#
# kodi-screensaver-biogenesis
#
################################################################################

KODI_SCREENSAVER_BIOGENESIS_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_BIOGENESIS_SITE = $(call github,xbmc,screensaver.biogenesis,$(KODI_SCREENSAVER_BIOGENESIS_VERSION))
KODI_SCREENSAVER_BIOGENESIS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_BIOGENESIS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_BIOGENESIS_DEPENDENCIES = kodi

$(eval $(cmake-package))

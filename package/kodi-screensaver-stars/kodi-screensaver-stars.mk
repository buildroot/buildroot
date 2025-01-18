################################################################################
#
# kodi-screensaver-stars
#
################################################################################

KODI_SCREENSAVER_STARS_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_STARS_SITE = $(call github,xbmc,screensaver.stars,$(KODI_SCREENSAVER_STARS_VERSION))
KODI_SCREENSAVER_STARS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_STARS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_STARS_DEPENDENCIES = kodi

$(eval $(cmake-package))

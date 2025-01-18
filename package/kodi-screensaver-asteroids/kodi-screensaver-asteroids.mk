################################################################################
#
# kodi-screensaver-asteroids
#
################################################################################

KODI_SCREENSAVER_ASTEROIDS_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_ASTEROIDS_SITE = $(call github,xbmc,screensaver.asteroids,$(KODI_SCREENSAVER_ASTEROIDS_VERSION))
KODI_SCREENSAVER_ASTEROIDS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_ASTEROIDS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_ASTEROIDS_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

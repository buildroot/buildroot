################################################################################
#
# kodi-screensaver-pingpong
#
################################################################################

KODI_SCREENSAVER_PINGPONG_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_PINGPONG_SITE = $(call github,xbmc,screensaver.pingpong,$(KODI_SCREENSAVER_PINGPONG_VERSION))
KODI_SCREENSAVER_PINGPONG_LICENSE = GPL-2.0+
KODI_SCREENSAVER_PINGPONG_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_PINGPONG_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

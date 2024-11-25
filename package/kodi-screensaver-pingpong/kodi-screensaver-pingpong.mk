################################################################################
#
# kodi-screensaver-pingpong
#
################################################################################

KODI_SCREENSAVER_PINGPONG_VERSION = a0b8b956002ddc64eb6d433e3230fa09619f2aef
KODI_SCREENSAVER_PINGPONG_SITE = $(call github,xbmc,screensaver.pingpong,$(KODI_SCREENSAVER_PINGPONG_VERSION))
KODI_SCREENSAVER_PINGPONG_LICENSE = GPL-2.0+
KODI_SCREENSAVER_PINGPONG_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_PINGPONG_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

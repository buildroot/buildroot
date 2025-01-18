################################################################################
#
# kodi-screensaver-greynetic
#
################################################################################

KODI_SCREENSAVER_GREYNETIC_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_GREYNETIC_SITE = $(call github,xbmc,screensaver.greynetic,$(KODI_SCREENSAVER_GREYNETIC_VERSION))
KODI_SCREENSAVER_GREYNETIC_LICENSE = GPL-2.0+
KODI_SCREENSAVER_GREYNETIC_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_GREYNETIC_DEPENDENCIES = glm kodi

$(eval $(cmake-package))

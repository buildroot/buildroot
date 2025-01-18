################################################################################
#
# kodi-screensaver-pyro
#
################################################################################

KODI_SCREENSAVER_PYRO_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_PYRO_SITE = $(call github,xbmc,screensaver.pyro,$(KODI_SCREENSAVER_PYRO_VERSION))
KODI_SCREENSAVER_PYRO_LICENSE = GPL-2.0+
KODI_SCREENSAVER_PYRO_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_PYRO_DEPENDENCIES = kodi

$(eval $(cmake-package))

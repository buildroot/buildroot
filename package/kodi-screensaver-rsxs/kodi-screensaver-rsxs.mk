################################################################################
#
# kodi-screensaver-rsxs
#
################################################################################

KODI_SCREENSAVER_RSXS_VERSION = 22.0.7-Piers
KODI_SCREENSAVER_RSXS_SITE = $(call github,xbmc,screensavers.rsxs,$(KODI_SCREENSAVER_RSXS_VERSION))
KODI_SCREENSAVER_RSXS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_RSXS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_RSXS_DEPENDENCIES = bzip2 kodi

$(eval $(cmake-package))

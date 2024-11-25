################################################################################
#
# kodi-screensaver-rsxs
#
################################################################################

KODI_SCREENSAVER_RSXS_VERSION = 56bc68ef28a8d2a8cf345472df6105bc4c111a04
KODI_SCREENSAVER_RSXS_SITE = $(call github,xbmc,screensavers.rsxs,$(KODI_SCREENSAVER_RSXS_VERSION))
KODI_SCREENSAVER_RSXS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_RSXS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_RSXS_DEPENDENCIES = bzip2 gli glm kodi

$(eval $(cmake-package))

################################################################################
#
# kodi-screensaver-matrixtrails
#
################################################################################

KODI_SCREENSAVER_MATRIXTRAILS_VERSION = 21.0.2-Omega
KODI_SCREENSAVER_MATRIXTRAILS_SITE = $(call github,xbmc,screensaver.matrixtrails,$(KODI_SCREENSAVER_MATRIXTRAILS_VERSION))
KODI_SCREENSAVER_MATRIXTRAILS_LICENSE = GPL-2.0+
KODI_SCREENSAVER_MATRIXTRAILS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_MATRIXTRAILS_DEPENDENCIES = kodi

KODI_SCREENSAVER_MATRIXTRAILS_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags egl`" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags egl`"

$(eval $(cmake-package))

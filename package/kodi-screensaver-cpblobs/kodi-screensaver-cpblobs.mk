################################################################################
#
# kodi-screensaver-cpblobs
#
################################################################################

KODI_SCREENSAVER_CPBLOBS_VERSION = 19.0.0-Matrix
KODI_SCREENSAVER_CPBLOBS_SITE = $(call github,xbmc,screensaver.cpblobs,$(KODI_SCREENSAVER_CPBLOBS_VERSION))
KODI_SCREENSAVER_CPBLOBS_LICENSE = GPL-2.0
KODI_SCREENSAVER_CPBLOBS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_CPBLOBS_DEPENDENCIES = glm kodi

KODI_SCREENSAVER_CPBLOBS_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) $(shell $(PKG_CONFIG_HOST_BINARY) --cflags egl)" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) $(shell $(PKG_CONFIG_HOST_BINARY) --cflags egl)"

$(eval $(cmake-package))

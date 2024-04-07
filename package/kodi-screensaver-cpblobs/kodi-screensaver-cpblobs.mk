################################################################################
#
# kodi-screensaver-cpblobs
#
################################################################################

KODI_SCREENSAVER_CPBLOBS_VERSION = cd96c71c22940014d5c79c58af99b60e0b418f71
KODI_SCREENSAVER_CPBLOBS_SITE = $(call github,xbmc,screensaver.cpblobs,$(KODI_SCREENSAVER_CPBLOBS_VERSION))
KODI_SCREENSAVER_CPBLOBS_LICENSE = GPL-2.0
KODI_SCREENSAVER_CPBLOBS_LICENSE_FILES = LICENSE.md
KODI_SCREENSAVER_CPBLOBS_DEPENDENCIES = glm kodi

KODI_SCREENSAVER_CPBLOBS_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags egl`" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) `$(PKG_CONFIG_HOST_BINARY) --cflags egl`"

$(eval $(cmake-package))

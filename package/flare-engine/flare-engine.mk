################################################################################
#
# flare-engine
#
################################################################################

FLARE_ENGINE_VERSION = 1.12
FLARE_ENGINE_SITE = $(call github,flareteam,flare-engine,v$(FLARE_ENGINE_VERSION))
FLARE_ENGINE_LICENSE = GPL-3.0+
FLARE_ENGINE_LICENSE_FILES = COPYING

FLARE_ENGINE_DEPENDENCIES += sdl2 sdl2_image sdl2_mixer sdl2_ttf tremor

# Don't use /usr/games and /usr/share/games
FLARE_ENGINE_CONF_OPTS += -DBINDIR=bin -DDATADIR=share/flare

# CMAKE_BUILD_TYPE is only used to set optimization and debug flags, all of
# which we want Buildroot to steer explicitly. Explicitly set a fake build type
# to get this control.
FLARE_ENGINE_CONF_OPTS += -DCMAKE_BUILD_TYPE=Buildroot

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
FLARE_ENGINE_CONF_OPTS += -DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -O0"
endif

$(eval $(cmake-package))

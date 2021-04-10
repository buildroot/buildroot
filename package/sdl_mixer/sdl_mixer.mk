################################################################################
#
# sdl_mixer
#
################################################################################

# The latest officially released version of SDL_mixer is 1.2.12, released in 2012.
# Since then, there have been many bugfixes on master.
#
# This commit points to the SDL-1.2 branch from 15 Mar 2021.
SDL_MIXER_VERSION = d1725fcb7c4e987aeb7ecdc94cb8b6375b702170
SDL_MIXER_SITE = $(call github,libsdl-org,SDL_mixer,$(SDL_MIXER_VERSION))
SDL_MIXER_LICENSE = Zlib
SDL_MIXER_LICENSE_FILES = COPYING

# Package does not build in parallel due to improper make rules
SDL_MIXER_MAKE = $(MAKE1)

SDL_MIXER_INSTALL_STAGING = YES
SDL_MIXER_DEPENDENCIES = sdl

# We're patching configure.in, so we need to autoreconf
SDL_MIXER_AUTORECONF = YES

SDL_MIXER_CONF_OPTS = \
	--with-sdl-prefix=$(STAGING_DIR)/usr \
	--disable-music-mod \
	--disable-music-mp3 \
	--disable-music-flac # configure script fails when cross compiling

ifeq ($(BR2_PACKAGE_FLUIDSYNTH),y)
SDL_MIXER_DEPENDENCIES += fluidsynth
SDL_MIXER_CONF_OPTS += \
	--enable-music-midi \
	--enable-music-fluidsynth-midi
SDL_MIXER_HAS_MIDI = YES
endif

ifeq ($(BR2_PACKAGE_SDL_MIXER_MIDI_TIMIDITY),y)
SDL_MIXER_CONF_OPTS += \
	--enable-music-midi \
	--enable-music-timidity-midi
SDL_MIXER_HAS_MIDI = YES
endif

ifneq ($(SDL_MIXER_HAS_MIDI),YES)
SDL_MIXER_CONF_OPTS += --disable-music-midi
endif

ifeq ($(BR2_PACKAGE_LIBMAD),y)
SDL_MIXER_CONF_OPTS += --enable-music-mp3-mad-gpl
SDL_MIXER_DEPENDENCIES += libmad
else
SDL_MIXER_CONF_OPTS += --disable-music-mp3-mad-gpl
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
SDL_MIXER_CONF_OPTS += --enable-music-mod-modplug
SDL_MIXER_DEPENDENCIES += host-pkgconf libmodplug
else
SDL_MIXER_CONF_OPTS += --disable-music-mod-modplug
endif

ifeq ($(BR2_PACKAGE_TREMOR),y)
SDL_MIXER_CONF_OPTS += --enable-music-ogg-tremor
SDL_MIXER_DEPENDENCIES += tremor
else ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
SDL_MIXER_CONF_OPTS += --enable-music-ogg
SDL_MIXER_DEPENDENCIES += libvorbis
else
SDL_MIXER_CONF_OPTS += --disable-music-ogg
endif

$(eval $(autotools-package))

################################################################################
#
# libopenmpt
#
################################################################################

LIBOPENMPT_VERSION = 0.7.13
LIBOPENMPT_SITE = https://lib.openmpt.org/files/libopenmpt/src
LIBOPENMPT_SOURCE = libopenmpt-$(LIBOPENMPT_VERSION)+release.autotools.tar.gz
LIBOPENMPT_LICENSE = BSD-3-Clause
LIBOPENMPT_LICENSE_FILES = LICENSE
LIBOPENMPT_CPE_ID_VENDOR = openmpt
LIBOPENMPT_DEPENDENCIES = host-pkgconf
LIBOPENMPT_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_LIBOPENMPT_OPENMPT123),y)
LIBOPENMPT_CONF_OPTS += --enable-openmpt123
else
LIBOPENMPT_CONF_OPTS += --disable-openmpt123
endif

ifeq ($(BR2_PACKAGE_FLAC),y)
LIBOPENMPT_CONF_OPTS += --with-flac
LIBOPENMPT_DEPENDENCIES += flac
else
LIBOPENMPT_CONF_OPTS += --without-flac
endif

ifeq ($(BR2_PACKAGE_LIBOGG),y)
LIBOPENMPT_CONF_OPTS += --with-ogg
LIBOPENMPT_DEPENDENCIES += libogg
else
LIBOPENMPT_CONF_OPTS += --without-ogg
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
LIBOPENMPT_CONF_OPTS += --with-sndfile
LIBOPENMPT_DEPENDENCIES += libsndfile
else
LIBOPENMPT_CONF_OPTS += --without-sndfile
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
LIBOPENMPT_CONF_OPTS += --with-vorbis --with-vorbisfile
LIBOPENMPT_DEPENDENCIES += libvorbis
else
LIBOPENMPT_CONF_OPTS += --without-vorbis --without-vorbisfile
endif

ifeq ($(BR2_PACKAGE_MPG123),y)
LIBOPENMPT_CONF_OPTS += --with-mpg123
LIBOPENMPT_DEPENDENCIES += mpg123
else
LIBOPENMPT_CONF_OPTS += --without-mpg123
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO),y)
LIBOPENMPT_CONF_OPTS += --with-portaudio
LIBOPENMPT_DEPENDENCIES += portaudio
else
LIBOPENMPT_CONF_OPTS += --without-portaudio
endif

ifeq ($(BR2_PACKAGE_PORTAUDIO_CXX),y)
LIBOPENMPT_CONF_OPTS += --with-portaudiocpp
# No need to add portaudio dependency, because this config already
# depends on BR2_PACKAGE_PORTAUDIO. So the dependency has already been
# added in the previous block.
else
LIBOPENMPT_CONF_OPTS += --without-portaudiocpp
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
LIBOPENMPT_CONF_OPTS += --with-pulseaudio
LIBOPENMPT_DEPENDENCIES += pulseaudio
else
LIBOPENMPT_CONF_OPTS += --without-pulseaudio
endif

ifeq ($(BR2_PACKAGE_SDL2),y)
LIBOPENMPT_CONF_OPTS += --with-sdl2
LIBOPENMPT_DEPENDENCIES += sdl2
else
LIBOPENMPT_CONF_OPTS += --without-sdl2
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBOPENMPT_CONF_OPTS += --with-zlib
LIBOPENMPT_DEPENDENCIES += zlib
else
LIBOPENMPT_CONF_OPTS += --without-zlib
endif

$(eval $(autotools-package))

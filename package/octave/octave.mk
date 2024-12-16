################################################################################
#
# octave
#
################################################################################

OCTAVE_VERSION = 9.3.0
OCTAVE_SITE = $(BR2_GNU_MIRROR)/octave
OCTAVE_SOURCE = octave-$(OCTAVE_VERSION).tar.lz
OCTAVE_LICENSE = GPL-3.0+
OCTAVE_LICENSE_FILES = COPYING
OCTAVE_AUTORECONF = YES

OCTAVE_CONF_OPTS = --disable-java

OCTAVE_DEPENDENCIES = \
	host-gperf \
	host-pkgconf \
	openblas \
	pcre2

ifeq ($(BR2_PACKAGE_BZIP2),y)
OCTAVE_CONF_OPTS += --with-bz2
OCTAVE_DEPENDENCIES += bzip2
else
OCTAVE_CONF_OPTS += --without-bz2
endif

ifeq ($(BR2_PACKAGE_GRAPHICSMAGICK),y)
OCTAVE_CONF_OPTS += --with-magick=GraphicsMagick++
OCTAVE_DEPENDENCIES += graphicsmagick
else ifeq ($(BR2_PACKAGE_IMAGEMAGICK),y)
OCTAVE_CONF_OPTS += --with-magick=ImageMagick++
OCTAVE_DEPENDENCIES += imagemagick
else
OCTAVE_CONF_OPTS += --without-magick
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
OCTAVE_CONF_OPTS += --with-curl
OCTAVE_DEPENDENCIES += libcurl
else
OCTAVE_CONF_OPTS += --without-curl
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
OCTAVE_CONF_OPTS += --with-sndfile
OCTAVE_DEPENDENCIES += libsndfile
else
OCTAVE_CONF_OPTS += --without-sndfile
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
OCTAVE_CONF_OPTS += --with-openssl=yes
OCTAVE_DEPENDENCIES += openssl
else
OCTAVE_CONF_OPTS += --without-openssl
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
OCTAVE_CONF_OPTS += \
	--enable-readline \
	--with-libreadline-prefix=$(STAGING_DIR)/usr
OCTAVE_DEPENDENCIES += readline
else
OCTAVE_CONF_OPTS += --disable-readline
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
OCTAVE_CONF_OPTS += --with-z
OCTAVE_DEPENDENCIES += zlib
else
OCTAVE_CONF_OPTS += --without-z
endif

$(eval $(autotools-package))

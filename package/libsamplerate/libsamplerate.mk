################################################################################
#
# libsamplerate
#
################################################################################

LIBSAMPLERATE_VERSION = 0.2.2
LIBSAMPLERATE_SOURCE = libsamplerate-$(LIBSAMPLERATE_VERSION).tar.xz
LIBSAMPLERATE_SITE = https://github.com/libsndfile/libsamplerate/releases/download/$(LIBSAMPLERATE_VERSION)
LIBSAMPLERATE_INSTALL_STAGING = YES
LIBSAMPLERATE_DEPENDENCIES = host-pkgconf
# sndfile is only used for examples and tests so it doesn't make sense
# to support it as an optional dependency
LIBSAMPLERATE_CONF_OPTS = \
	--disable-fftw \
	--disable-sndfile \
	--program-transform-name=''
LIBSAMPLERATE_LICENSE = BSD-2-Clause
LIBSAMPLERATE_LICENSE_FILES = COPYING
LIBSAMPLERATE_CPE_ID_VALID = YES

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBSAMPLERATE_DEPENDENCIES += alsa-lib
LIBSAMPLERATE_CONF_OPTS += --enable-alsa
else
LIBSAMPLERATE_CONF_OPTS += --disable-alsa
endif

$(eval $(autotools-package))

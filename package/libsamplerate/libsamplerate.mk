################################################################################
#
# libsamplerate
#
################################################################################

LIBSAMPLERATE_VERSION = 0.1.9
LIBSAMPLERATE_SITE = http://www.mega-nerd.com/SRC
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
LIBSAMPLERATE_CPE_ID_VENDOR = libsamplerate_project

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBSAMPLERATE_DEPENDENCIES += alsa-lib
LIBSAMPLERATE_CONF_OPTS += --enable-alsa
else
LIBSAMPLERATE_CONF_OPTS += --disable-alsa
endif

$(eval $(autotools-package))

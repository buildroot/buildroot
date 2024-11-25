################################################################################
#
# GTKIOSTREAM
#
################################################################################

GTKIOSTREAM_VERSION = 1.8.0
GTKIOSTREAM_SITE = $(call github,flatmax,gtkiostream,v$(GTKIOSTREAM_VERSION))
GTKIOSTREAM_LICENSE = GPL-2.0+
GTKIOSTREAM_LICENSE_FILES = gpl.txt

# configure script not available
GTKIOSTREAM_AUTORECONF = YES

GTKIOSTREAM_DEPENDENCIES = \
	eigen \
	fftw-double \
	fftw-single \
	host-pkgconf

GTKIOSTREAM_CONF_OPTS = \
	--disable-octave \
	--disable-tests \
	$(if $(BR2_TOOLCHAIN_HAS_OPENMP),--disable,--enable)-openmp

# For the optional packages below, there's unfortunately no
# ./configure option to explicitly enable/disable them. They are
# checked by the ./configure script using pkg-config.

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
GTKIOSTREAM_DEPENDENCIES += alsa-lib
endif

ifeq ($(BR2_PACKAGE_JACK2),y)
GTKIOSTREAM_DEPENDENCIES += jack2
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
GTKIOSTREAM_DEPENDENCIES += libglib2
endif

ifeq ($(BR2_PACKAGE_LIBGTK2),y)
GTKIOSTREAM_DEPENDENCIES += libgtk2
endif

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
GTKIOSTREAM_DEPENDENCIES += libgtk3
endif

ifeq ($(BR2_PACKAGE_LIBWEBSOCKETS),y)
GTKIOSTREAM_DEPENDENCIES += libwebsockets
endif

ifeq ($(BR2_PACKAGE_OPENCV3),y)
GTKIOSTREAM_DEPENDENCIES += opencv3
endif

ifeq ($(BR2_PACKAGE_SOX),y)
GTKIOSTREAM_DEPENDENCIES += sox
endif

$(eval $(autotools-package))

################################################################################
#
# libnice
#
################################################################################

LIBNICE_VERSION = 0.1.13
LIBNICE_SITE = http://nice.freedesktop.org/releases
LIBNICE_LICENSE = MPLv1.1 or LGPLv2.1
LIBNICE_LICENSE_FILES = COPYING COPYING.MPL COPYING.LGPL
LIBNICE_DEPENDENCIES = libglib2 host-pkgconf
LIBNICE_INSTALL_STAGING = YES
# For 0001-configure-Fix-configure-failure-when-building-without-.patch
LIBNICE_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_GSTREAMER1),)
LIBNICE_CONF_OPTS += --without-gstreamer
else
LIBNICE_DEPENDENCIES += gstreamer1 gst1-plugins-base
endif

ifeq ($(BR2_PACKAGE_GSTREAMER),)
LIBNICE_CONF_OPTS += --without-gstreamer-0.10
else
LIBNICE_DEPENDENCIES += gstreamer gst-plugins-base
endif

$(eval $(autotools-package))

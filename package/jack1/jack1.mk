################################################################################
#
# jack1
#
################################################################################

JACK1_VERSION = 0.126.0
JACK1_SITE = \
	https://github.com/jackaudio/jack1/releases/download/$(JACK1_VERSION)
JACK1_LICENSE = GPL-2.0+ (jack server), LGPL-2.1+ (jack library)
JACK1_LICENSE_FILES = COPYING COPYING.GPL COPYING.LGPL
JACK1_INSTALL_STAGING = YES

JACK1_DEPENDENCIES = host-pkgconf alsa-lib berkeleydb

ifeq ($(BR2_PACKAGE_LIBSAMPLERATE),y)
JACK1_DEPENDENCIES += libsamplerate
endif

JACK1_CONF_OPTS = --without-html-dir --disable-oss

$(eval $(autotools-package))

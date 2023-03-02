################################################################################
#
# gensio
#
################################################################################

GENSIO_VERSION = 2.5.5
GENSIO_SITE = http://downloads.sourceforge.net/project/ser2net/ser2net
GENSIO_LICENSE = LGPL-2.1+ (library), GPL-2.0+ (tools)
GENSIO_LICENSE_FILES = COPYING.LIB COPYING
GENSIO_INSTALL_STAGING = YES
GENSIO_CONF_OPTS = \
	--without-swig \
	--without-python

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
GENSIO_CONF_OPTS += --with-cplusplus
else
GENSIO_CONF_OPTS += --without-cplusplus
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB_PCM),y)
GENSIO_DEPENDENCIES += alsa-lib
GENSIO_CONF_OPTS += --with-alsa
else
GENSIO_CONF_OPTS += --without-alsa
endif

ifeq ($(BR2_PACKAGE_AVAHI_LIBAVAHI_CLIENT),y)
GENSIO_DEPENDENCIES += avahi
GENSIO_CONF_OPTS += --with-mdns
else
GENSIO_CONF_OPTS += --without-mdns
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
GENSIO_DEPENDENCIES += host-pkgconf libglib2
GENSIO_CONF_OPTS += --with-glib
else
GENSIO_CONF_OPTS += --without-glib
endif

ifeq ($(BR2_PACKAGE_OPENIPMI),y)
GENSIO_DEPENDENCIES += openipmi
GENSIO_CONF_OPTS += --with-openipmi
else
GENSIO_CONF_OPTS += --without-openipmi
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
GENSIO_DEPENDENCIES += host-pkgconf openssl
GENSIO_CONF_OPTS += --with-openssl
else
GENSIO_CONF_OPTS += --without-openssl
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
GENSIO_CONF_ENV += LIBS=-latomic
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
GENSIO_CONF_OPTS += --with-pthreads
else
GENSIO_CONF_OPTS += --without-pthreads
endif

$(eval $(autotools-package))

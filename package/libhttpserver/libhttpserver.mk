################################################################################
#
# libhttpserver
#
################################################################################

LIBHTTPSERVER_VERSION = 2.0.0
LIBHTTPSERVER_SITE = $(call github,etr,libhttpserver,$(LIBHTTPSERVER_VERSION))
LIBHTTPSERVER_LICENSE = LGPL-2.1+
LIBHTTPSERVER_LICENSE_FILES = COPYING.LESSER
LIBHTTPSERVER_INSTALL_STAGING = YES
LIBHTTPSERVER_CONF_OPTS = \
	--disable-examples \
	--enable-same-directory-build
LIBHTTPSERVER_AUTORECONF = YES
LIBHTTPSERVER_DEPENDENCIES = libmicrohttpd

ifeq ($(BR2_PACKAGE_LIBMICROHTTPD_SSL),y)
LIBHTTPSERVER_DEPENDENCIES += gnutls
else
LIBHTTPSERVER_CONF_ENV += ac_cv_header_gnutls_gnutls_h=no
endif

$(eval $(autotools-package))

################################################################################
#
# librelp
#
################################################################################

LIBRELP_VERSION = 1.2.18
LIBRELP_SITE = http://download.rsyslog.com/librelp
LIBRELP_LICENSE = GPL-3.0+
LIBRELP_LICENSE_FILES = COPYING
LIBRELP_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_GNUTLS),y)
LIBRELP_DEPENDENCIES += gnutls host-pkgconf
LIBRELP_CONF_OPTS += --enable-tls
else
LIBRELP_CONF_OPTS += --disable-tls
endif

$(eval $(autotools-package))

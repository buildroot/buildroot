################################################################################
#
# freeradius-client
#
################################################################################

FREERADIUS_CLIENT_VERSION = 1.1.7
FREERADIUS_CLIENT_SITE = https://freeradius.org/ftp/pub/freeradius
FREERADIUS_CLIENT_LICENSE = BSD-2-Clause
FREERADIUS_CLIENT_LICENSE_FILES = COPYRIGHT
FREERADIUS_CLIENT_INSTALL_STAGING = YES

FREERADIUS_CLIENT_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
FREERADIUS_CLIENT_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_NETTLE),y)
FREERADIUS_CLIENT_DEPENDENCIES += nettle
FREERADIUS_CLIENT_CONF_OPTS += --with-nettle=yes
else
FREERADIUS_CLIENT_CONF_OPTS += --with-nettle=no
endif

$(eval $(autotools-package))

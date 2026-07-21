################################################################################
#
# libcppconnman
#
################################################################################

LIBCPPCONNMAN_VERSION = 2.0.0
LIBCPPCONNMAN_SITE = $(call github,amarula,libcppconnman,v$(LIBCPPCONNMAN_VERSION))
LIBCPPCONNMAN_LICENSE = LGPL-2.1-or-later
LIBCPPCONNMAN_LICENSE_FILES = LICENSE

LIBCPPCONNMAN_INSTALL_STAGING = YES

LIBCPPCONNMAN_DEPENDENCIES = host-pkgconf libglib2

LIBCPPCONNMAN_CONF_OPTS = -DBUILD_CONNMAN=ON

ifeq ($(BR2_PACKAGE_LIBCPPCONNMAN_EXAMPLE),y)
LIBCPPCONNMAN_DEPENDENCIES += readline
LIBCPPCONNMAN_CONF_OPTS += -DBUILD_EXAMPLES=ON
else
LIBCPPCONNMAN_CONF_OPTS += -DBUILD_EXAMPLES=OFF
endif

$(eval $(cmake-package))

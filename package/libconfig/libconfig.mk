################################################################################
#
# libconfig
#
################################################################################

LIBCONFIG_VERSION = 1.8.1
LIBCONFIG_SITE = https://hyperrealm.github.io/libconfig/dist
LIBCONFIG_LICENSE = LGPL-2.1+
LIBCONFIG_LICENSE_FILES = COPYING.LIB
LIBCONFIG_INSTALL_STAGING = YES
LIBCONFIG_CONF_OPTS = --disable-examples --disable-tests

ifneq ($(BR2_INSTALL_LIBSTDCPP),y)
LIBCONFIG_CONF_OPTS += --disable-cxx
endif

$(eval $(autotools-package))

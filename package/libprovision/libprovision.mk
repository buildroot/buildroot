################################################################################
#
# libprovision
#
################################################################################

ifeq ($(BR2_PACKAGE_CPPSDK),y)
LIBPROVISION_VERSION = b8d14e82101f9c5f7ef73d7d33927009298d0612
else
LIBPROVISION_VERSION = e532b8d1153f3b5880528bdd7a68318b9c75dac5
endif

LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_CPPSDK),y)
LIBPROVISION_DEPENDENCIES = openssl cppsdk
else
LIBPROVISION_DEPENDENCIES = openssl
endif

$(eval $(cmake-package))

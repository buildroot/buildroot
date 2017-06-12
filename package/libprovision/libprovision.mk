################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = b8d14e82101f9c5f7ef73d7d33927009298d0612
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

$(eval $(cmake-package))

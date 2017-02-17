################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = da6a16f5f11c086bf72871d8b5894202e0ce7747
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

$(eval $(cmake-package))

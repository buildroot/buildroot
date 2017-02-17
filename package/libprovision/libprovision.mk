################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = d221a087dcaade232b62faa6ca1e5ba04e48ca68
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

$(eval $(cmake-package))

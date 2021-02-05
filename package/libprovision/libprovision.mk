################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 10322dfe52ca4225289825dfdb4f78ae01345ed6
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = libopenssl

$(eval $(cmake-package))

################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 1f84847b6996128e1667999546244bedef1d2ac6
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = libopenssl

$(eval $(cmake-package))

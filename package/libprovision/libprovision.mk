################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = fa35f97fa0b7f8acd0f9fc8038495ea663c11fa4
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = libopenssl

$(eval $(cmake-package))

################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = f221973555f4ef1fc72c890751cbaa06bf806882
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl

$(eval $(cmake-package))

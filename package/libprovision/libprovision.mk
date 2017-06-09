################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 47ecb7154c43215a4f4e8096da9e182b3e884532
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

$(eval $(cmake-package))

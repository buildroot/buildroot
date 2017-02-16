################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 10f083ab3bd452ac9d82601d4f1ac0103cbad097
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

$(eval $(cmake-package))

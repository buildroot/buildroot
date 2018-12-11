################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 85b52b1ef4520af2ee0093948a104fd747f21aca
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl

$(eval $(cmake-package))

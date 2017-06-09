################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = b76f6b0c7c83a444c1a1d3f2625ba36723a87c8a
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl WPEFramework

$(eval $(cmake-package))

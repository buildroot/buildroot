################################################################################
#
# libqb
#
################################################################################

LIBQB_VERSION = 2.0.2
LIBQB_SITE = $(call github,ClusterLabs,libqb,v$(LIBQB_VERSION))
LIBQB_LICENSE = LGPL-2.1+
LIBQB_LICENSE_FILES = COPYING
LIBQB_CPE_ID_VENDOR = clusterlabs
LIBQB_INSTALL_STAGING = YES
LIBQB_AUTORECONF = YES
LIBQB_DEPENDENCIES = libxml2

$(eval $(autotools-package))

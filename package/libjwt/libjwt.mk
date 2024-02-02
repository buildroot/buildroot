################################################################################
#
# libjwt
#
################################################################################

LIBJWT_VERSION = 1.15.3
LIBJWT_SITE = $(call github,benmcollins,libjwt,v$(LIBJWT_VERSION))
LIBJWT_DEPENDENCIES = host-pkgconf jansson openssl
LIBJWT_AUTORECONF = YES
LIBJWT_INSTALL_STAGING = YES
LIBJWT_LICENSE = MPL-2.0
LIBJWT_LICENSE_FILES = LICENSE

$(eval $(autotools-package))

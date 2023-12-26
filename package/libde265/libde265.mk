################################################################################
#
# libde265
#
################################################################################

LIBDE265_VERSION = 1.0.15
LIBDE265_SITE = https://github.com/strukturag/libde265/releases/download/v$(LIBDE265_VERSION)
LIBDE265_LICENSE = LGPL-3.0+
LIBDE265_LICENSE_FILES = COPYING
LIBDE265_CPE_ID_VENDOR = struktur
LIBDE265_INSTALL_STAGING = YES

$(eval $(cmake-package))

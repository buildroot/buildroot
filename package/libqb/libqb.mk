################################################################################
#
# libqb
#
################################################################################

LIBQB_VERSION = 2.0.3
LIBQB_SOURCE = libqb-$(LIBQB_VERSION).tar.xz
LIBQB_SITE = \
	https://github.com/ClusterLabs/libqb/releases/download/v$(LIBQB_VERSION)
LIBQB_LICENSE = LGPL-2.1+
LIBQB_LICENSE_FILES = COPYING
LIBQB_CPE_ID_VENDOR = clusterlabs
LIBQB_INSTALL_STAGING = YES
LIBQB_DEPENDENCIES = libxml2

# ac_cv_prog_cc_c99 is required for BR2_USE_WCHAR=n because the C99 test
# provided by autoconf relies on wchar_t.
LIBQB_CONF_ENV = ac_cv_prog_cc_c99=-std=gnu99

$(eval $(autotools-package))

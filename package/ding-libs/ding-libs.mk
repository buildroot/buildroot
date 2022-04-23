################################################################################
#
# ding-libs
#
################################################################################

DING_LIBS_VERSION = 0.6.2
DING_LIBS_SITE = \
	https://github.com/SSSD/ding-libs/releases/download/$(DING_LIBS_VERSION)
DING_LIBS_DEPENDENCIES = host-pkgconf \
	$(TARGET_NLS_DEPENDENCIES) \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)
DING_LIBS_INSTALL_STAGING = YES
DING_LIBS_LICENSE = LGPL-3.0+ (library),GPL-3.0+ (test programs)
DING_LIBS_LICENSE_FILES = COPYING COPYING.LESSER

# autoconf/automake generated files not present in tarball
DING_LIBS_AUTORECONF = YES

$(eval $(autotools-package))

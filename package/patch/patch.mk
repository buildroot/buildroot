################################################################################
#
# patch
#
################################################################################

PATCH_VERSION = 2.8.1
PATCH_SOURCE = patch-$(PATCH_VERSION).tar.xz
PATCH_SITE = $(BR2_GNU_MIRROR)/patch
PATCH_LICENSE = GPL-3.0+
PATCH_LICENSE_FILES = COPYING
PATCH_CPE_ID_VENDOR = gnu

ifeq ($(BR2_PACKAGE_ATTR),y)
PATCH_CONF_OPTS += --enable-xattr
PATCH_DEPENDENCIES += attr
else
PATCH_CONF_OPTS += --disable-xattr
endif

$(eval $(autotools-package))

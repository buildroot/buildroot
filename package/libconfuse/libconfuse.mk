################################################################################
#
# libconfuse
#
################################################################################

LIBCONFUSE_VERSION = 3.3
LIBCONFUSE_SOURCE = confuse-$(LIBCONFUSE_VERSION).tar.xz
LIBCONFUSE_SITE = https://github.com/martinh/libconfuse/releases/download/v$(LIBCONFUSE_VERSION)
LIBCONFUSE_INSTALL_STAGING = YES
LIBCONFUSE_CONF_OPTS = --disable-rpath
LIBCONFUSE_LICENSE = ISC
LIBCONFUSE_LICENSE_FILES = LICENSE
LIBCONFUSE_CPE_ID_VALID = YES
LIBCONFUSE_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)

# 0001-Fix-163-unterminated-username-used-with-getpwnam.patch
LIBCONFUSE_IGNORE_CVES += CVE-2022-40320

$(eval $(autotools-package))
$(eval $(host-autotools-package))

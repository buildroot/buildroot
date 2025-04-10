################################################################################
#
# augeas
#
################################################################################

AUGEAS_VERSION = 1.14.1
AUGEAS_SITE = https://github.com/hercules-team/augeas/releases/download/release-$(AUGEAS_VERSION)
AUGEAS_INSTALL_STAGING = YES
AUGEAS_LICENSE = LGPL-2.1+
AUGEAS_LICENSE_FILES = COPYING
AUGEAS_CPE_ID_VENDOR = augeas
AUGEAS_DEPENDENCIES = host-pkgconf readline libxml2

AUGEAS_CONF_OPTS = --disable-gnulib-tests

# 0001-CVE-2025-2588-return-_REG_ENOSYS-if-no-specific-error-was-set-yet-parse_regexp-failed.patch
AUGEAS_IGNORE_CVES += CVE-2025-2588

# Remove the test lenses which occupy about 1.4 MB on the target
define AUGEAS_REMOVE_TEST_LENSES
	rm -rf $(TARGET_DIR)/usr/share/augeas/lenses/dist/tests
endef
AUGEAS_POST_INSTALL_TARGET_HOOKS += AUGEAS_REMOVE_TEST_LENSES

$(eval $(autotools-package))

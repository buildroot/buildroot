################################################################################
#
# oprofile
#
################################################################################

OPROFILE_VERSION = 1.4.0
OPROFILE_SITE = http://downloads.sourceforge.net/project/oprofile/oprofile/oprofile-$(OPROFILE_VERSION)
OPROFILE_LICENSE = GPL-2.0+
OPROFILE_LICENSE_FILES = COPYING
OPROFILE_CPE_ID_VENDOR = maynard_johnson
OPROFILE_CONF_OPTS = \
	--disable-account-check \
	--with-kernel=$(STAGING_DIR)/usr
# 0002-fix-static-build-with-binutils-2.40.patch
OPROFILE_AUTORECONF = YES

define OPROFILE_CREATE_MISSING_FILES
	touch $(@D)/NEWS $(@D)/AUTHORS $(@D)/ChangeLog
endef
OPROFILE_POST_EXTRACT_HOOKS += OPROFILE_CREATE_MISSING_FILES

OPROFILE_DEPENDENCIES = popt binutils host-pkgconf

ifeq ($(BR2_PACKAGE_LIBPFM4),y)
OPROFILE_DEPENDENCIES += libpfm4
endif

$(eval $(autotools-package))

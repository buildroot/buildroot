################################################################################
#
# libpam-nfc
#
################################################################################

LIBPAM_NFC_VERSION = 64a8b30ba2cfd634342ded8c096c7cfc5c8fa22a
LIBPAM_NFC_SITE = $(call github,nfc-tools,pam_nfc,$(LIBPAM_NFC_VERSION))
LIBPAM_NFC_LICENSE = GPL-2.0
LIBPAM_NFC_LICENSE_FILES = COPYING
LIBPAM_NFC_DEPENDENCIES = linux-pam libnfc
# Fetching from github, we need to generate the configure script
LIBPAM_NFC_AUTORECONF = YES
LIBPAM_NFC_INSTALL_STAGING = YES

LIBPAM_NFC_CONF_OPTS = \
	--with-pam-dir=/lib/security

# libpam breaks with parallel build, but is very fast to build.
LIBPAM_NFC_MAKE = $(MAKE1)

$(eval $(autotools-package))

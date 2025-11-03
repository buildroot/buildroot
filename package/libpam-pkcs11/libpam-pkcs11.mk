################################################################################
#
# libpam-pkcs11
#
################################################################################

LIBPAM_PKCS11_VERSION = 0.6.13
LIBPAM_PKCS11_SOURCE = pam_pkcs11-$(LIBPAM_PKCS11_VERSION).tar.gz
LIBPAM_PKCS11_SITE = https://github.com/OpenSC/pam_pkcs11/archive/refs/tags
LIBPAM_PKCS11_LICENSE = LGPL-2.1
LIBPAM_PKCS11_LICENSE_FILES = COPYING

LIBPAM_PKCS11_AUTORECONF = YES

LIBPAM_PKCS11_CONF_OPTS = \
	--libdir=/lib \
	--without-docbook \
	--without-ldap
LIBPAM_PKCS11_DEPENDENCIES = linux-pam openssl pcsc-lite

$(eval $(autotools-package))

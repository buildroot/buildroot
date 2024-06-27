################################################################################
#
# tpm2-openssl
#
################################################################################

TPM2_OPENSSL_VERSION = 1.2.0
TPM2_OPENSSL_SITE = https://github.com/tpm2-software/tpm2-openssl/releases/download/$(TPM2_OPENSSL_VERSION)
TPM2_OPENSSL_LICENSE = BSD-3-Clause
TPM2_OPENSSL_LICENSE_FILES = LICENSE
TPM2_OPENSSL_INSTALL_STAGING = YES
TPM2_OPENSSL_DEPENDENCIES = host-pkgconf openssl tpm2-tss

# Provide --with-modulesdir to avoid using abs_builddir and DESTDIR
# (also defined as absolute path) at the same time to define modules
# install path (am__installdirs).
TPM2_OPENSSL_CONF_OPTS = --with-modulesdir="/usr/lib/ossl-modules"

$(eval $(autotools-package))

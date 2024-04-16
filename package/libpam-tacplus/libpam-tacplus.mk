################################################################################
#
# libpam-tacplus
#
################################################################################

LIBPAM_TACPLUS_VERSION = 1.7.0
LIBPAM_TACPLUS_SOURCE = pam_tacplus-$(LIBPAM_TACPLUS_VERSION).tar.gz
LIBPAM_TACPLUS_SITE = https://github.com/kravietz/pam_tacplus/releases/download/v$(LIBPAM_TACPLUS_VERSION)
LIBPAM_TACPLUS_LICENSE = GPL-2.0+
LIBPAM_TACPLUS_LICENSE_FILES = COPYING
LIBPAM_TACPLUS_CPE_ID_VENDOR = pam_tacplus_project
LIBPAM_TACPLUS_CPE_ID_PRODUCT = pam_tacplus
LIBPAM_TACPLUS_DEPENDENCIES = \
	linux-pam \
	$(if $(BR2_PACKAGE_OPENSSL),openssl)
# We're patching Makefile.am
LIBPAM_TACPLUS_AUTORECONF = YES
LIBPAM_TACPLUS_INSTALL_STAGING = YES
LIBPAM_TACPLUS_CONF_OPTS = --disable-am-ldcflags --disable-werror

$(eval $(autotools-package))

################################################################################
#
# ecryptfs-utils
#
################################################################################

ECRYPTFS_UTILS_VERSION = 111
ECRYPTFS_UTILS_SOURCE = ecryptfs-utils_$(ECRYPTFS_UTILS_VERSION).orig.tar.gz
ECRYPTFS_UTILS_SITE = https://launchpad.net/ecryptfs/trunk/$(ECRYPTFS_UTILS_VERSION)/+download
ECRYPTFS_UTILS_LICENSE = GPL-2.0+
ECRYPTFS_UTILS_LICENSE_FILES = COPYING
ECRYPTFS_UTILS_CPE_ID_VENDOR = ecryptfs

ECRYPTFS_UTILS_DEPENDENCIES = host-pkgconf keyutils libnss host-intltool
ECRYPTFS_UTILS_CONF_OPTS = --disable-pywrap

ECRYPTFS_UTILS_CONF_ENV = ac_cv_path_POD2MAN=true

ifeq ($(BR2_PACKAGE_LIBGPGME),y)
ECRYPTFS_UTILS_CONF_OPTS += \
	--enable-gpg \
	--with-gpgme-prefix=$(STAGING_DIR)/usr
ECRYPTFS_UTILS_DEPENDENCIES += libgpgme
else
ECRYPTFS_UTILS_CONF_OPTS += --disable-gpg
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
ECRYPTFS_UTILS_CONF_OPTS += --enable-pam
ECRYPTFS_UTILS_DEPENDENCIES += linux-pam
else
ECRYPTFS_UTILS_CONF_OPTS += --disable-pam
endif

ifeq ($(BR2_PACKAGE_LIBRESSL)$(BR2_PACKAGE_LIBOPENSSL_ENGINES),y)
ECRYPTFS_UTILS_CONF_OPTS += --enable-openssl
ECRYPTFS_UTILS_DEPENDENCIES += openssl

ifeq ($(BR2_PACKAGE_PKCS11_HELPER),y)
ECRYPTFS_UTILS_CONF_OPTS += --enable-pkcs11-helper
ECRYPTFS_UTILS_DEPENDENCIES += pkcs11-helper
else
ECRYPTFS_UTILS_CONF_OPTS += --disable-pkcs11-helper
endif

else
ECRYPTFS_UTILS_CONF_OPTS += --disable-openssl
endif

$(eval $(autotools-package))

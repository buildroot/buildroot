################################################################################
#
# opkg
#
################################################################################

OPKG_VERSION = 0.7.0
OPKG_SITE = https://downloads.yoctoproject.org/releases/opkg
OPKG_DEPENDENCIES = host-pkgconf libarchive
OPKG_LICENSE = GPL-2.0+
OPKG_LICENSE_FILES = COPYING
OPKG_INSTALL_STAGING = YES
OPKG_CONF_OPTS = \
	--enable-sha256 \
	--without-acl \
	--without-xattr

ifeq ($(BR2_PACKAGE_OPKG_GPG_SIGN),y)
OPKG_CONF_OPTS += --enable-gpg
OPKG_CONF_ENV += \
	ac_cv_path_GPGME_CONFIG=$(STAGING_DIR)/usr/bin/gpgme-config \
	ac_cv_path_GPGERR_CONFIG=$(STAGING_DIR)/usr/bin/gpg-error-config
OPKG_DEPENDENCIES += libgpgme libgpg-error
else
OPKG_CONF_OPTS += --disable-gpg
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
OPKG_DEPENDENCIES += libcurl
OPKG_CONF_OPTS += --enable-curl
ifeq ($(BR2_PACKAGE_OPENSSL),y)
OPKG_CONF_OPTS += --enable-ssl-curl
else
OPKG_CONF_OPTS += --disable-ssl-curl
endif
else
OPKG_CONF_OPTS += --disable-curl --disable-ssl-curl
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
OPKG_DEPENDENCIES += bzip2
OPKG_CONF_OPTS += --enable-bzip2
else
OPKG_CONF_OPTS += --disable-bzip2
endif

ifeq ($(BR2_PACKAGE_LIBSOLV),y)
OPKG_DEPENDENCIES += libsolv
OPKG_CONF_OPTS += --with-libsolv
else
OPKG_CONF_OPTS += --without-libsolv
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
OPKG_DEPENDENCIES += lz4
OPKG_CONF_OPTS += --enable-lz4
else
OPKG_CONF_OPTS += --disable-lz4
endif

ifeq ($(BR2_PACKAGE_XZ),y)
OPKG_DEPENDENCIES += xz
OPKG_CONF_OPTS += --enable-xz
else
OPKG_CONF_OPTS += --disable-xz
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
OPKG_DEPENDENCIES += zstd
OPKG_CONF_OPTS += --enable-zstd
else
OPKG_CONF_OPTS += --disable-zstd
endif

# Ensure directory for lockfile exists
define OPKG_CREATE_LOCKDIR
	mkdir -p $(TARGET_DIR)/usr/lib/opkg
endef
OPKG_POST_INSTALL_TARGET_HOOKS += OPKG_CREATE_LOCKDIR

$(eval $(autotools-package))

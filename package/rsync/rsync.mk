################################################################################
#
# rsync
#
################################################################################

RSYNC_VERSION = 3.4.1
RSYNC_SITE = https://rsync.samba.org/ftp/rsync/src
RSYNC_LICENSE = GPL-3.0+ with exceptions
RSYNC_LICENSE_FILES = COPYING
RSYNC_CPE_ID_VENDOR = samba
RSYNC_SELINUX_MODULES = rsync
# We're patching configure.ac
RSYNC_AUTORECONF = YES
RSYNC_DEPENDENCIES = host-pkgconf zlib popt
# We know that our C library is modern enough for C99 vsnprintf(). Since
# configure can't detect this, we tell configure that vsnprintf() is safe.
RSYNC_CONF_ENV = rsync_cv_HAVE_C99_VSNPRINTF=yes
RSYNC_CONF_OPTS = \
	--with-included-zlib=no \
	--with-included-popt=no \
	--disable-roll-simd \
	--disable-md5-asm

# reconfigure must be run after autoreconf
define RSYNC_RUN_RECONFIGURE
	cd $(@D) && PATH=$(BR_PATH) make reconfigure
endef
RSYNC_POST_CONFIGURE_HOOKS += RSYNC_RUN_RECONFIGURE

ifeq ($(BR2_PACKAGE_ACL),y)
RSYNC_DEPENDENCIES += acl
else
RSYNC_CONF_OPTS += --disable-acl-support
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
RSYNC_DEPENDENCIES += lz4
RSYNC_CONF_OPTS += --enable-lz4
else
RSYNC_CONF_OPTS += --disable-lz4
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
RSYNC_DEPENDENCIES += openssl
RSYNC_CONF_OPTS += --enable-openssl
else
RSYNC_CONF_OPTS += --disable-openssl
endif

ifeq ($(BR2_PACKAGE_XXHASH),y)
RSYNC_DEPENDENCIES += xxhash
RSYNC_CONF_OPTS += --enable-xxhash
else
RSYNC_CONF_OPTS += --disable-xxhash
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
RSYNC_DEPENDENCIES += zstd
RSYNC_CONF_OPTS += --enable-zstd
else
RSYNC_CONF_OPTS += --disable-zstd
endif

$(eval $(autotools-package))

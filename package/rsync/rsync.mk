################################################################################
#
# rsync
#
################################################################################

RSYNC_VERSION = 3.2.7
RSYNC_SITE = https://rsync.samba.org/ftp/rsync/src
RSYNC_LICENSE = GPL-3.0+ with exceptions
RSYNC_LICENSE_FILES = COPYING
RSYNC_CPE_ID_VENDOR = samba
RSYNC_SELINUX_MODULES = rsync
RSYNC_DEPENDENCIES = zlib popt
RSYNC_CONF_OPTS = \
	--with-included-zlib=no \
	--with-included-popt=no \
	--disable-simd \
	--disable-openssl \
	--disable-xxhash \
	--disable-zstd \
	--disable-lz4 \
	--disable-asm

ifeq ($(BR2_PACKAGE_ACL),y)
RSYNC_DEPENDENCIES += acl
else
RSYNC_CONF_OPTS += --disable-acl-support
endif

$(eval $(autotools-package))

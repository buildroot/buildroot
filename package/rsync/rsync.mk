################################################################################
#
# rsync
#
################################################################################

RSYNC_VERSION = 3.2.3
RSYNC_SITE = http://rsync.samba.org/ftp/rsync/src
RSYNC_LICENSE = GPL-3.0+ with exceptions
RSYNC_LICENSE_FILES = COPYING
RSYNC_CPE_ID_VENDOR = samba
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

# 0001-rsync-ssl-Verify-the-hostname-in-the-certificate-when-using-openssl.patch
RSYNC_IGNORE_CVES += CVE-2020-14387

ifeq ($(BR2_PACKAGE_ACL),y)
RSYNC_DEPENDENCIES += acl
else
RSYNC_CONF_OPTS += --disable-acl-support
endif

$(eval $(autotools-package))

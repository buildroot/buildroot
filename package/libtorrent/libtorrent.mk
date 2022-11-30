################################################################################
#
# libtorrent
#
################################################################################

LIBTORRENT_VERSION = 0.13.8
LIBTORRENT_SITE = http://rtorrent.net/downloads
LIBTORRENT_DEPENDENCIES = host-pkgconf zlib
LIBTORRENT_CONF_OPTS = --enable-aligned \
	--disable-instrumentation \
	--with-zlib=$(STAGING_DIR)/usr
LIBTORRENT_INSTALL_STAGING = YES
LIBTORRENT_LICENSE = GPL-2.0
LIBTORRENT_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
LIBTORRENT_CONF_ENV += LDFLAGS="$(TARGET_LDFLAGS) -lexecinfo"
LIBTORRENT_DEPENDENCIES += libexecinfo
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LIBTORRENT_CONF_OPTS += --enable-openssl
LIBTORRENT_DEPENDENCIES += openssl
else
LIBTORRENT_CONF_OPTS += --disable-openssl
endif

$(eval $(autotools-package))

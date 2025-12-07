################################################################################
#
# kbd
#
################################################################################

KBD_VERSION = 2.9.0
KBD_SOURCE = kbd-$(KBD_VERSION).tar.xz
KBD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kbd
KBD_CONF_OPTS = \
	--disable-vlock \
	--disable-tests
KBD_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-pkgconf

ifeq ($(BR2_PACKAGE_BZIP2),y)
KBD_CONF_OPTS += --with-bzip2
KBD_DEPENDENCIES += bzip2
else
KBD_CONF_OPTS += --without-bzip2
endif

ifeq ($(BR2_PACKAGE_XZ),y)
KBD_CONF_OPTS += --with-lzma
KBD_DEPENDENCIES += xz
else
KBD_CONF_OPTS += --without-lzma
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
KBD_CONF_OPTS += --with-zlib
KBD_DEPENDENCIES += zlib
else
KBD_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
KBD_CONF_OPTS += --with-zstd
KBD_DEPENDENCIES += zstd
else
KBD_CONF_OPTS += --without-zstd
endif

KBD_LICENSE = GPL-2.0+
KBD_LICENSE_FILES = COPYING CREDITS

KBD_INSTALL_TARGET_OPTS = MKINSTALLDIRS=$(@D)/config/mkinstalldirs DESTDIR=$(TARGET_DIR) install

$(eval $(autotools-package))

################################################################################
#
# erofs-utils
#
################################################################################

EROFS_UTILS_VERSION = 1.8.5
EROFS_UTILS_SITE = https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/snapshot
EROFS_UTILS_LICENSE = GPL-2.0+, GPL-2.0+ or Apache-2.0 (liberofs)
EROFS_UTILS_LICENSE_FILES = COPYING LICENSES/Apache-2.0 LICENSES/GPL-2.0

# From a git tree: no generated autotools files
EROFS_UTILS_AUTORECONF = YES

EROFS_UTILS_DEPENDENCIES = host-pkgconf util-linux

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
EROFS_UTILS_CONF_ENV += LIBS=-latomic
endif

ifeq ($(BR2_PACKAGE_EROFS_UTILS_LZ4),y)
EROFS_UTILS_DEPENDENCIES += lz4
EROFS_UTILS_CONF_OPTS += --enable-lz4
else
EROFS_UTILS_CONF_OPTS += --disable-lz4
endif

ifeq ($(BR2_PACKAGE_EROFS_UTILS_LZMA),y)
EROFS_UTILS_DEPENDENCIES += xz
EROFS_UTILS_CONF_OPTS += --enable-lzma
else
EROFS_UTILS_CONF_OPTS += --disable-lzma
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
EROFS_UTILS_CONF_OPTS += --with-selinux
EROFS_UTILS_DEPENDENCIES += libselinux
else
EROFS_UTILS_CONF_OPTS += --without-selinux
endif

ifeq ($(BR2_PACKAGE_EROFS_UTILS_EROFSFUSE),y)
EROFS_UTILS_CONF_OPTS += --enable-fuse
EROFS_UTILS_DEPENDENCIES += libfuse
else
EROFS_UTILS_CONF_OPTS += --disable-fuse
endif

ifeq ($(BR2_PACKAGE_LIBDEFLATE),y)
EROFS_UTILS_DEPENDENCIES += libdeflate
EROFS_UTILS_CONF_OPTS += --with-libdeflate
else
EROFS_UTILS_CONF_OPTS += --without-libdeflate
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
EROFS_UTILS_DEPENDENCIES += zlib
EROFS_UTILS_CONF_OPTS += --with-zlib
else
EROFS_UTILS_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
EROFS_UTILS_DEPENDENCIES += zstd
EROFS_UTILS_CONF_OPTS += --with-libzstd
else
EROFS_UTILS_CONF_OPTS += --without-libzstd
endif

HOST_EROFS_UTILS_DEPENDENCIES = host-pkgconf host-util-linux host-lz4 host-xz
HOST_EROFS_UTILS_CONF_OPTS += \
	--enable-lz4 \
	--enable-lzma \
	--disable-fuse \
	--without-libdeflate \
	--without-libzstd \
	--without-selinux \
	--without-zlib

$(eval $(autotools-package))
$(eval $(host-autotools-package))

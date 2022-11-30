################################################################################
#
# btrfs-progs
#
################################################################################

BTRFS_PROGS_VERSION = 5.16.2
BTRFS_PROGS_SITE = $(BR2_KERNEL_MIRROR)/linux/kernel/people/kdave/btrfs-progs
BTRFS_PROGS_SOURCE = btrfs-progs-v$(BTRFS_PROGS_VERSION).tar.xz
BTRFS_PROGS_DEPENDENCIES = host-pkgconf lzo util-linux zlib
BTRFS_PROGS_CONF_OPTS = --disable-backtrace --disable-python
BTRFS_PROGS_LICENSE = GPL-2.0, LGPL-2.1+ (libbtrfsutil)
BTRFS_PROGS_LICENSE_FILES = COPYING libbtrfsutil/COPYING
BTRFS_PROGS_INSTALL_STAGING = YES

# Doesn't autodetect static-only and tries to build both
ifeq ($(BR2_STATIC_LIBS),y)
BTRFS_PROGS_MAKE_OPTS = static
BTRFS_PROGS_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) install-static
BTRFS_PROGS_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) install-static
endif

# convert also supports conversion from reiserfs, which needs some
# reiserfs libraries, but we have no package for them in Buildroot, so
# we keep things simple and only handle ext2.
ifeq ($(BR2_PACKAGE_E2FSPROGS),y)
BTRFS_PROGS_CONF_OPTS += --enable-convert --with-convert=ext2
BTRFS_PROGS_DEPENDENCIES += e2fsprogs
else
BTRFS_PROGS_CONF_OPTS += --disable-convert
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
BTRFS_PROGS_CONF_OPTS += --enable-zstd
BTRFS_PROGS_DEPENDENCIES += zstd
else
BTRFS_PROGS_CONF_OPTS += --disable-zstd
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
BTRFS_PROGS_CONF_OPTS += --enable-libudev
BTRFS_PROGS_DEPENDENCIES += udev
else
BTRFS_PROGS_CONF_OPTS += --disable-libudev
endif

ifeq ($(BR2_TOOLCHAIN_HEADERS_AT_LEAST_5_10),y)
BTRFS_PROGS_CONF_OPTS += --enable-zoned
else
BTRFS_PROGS_CONF_OPTS += --disable-zoned
endif

HOST_BTRFS_PROGS_DEPENDENCIES = host-util-linux host-lzo host-zlib
HOST_BTRFS_PROGS_CONF_OPTS = \
	--disable-backtrace \
	--disable-libudev \
	--disable-zoned \
	--disable-zstd \
	--disable-python \
	--disable-convert

$(eval $(autotools-package))
$(eval $(host-autotools-package))

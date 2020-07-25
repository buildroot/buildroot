################################################################################
#
# libblockdev
#
################################################################################

LIBBLOCKDEV_VERSION = 2.24
LIBBLOCKDEV_SITE = https://github.com/storaged-project/libblockdev/releases/download/$(LIBBLOCKDEV_VERSION)-1
LIBBLOCKDEV_LICENSE = LGPL-2.1
LIBBLOCKDEV_LICENSE_FILES = LICENSE
LIBBLOCKDEV_INSTALL_STAGING = YES
LIBBLOCKDEV_DEPENDENCIES = host-pkgconf libglib2 kmod udev
# 0001-Provide-replacement-function-for-strerror_l.patch
LIBBLOCKDEV_AUTORECONF = YES

LIBBLOCKDEV_CONF_OPTS = \
	--disable-introspection \
	--with-loop \
	--without-bcache \
	--without-btrfs \
	--without-crypto \
	--without-dm \
	--without-dmraid \
	--without-escrow \
	--without-fs \
	--without-kbd \
	--without-loop \
	--without-lvm \
	--without-lvm_dbus \
	--without-mdraid \
	--without-mpath \
	--without-nvdimm \
	--without-part \
	--without-python2 \
	--without-python3 \
	--without-s390 \
	--without-swap \
	--without-tools \
	--without-vdo

$(eval $(autotools-package))

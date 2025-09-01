################################################################################
#
# udisks
#
################################################################################

UDISKS_VERSION = 2.10.2
UDISKS_SOURCE = udisks-$(UDISKS_VERSION).tar.bz2
UDISKS_SITE = https://github.com/storaged-project/udisks/releases/download/udisks-$(UDISKS_VERSION)
UDISKS_LICENSE = GPL-2.0+
UDISKS_LICENSE_FILES = COPYING
UDISKS_CPE_ID_VENDOR = freedesktop
UDISKS_INSTALL_STAGING = YES

UDISKS_DEPENDENCIES = \
	host-pkgconf \
	dbus \
	dbus-glib \
	libatasmart \
	libblockdev \
	libgudev \
	parted \
	polkit \
	sg3_utils \
	udev \
	util-linux

UDISKS_CONF_OPTS = \
	--disable-acl \
	--disable-bcache \
	--disable-btrfs \
	--disable-introspection \
	--disable-iscsi \
	--disable-lsm \
	--disable-lvm2 \
	--disable-lvmcache \
	--disable-man \
	--disable-rpath \
	--disable-vdo \
	--disable-zram

ifeq ($(BR2_PACKAGE_UDISKS_FHS_MEDIA),y)
UDISKS_CONF_OPTS += --enable-fhs-media
else
UDISKS_CONF_OPTS += --disable-fhs-media
endif

$(eval $(autotools-package))

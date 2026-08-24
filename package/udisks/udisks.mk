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

# 0001-udiskslinuxfilesystem-Separate-real-caller-identity-.patch
# 0002-udiskslinuxfilesystem-Rework-fstab-mount-authorizati.patch
# 0003-udiskslinuxfilesystem-Log-real-caller-uid-for-as-use.patch
# 0004-udisksdaemonutil-Pass-as-user-target-to-polkit-detai.patch
# 0005-tests-Add-security-tests-for-as-user-mount-authoriza.patch
UDISKS_IGNORE_CVES += CVE-2026-7867

ifeq ($(BR2_PACKAGE_UDISKS_FHS_MEDIA),y)
UDISKS_CONF_OPTS += --enable-fhs-media
else
UDISKS_CONF_OPTS += --disable-fhs-media
endif

$(eval $(autotools-package))

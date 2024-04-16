################################################################################
#
# zfs
#
################################################################################

ZFS_VERSION = 2.2.2
ZFS_SITE = https://github.com/openzfs/zfs/releases/download/zfs-$(ZFS_VERSION)
ZFS_SELINUX_MODULES = zfs
ZFS_LICENSE = CDDL
ZFS_LICENSE_FILES = LICENSE COPYRIGHT
ZFS_CPE_ID_VENDOR = openzfs
ZFS_CPE_ID_PRODUCT = openzfs

# 0001-config-user-check-for-aio.h.patch
ZFS_AUTORECONF = YES

ZFS_DEPENDENCIES = libaio openssl udev util-linux zlib libcurl linux

# sysvinit installs only a commented-out modules-load.d/ config file
ZFS_CONF_OPTS = \
	--with-linux=$(LINUX_DIR) \
	--with-linux-obj=$(LINUX_DIR) \
	--disable-rpath \
	--disable-sysvinit

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
ZFS_DEPENDENCIES += libtirpc
ZFS_CONF_OPTS += --with-tirpc
else
ZFS_CONF_OPTS += --without-tirpc
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
# Installs the optional systemd generators, units, and presets files.
ZFS_CONF_OPTS += --enable-systemd
else
ZFS_CONF_OPTS += --disable-systemd
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
ZFS_DEPENDENCIES += python3 python-setuptools host-python-cffi host-python-packaging
ZFS_CONF_ENV += \
	PYTHON=$(HOST_DIR)/bin/python3 \
	PYTHON_CPPFLAGS="`$(STAGING_DIR)/usr/bin/python3-config --includes`" \
	PYTHON_LIBS="`$(STAGING_DIR)/usr/bin/python3-config --ldflags`" \
	PYTHON_EXTRA_LIBS="`$(STAGING_DIR)/usr/bin/python3-config --libs --embed`" \
	PYTHON_SITE_PKG="/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages"
ZFS_CONF_OPTS += --enable-pyzfs
else
ZFS_CONF_OPTS += --disable-pyzfs --without-python
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
ZFS_DEPENDENCIES += linux-pam
ZFS_CONF_OPTS += --enable-pam
else
ZFS_CONF_OPTS += --disable-pam
endif

# Sets the environment for the `make` that will be run ZFS autotools checks.
ZFS_CONF_ENV += \
	ARCH=$(KERNEL_ARCH) \
	CROSS_COMPILE="$(TARGET_CROSS)"
ZFS_MAKE_ENV += \
	ARCH=$(KERNEL_ARCH) \
	CROSS_COMPILE="$(TARGET_CROSS)"

# ZFS userland tools are unfunctional without the Linux kernel modules.
ZFS_MODULE_SUBDIRS = \
	module/avl \
	module/icp \
	module/lua \
	module/nvpair \
	module/spl \
	module/unicode \
	module/zcommon \
	module/zstd \
	module/zfs

# These requirements will be validated by zfs/config/kernel-config-defined.m4
define ZFS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_DISABLE_OPT,CONFIG_DEBUG_LOCK_ALLOC)
	$(call KCONFIG_DISABLE_OPT,CONFIG_TRIM_UNUSED_KSYMS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_DEFLATE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_ZLIB_DEFLATE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_ZLIB_INFLATE)
endef

# Even though zfs builds a kernel module, it gets built directly by
# the autotools logic, so we don't use the kernel-module
# infrastructure.
$(eval $(autotools-package))

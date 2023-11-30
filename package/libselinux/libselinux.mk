################################################################################
#
# libselinux
#
################################################################################

LIBSELINUX_VERSION = 3.5
LIBSELINUX_SITE = https://github.com/SELinuxProject/selinux/releases/download/$(LIBSELINUX_VERSION)
LIBSELINUX_LICENSE = Public Domain
LIBSELINUX_LICENSE_FILES = LICENSE
LIBSELINUX_CPE_ID_VENDOR = selinuxproject

LIBSELINUX_DEPENDENCIES = \
	$(BR2_COREUTILS_HOST_DEPENDENCY) host-pkgconf libsepol pcre2

LIBSELINUX_INSTALL_STAGING = YES

# Set SHLIBDIR to /usr/lib so it has the same value than LIBDIR, as a result
# we won't have to use a relative path in 0002-revert-ln-relative.patch
LIBSELINUX_MAKE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	ARCH=$(NORMALIZED_ARCH) \
	SHLIBDIR=/usr/lib \
	USE_PCRE2=y

LIBSELINUX_MAKE_INSTALL_TARGETS = install

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
LIBSELINUX_DEPENDENCIES += musl-fts
LIBSELINUX_MAKE_OPTS += FTS_LDLIBS=-lfts
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
LIBSELINUX_DEPENDENCIES += \
	python3 \
	python-setuptools \
	host-python-pip \
	host-swig

LIBSELINUX_MAKE_OPTS += \
	$(PKG_PYTHON_SETUPTOOLS_ENV) \
	PYTHON=python$(PYTHON3_VERSION_MAJOR)

LIBSELINUX_MAKE_INSTALL_TARGETS += install-pywrap

# dependencies are broken and result in file truncation errors at link
# time if the Python bindings are built through the same make
# invocation as the rest of the library.
define LIBSELINUX_BUILD_PYTHON_BINDINGS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		$(LIBSELINUX_MAKE_OPTS) swigify pywrap
endef
endif # python3

define LIBSELINUX_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		$(LIBSELINUX_MAKE_OPTS) all
	$(LIBSELINUX_BUILD_PYTHON_BINDINGS)
endef

define LIBSELINUX_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		$(LIBSELINUX_MAKE_OPTS) DESTDIR=$(STAGING_DIR) \
		$(LIBSELINUX_MAKE_INSTALL_TARGETS)
endef

define LIBSELINUX_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		$(LIBSELINUX_MAKE_OPTS) DESTDIR=$(TARGET_DIR) \
		$(LIBSELINUX_MAKE_INSTALL_TARGETS)
	if ! grep -q "selinuxfs" $(TARGET_DIR)/etc/fstab; then \
		echo "none /sys/fs/selinux selinuxfs noauto 0 0" >> $(TARGET_DIR)/etc/fstab ; fi
endef

HOST_LIBSELINUX_DEPENDENCIES = \
	host-pkgconf \
	host-libsepol \
	host-pcre2 \
	host-swig \
	host-python3 \
	host-python-pip \
	host-python-setuptools

HOST_LIBSELINUX_MAKE_OPTS = \
	$(HOST_CONFIGURE_OPTS) \
	PREFIX=$(HOST_DIR) \
	SHLIBDIR=$(HOST_DIR)/lib \
	$(HOST_PKG_PYTHON_SETUPTOOLS_ENV) \
	PYTHON=python$(PYTHON3_VERSION_MAJOR) \
	USE_PCRE2=y

define HOST_LIBSELINUX_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(HOST_LIBSELINUX_MAKE_OPTS) all
	# Generate python interface wrapper
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(HOST_LIBSELINUX_MAKE_OPTS) swigify pywrap
endef

define HOST_LIBSELINUX_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) \
		$(HOST_LIBSELINUX_MAKE_OPTS) install
	# Install python interface wrapper
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D) \
		$(HOST_LIBSELINUX_MAKE_OPTS) install-pywrap
endef

define LIBSELINUX_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_AUDIT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_DEFAULT_SECURITY_SELINUX)
	$(call KCONFIG_ENABLE_OPT,CONFIG_INET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECURITY)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECURITY_NETWORK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECURITY_SELINUX)
	$(call KCONFIG_SET_OPT,CONFIG_LSM,"selinux")
	$(if $(BR2_TARGET_ROOTFS_EROFS),
		$(call KCONFIG_ENABLE_OPT,CONFIG_EROFS_FS_XATTR)
		$(call KCONFIG_ENABLE_OPT,CONFIG_EROFS_FS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_EXT2),
		$(call KCONFIG_ENABLE_OPT,CONFIG_EXT2_FS_XATTR)
		$(call KCONFIG_ENABLE_OPT,CONFIG_EXT2_FS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_EXT2_3),
		$(call KCONFIG_ENABLE_OPT,CONFIG_EXT3_FS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_EXT2_4),
		$(call KCONFIG_ENABLE_OPT,CONFIG_EXT4_FS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_F2FS),
		$(call KCONFIG_ENABLE_OPT,CONFIG_F2FS_FS_XATTR)
		$(call KCONFIG_ENABLE_OPT,CONFIG_F2FS_FS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_JFFS2),
		$(call KCONFIG_ENABLE_OPT,CONFIG_JFS_SECURITY))
	$(if $(BR2_TARGET_ROOTFS_SQUASHFS),
		$(call KCONFIG_ENABLE_OPT,CONFIG_SQUASHFS_XATTR))
	$(if $(BR2_TARGET_ROOTFS_UBIFS),
		$(call KCONFIG_ENABLE_OPT,CONFIG_UBIFS_FS_XATTR)
		$(call KCONFIG_ENABLE_OPT,CONFIG_UBIFS_FS_SECURITY))
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

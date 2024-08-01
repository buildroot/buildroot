################################################################################
#
# e2fsprogs
#
################################################################################

E2FSPROGS_VERSION = 1.47.1
E2FSPROGS_SOURCE = e2fsprogs-$(E2FSPROGS_VERSION).tar.xz
E2FSPROGS_SITE = $(BR2_KERNEL_MIRROR)/linux/kernel/people/tytso/e2fsprogs/v$(E2FSPROGS_VERSION)
E2FSPROGS_LICENSE = GPL-2.0, MIT-like with advertising clause (libss and libet)
E2FSPROGS_LICENSE_FILES = NOTICE lib/ss/mit-sipb-copyright.h lib/et/internal.h
E2FSPROGS_CPE_ID_VALID = YES
E2FSPROGS_INSTALL_STAGING = YES

# Use libblkid and libuuid from util-linux for host and target packages.
# This prevents overriding them with e2fsprogs' ones, which may cause
# problems for other packages.
E2FSPROGS_DEPENDENCIES = host-pkgconf util-linux
HOST_E2FSPROGS_DEPENDENCIES = host-pkgconf host-util-linux

E2FSPROGS_SELINUX_MODULES = fstools

# e4defrag doesn't build on older systems like RHEL5.x, and we don't
# need it on the host anyway.
# Disable fuse2fs as well to avoid carrying over deps, and it's unused
HOST_E2FSPROGS_CONF_OPTS = \
	--disable-defrag \
	--disable-e2initrd-helper \
	--disable-fuse2fs \
	--disable-fsck \
	--disable-libblkid \
	--disable-libuuid \
	--disable-testio-debug \
	--enable-symlink-install \
	--enable-elf-shlibs \
	--with-crond-dir=no \
	--with-udev-rules-dir=no \
	--with-systemd-unit-dir=no

# Set the binary directories to "/bin" and "/sbin", as busybox does,
# so that we do not end up with two versions of e2fs tools.
E2FSPROGS_CONF_OPTS = \
	--bindir=/bin \
	--sbindir=/sbin \
	$(if $(BR2_STATIC_LIBS),--disable-elf-shlibs,--enable-elf-shlibs) \
	$(if $(BR2_PACKAGE_E2FSPROGS_DEBUGFS),--enable-debugfs,--disable-debugfs) \
	$(if $(BR2_PACKAGE_E2FSPROGS_E2IMAGE),--enable-imager,--disable-imager) \
	$(if $(BR2_PACKAGE_E2FSPROGS_E4DEFRAG),--enable-defrag,--disable-defrag) \
	$(if $(BR2_PACKAGE_E2FSPROGS_FSCK),--enable-fsck,--disable-fsck) \
	$(if $(BR2_PACKAGE_E2FSPROGS_RESIZE2FS),--enable-resizer,--disable-resizer) \
	--disable-uuidd \
	--disable-libblkid \
	--disable-libuuid \
	--disable-e2initrd-helper \
	--disable-testio-debug \
	--disable-rpath \
	--enable-symlink-install

ifeq ($(BR2_PACKAGE_E2FSPROGS_FUSE2FS),y)
E2FSPROGS_CONF_OPTS += --enable-fuse2fs
E2FSPROGS_DEPENDENCIES += libfuse
else
E2FSPROGS_CONF_OPTS += --disable-fuse2fs
endif

ifeq ($(BR2_nios2),y)
E2FSPROGS_CONF_ENV += ac_cv_func_fallocate=no
endif

# workaround gcc bug 111001
ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_111001),y)
E2FSPROGS_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -Os"
endif

E2FSPROGS_CONF_ENV += ac_cv_path_LDCONFIG=true

HOST_E2FSPROGS_CONF_ENV += ac_cv_path_LDCONFIG=true

E2FSPROGS_INSTALL_STAGING_OPTS = \
	DESTDIR=$(STAGING_DIR) \
	install-libs

# e2scrub has no associated --enable/disable option
ifneq ($(BR2_PACKAGE_E2FSPROGS_E2SCRUB),y)
E2FSPROGS_MAKE_OPTS += E2SCRUB_DIR=
endif

E2FSPROGS_INSTALL_TARGET_OPTS = \
	$(E2FSPROGS_MAKE_OPTS) \
	DESTDIR=$(TARGET_DIR) \
	install

# Package does not build in parallel due to improper make rules
define HOST_E2FSPROGS_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE1) -C $(@D) install install-libs
endef

# Remove compile_et which raises a build failure with samba4
define HOST_E2FSPROGS_REMOVE_COMPILE_ET
	$(RM) $(HOST_DIR)/bin/compile_et
endef
HOST_E2FSPROGS_POST_INSTALL_HOOKS += HOST_E2FSPROGS_REMOVE_COMPILE_ET

$(eval $(autotools-package))
$(eval $(host-autotools-package))

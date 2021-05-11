################################################################################
#
# libhugetlbfs
#
################################################################################

LIBHUGETLBFS_VERSION = 2.21
LIBHUGETLBFS_SITE = https://github.com/libhugetlbfs/libhugetlbfs/releases/download/$(LIBHUGETLBFS_VERSION)
LIBHUGETLBFS_INSTALL_STAGING = YES
LIBHUGETLBFS_DEPENDENCIES += host-libhugetlbfs

LIBHUGETLBFS_MAKE_ENV = CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" \
				  CC="$(TARGET_CC)" LD="$(TARGET_LD)" ARCH=mips PREFIX=/usr
LIBHUGETLBFS_HOST_MAKE_ENV = CFLAGS="$(HOST_CFLAGS)" LDFLAGS="$(HOST_LDFLAGS)" \
							 PREFIX=/usr BUILDTYPE=NATIVEONLY

define LIBHUGETLBFS_BUILD_CMDS
	$(LIBHUGETLBFS_MAKE_ENV) $(MAKE) -C $(@D) V=1 libs
endef

define HOST_LIBHUGETLBFS_BUILD_CMDS
	$(LIBHUGETLBFS_HOST_MAKE_ENV) $(MAKE) -C $(@D) V=1 tools
endef

define LIBHUGETLBFS_INSTALL_STAGING_CMDS
	$(LIBHUGETLBFS_MAKE_ENV) DESTDIR="$(STAGING_DIR)" $(MAKE) -C $(@D) install-libs
endef

define LIBHUGETLBFS_INSTALL_TARGET_CMDS
	$(LIBHUGETLBFS_MAKE_ENV) DESTDIR="$(TARGET_DIR)" $(MAKE) -C $(@D) install-libs
endef

define HOST_LIBHUGETLBFS_INSTALL_CMDS
	$(LIBHUGETLBFS_HOST_MAKE_ENV) DESTDIR="$(HOST_DIR)" $(MAKE) -C $(@D) install-bin
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

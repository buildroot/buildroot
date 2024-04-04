################################################################################
#
# lmdb
#
################################################################################

LMDB_VERSION = 0.9.31
LMDB_SITE = $(call github,LMDB,lmdb,LMDB_$(LMDB_VERSION))
LMDB_LICENSE = OLDAP-2.8
LMDB_LICENSE_FILES = libraries/liblmdb/LICENSE
LMDB_INSTALL_STAGING = YES

define LMDB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/libraries/liblmdb \
		XCFLAGS="$(TARGET_CFLAGS)"
endef

define LMDB_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		DESTDIR="$(STAGING_DIR)" \
		prefix=/usr \
		install
endef

define LMDB_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		DESTDIR="$(TARGET_DIR)" \
		prefix=/usr \
		install
endef

$(eval $(generic-package))

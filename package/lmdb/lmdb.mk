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

ifeq ($(BR2_STATIC_LIBS),y)
LMDB_ILBIBS += liblmdb.a
else ifeq ($(BR2_SHARED_LIBS),y)
LMDB_ILBIBS += liblmdb.so
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
LMDB_ILBIBS +=  liblmdb.a liblmdb.so
endif

define LMDB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/libraries/liblmdb \
		ILIBS="$(LMDB_ILBIBS)" \
		XCFLAGS="$(TARGET_CFLAGS)"
endef

define LMDB_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		ILIBS="$(LMDB_ILBIBS)" \
		DESTDIR="$(STAGING_DIR)" \
		prefix=/usr \
		install
endef

define LMDB_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		ILIBS="$(LMDB_ILBIBS)" \
		DESTDIR="$(TARGET_DIR)" \
		prefix=/usr \
		install
endef

$(eval $(generic-package))

################################################################################
#
# lmdb
#
################################################################################

LMDB_VERSION = 0.9.33
LMDB_SOURCE = openldap-LMDB_$(LMDB_VERSION).tar.bz2
LMDB_SITE = https://git.openldap.org/openldap/openldap/-/archive/LMDB_$(LMDB_VERSION)
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

LMDB_MAKE_OPTS += \
	AR="$(TARGET_AR)" \
	CC="$(TARGET_CC)" \
	ILIBS="$(LMDB_ILBIBS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	OPT="" \
	XCFLAGS="$(TARGET_CFLAGS)"

define LMDB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb $(LMDB_MAKE_OPTS)
endef

define LMDB_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		$(LMDB_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" \
		prefix=/usr \
		install
endef

define LMDB_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/libraries/liblmdb \
		$(LMDB_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" \
		prefix=/usr \
		install
endef

$(eval $(generic-package))

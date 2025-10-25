################################################################################
#
# sqlite
#
################################################################################

SQLITE_VERSION = 3.50.4
SQLITE_TAR_VERSION = 3500400
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_TAR_VERSION).tar.gz
SQLITE_SITE = https://www.sqlite.org/2025
SQLITE_LICENSE = blessing
SQLITE_LICENSE_FILES = tea/license.terms
SQLITE_CPE_ID_VENDOR = sqlite
SQLITE_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_SQLITE_STAT4),y)
SQLITE_CFLAGS += -DSQLITE_ENABLE_STAT4
endif

ifeq ($(BR2_PACKAGE_SQLITE_ENABLE_COLUMN_METADATA),y)
SQLITE_CFLAGS += -DSQLITE_ENABLE_COLUMN_METADATA
endif

ifeq ($(BR2_PACKAGE_SQLITE_ENABLE_RTREE),y)
SQLITE_CFLAGS += -DSQLITE_ENABLE_RTREE
endif

ifeq ($(BR2_PACKAGE_SQLITE_ENABLE_UNLOCK_NOTIFY),y)
SQLITE_CFLAGS += -DSQLITE_ENABLE_UNLOCK_NOTIFY
endif

ifeq ($(BR2_PACKAGE_SQLITE_SECURE_DELETE),y)
SQLITE_CFLAGS += -DSQLITE_SECURE_DELETE
endif

ifeq ($(BR2_PACKAGE_SQLITE_NO_SYNC),y)
SQLITE_CFLAGS += -DSQLITE_NO_SYNC
endif

# Building with Microblaze Gcc 4.9 makes compiling to hang.
# Work around using -O0
ifeq ($(BR2_microblaze):$(BR2_TOOLCHAIN_GCC_AT_LEAST_5),y:)
SQLITE_CFLAGS += $(TARGET_CFLAGS) -O0
else ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_104028),y)
SQLITE_CFLAGS += $(TARGET_CFLAGS) -O0
else
# fallback to standard -O3 when -Ofast is present to avoid -ffast-math
SQLITE_CFLAGS += $(subst -Ofast,-O3,$(TARGET_CFLAGS))
endif

ifeq ($(BR2_PACKAGE_NCURSES)$(BR2_PACKAGE_READLINE),yy)
SQLITE_DEPENDENCIES += ncurses readline
SQLITE_CFLAGS  += -DHAVE_READLINE=1
SQLITE_LDFLAGS += -lreadline -lncurses
else ifeq ($(BR2_PACKAGE_NCURSES)$(BR2_PACKAGE_LIBEDIT),yy)
SQLITE_DEPENDENCIES += ncurses libedit
SQLITE_CFLAGS  += -DHAVE_EDITLINE=1
SQLITE_LDFLAGS += -ledit -lncurses
else
SQLITE_CONF_OPTS += --disable-readline
endif

ifeq ($(BR2_PACKAGE_SQLITE_ENABLE_FTS3),y)
SQLITE_CONF_OPTS += --fts3
endif

ifeq ($(BR2_STATIC_LIBS),y)
SQLITE_CONF_OPTS += --disable-shared
endif

SQLITE_CONF_ENV = CFLAGS="$(SQLITE_CFLAGS)" LDFLAGS="$(SQLITE_LDFLAGS)"

# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101971
define SQLITE_FIX_MAKEFILE
	chmod +w $(@D)/Makefile
	sed -i "s/-fPIC//" $(@D)/Makefile
endef

define SQLITE_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) \
		$(if $(BR2_INSTALL_LIBSTDCPP),,CXX=false) \
		$(SQLITE_CONF_ENV) ./configure \
		--prefix=/usr \
		--host="$(GNU_TARGET_NAME)" \
		--build="$(GNU_HOST_NAME)" \
		--sysroot="$(STAGING_DIR)" \
		--disable-rpath \
		--soname=legacy \
		$(SQLITE_CONF_OPTS) \
	)
	$(if $(BR2_m68k_cf),$(SQLITE_FIX_MAKEFILE))
endef

define SQLITE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define SQLITE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(STAGING_DIR)" -C $(@D) install
endef

define SQLITE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

define HOST_SQLITE_CONFIGURE_CMDS
	(cd $(@D); $(HOST_CONFIGURE_OPTS) \
		./configure \
		--prefix=/usr \
		--host="$(GNU_HOST_NAME)" \
		--build="$(GNU_HOST_NAME)" \
		--sysroot="$(HOST_DIR)" \
		--disable-readline \
	)
endef

define HOST_SQLITE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_SQLITE_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) DESTDIR="$(HOST_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

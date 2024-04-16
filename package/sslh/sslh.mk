################################################################################
#
# sslh
#
################################################################################

SSLH_VERSION = 2.0.1
SSLH_SOURCE = sslh-v$(SSLH_VERSION).tar.gz
SSLH_SITE = http://www.rutschle.net/tech/sslh
SSLH_LICENSE = GPL-2.0+
SSLH_LICENSE_FILES = COPYING
SSLH_CPE_ID_VALID = YES
SSLH_DEPENDENCIES = pcre2

SSLH_MAKE_OPTS = $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

ifeq ($(BR2_PACKAGE_LIBBSD),y)
SSLH_DEPENDENCIES += libbsd
SSLH_MAKE_OPTS += USELIBBSD=1
else
SSLH_MAKE_OPTS += USELIBBSD=
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
SSLH_DEPENDENCIES += libcap
SSLH_MAKE_OPTS += USELIBCAP=1
else
SSLH_MAKE_OPTS += USELIBCAP=
endif

ifeq ($(BR2_PACKAGE_LIBCONFIG),y)
SSLH_DEPENDENCIES += libconfig
SSLH_MAKE_OPTS += USELIBCONFIG=1
else
SSLH_MAKE_OPTS += USELIBCONFIG=
endif

ifeq ($(BR2_PACKAGE_LIBEV),y)
SSLH_DEPENDENCIES += libev
SSLH_MAKE_OPTS += USELIBEV=1
else
SSLH_MAKE_OPTS += USELIBEV=
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
SSLH_DEPENDENCIES += systemd
SSLH_MAKE_OPTS += USESYSTEMD=1
else
SSLH_MAKE_OPTS += USESYSTEMD=
endif

define SSLH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(SSLH_MAKE_OPTS) -C $(@D)
endef

define SSLH_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(SSLH_MAKE_OPTS) -C $(@D) \
		DESTDIR=$(TARGET_DIR) install
endef

define SSLH_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/sslh/S35sslh $(TARGET_DIR)/etc/init.d/S35sslh
endef

$(eval $(generic-package))

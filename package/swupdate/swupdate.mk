################################################################################
#
# swupdate
#
################################################################################

SWUPDATE_VERSION = 2022.05
SWUPDATE_SITE = $(call github,sbabic,swupdate,$(SWUPDATE_VERSION))
SWUPDATE_LICENSE = GPL-2.0, GPL-2.0+, LGPL-2.1+, MIT, ISC, BSD-1-Clause, BSD-3-Clause, CC0-1.0, CC-BY-SA-4.0, OFL-1.1
SWUPDATE_LICENSE_FILES = LICENSES/BSD-1-Clause.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/CC0-1.0.txt \
	LICENSES/CC-BY-SA-4.0.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/ISC.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/MIT.txt \
	LICENSES/OFL-1.1.txt

# swupdate uses $CROSS-cc instead of $CROSS-gcc, which is not
# available in all external toolchains, and use CC for linking. Ensure
# TARGET_CC is used for both.
SWUPDATE_MAKE_ENV = CC="$(TARGET_CC)" LD="$(TARGET_CC)" SKIP_STRIP=y

# swupdate bundles its own version of mongoose (version 6.16)

ifeq ($(BR2_PACKAGE_E2FSPROGS),y)
SWUPDATE_DEPENDENCIES += e2fsprogs
SWUPDATE_MAKE_ENV += HAVE_LIBEXT2FS=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBEXT2FS=n
endif

ifeq ($(BR2_PACKAGE_JSON_C),y)
SWUPDATE_DEPENDENCIES += json-c
SWUPDATE_MAKE_ENV += HAVE_JSON_C=y
else
SWUPDATE_MAKE_ENV += HAVE_JSON_C=n
endif

ifeq ($(BR2_PACKAGE_LIBARCHIVE),y)
SWUPDATE_DEPENDENCIES += libarchive
SWUPDATE_MAKE_ENV += HAVE_LIBARCHIVE=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBARCHIVE=n
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBBLKID),y)
SWUPDATE_DEPENDENCIES += util-linux
SWUPDATE_MAKE_ENV += HAVE_LIBBLKID=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBBLKID=n
endif

ifeq ($(BR2_PACKAGE_LIBCONFIG),y)
SWUPDATE_DEPENDENCIES += libconfig
SWUPDATE_MAKE_ENV += HAVE_LIBCONFIG=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBCONFIG=n
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
SWUPDATE_DEPENDENCIES += libcurl
SWUPDATE_MAKE_ENV += HAVE_LIBCURL=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBCURL=n
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBFDISK),y)
SWUPDATE_DEPENDENCIES += util-linux
SWUPDATE_MAKE_ENV += HAVE_LIBFDISK=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBFDISK=n
endif

ifeq ($(BR2_PACKAGE_LIBGPIOD),y)
SWUPDATE_DEPENDENCIES += libgpiod
SWUPDATE_MAKE_ENV += HAVE_LIBGPIOD=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBGPIOD=n
endif

ifeq ($(BR2_PACKAGE_LIBURIPARSER),y)
SWUPDATE_DEPENDENCIES += liburiparser
SWUPDATE_MAKE_ENV += HAVE_URIPARSER=y
else
SWUPDATE_MAKE_ENV += HAVE_URIPARSER=n
endif

ifeq ($(BR2_PACKAGE_LIBWEBSOCKETS),y)
SWUPDATE_DEPENDENCIES += libwebsockets
SWUPDATE_MAKE_ENV += HAVE_LIBWEBSOCKETS=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBWEBSOCKETS=n
endif

ifeq ($(BR2_PACKAGE_HAS_LUAINTERPRETER),y)
SWUPDATE_DEPENDENCIES += luainterpreter host-pkgconf
# defines the base name for the pkg-config file ("lua" or "luajit")
define SWUPDATE_SET_LUA_VERSION
	$(call KCONFIG_SET_OPT,CONFIG_LUAPKG,$(BR2_PACKAGE_PROVIDES_LUAINTERPRETER))
endef
SWUPDATE_MAKE_ENV += HAVE_LUA=y
else
SWUPDATE_MAKE_ENV += HAVE_LUA=n
endif

ifeq ($(BR2_PACKAGE_MBEDTLS),y)
SWUPDATE_DEPENDENCIES += mbedtls
SWUPDATE_MAKE_ENV += HAVE_MBEDTLS=y
else
SWUPDATE_MAKE_ENV += HAVE_MBEDTLS=n
endif

ifeq ($(BR2_PACKAGE_MTD),y)
SWUPDATE_DEPENDENCIES += mtd
SWUPDATE_MAKE_ENV += HAVE_LIBMTD=y
SWUPDATE_MAKE_ENV += HAVE_LIBUBI=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBMTD=n
SWUPDATE_MAKE_ENV += HAVE_LIBUBI=n
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
SWUPDATE_DEPENDENCIES += openssl
SWUPDATE_MAKE_ENV += HAVE_LIBSSL=y
SWUPDATE_MAKE_ENV += HAVE_LIBCRYPTO=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBSSL=n
SWUPDATE_MAKE_ENV += HAVE_LIBCRYPTO=n
endif

ifeq ($(BR2_PACKAGE_P11_KIT),y)
SWUPDATE_DEPENDENCIES += p11-kit
SWUPDATE_MAKE_ENV += HAVE_P11KIT=y
else
SWUPDATE_MAKE_ENV += HAVE_P11KIT=n
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
SWUPDATE_DEPENDENCIES += systemd
SWUPDATE_MAKE_ENV += HAVE_LIBSYSTEMD=y
define SWUPDATE_SET_SYSTEMD
	$(call KCONFIG_ENABLE_OPT,CONFIG_SYSTEMD)
endef
else
SWUPDATE_MAKE_ENV += HAVE_LIBSYSTEMD=n
define SWUPDATE_SET_SYSTEMD
	$(call KCONFIG_DISABLE_OPT,CONFIG_SYSTEMD)
endef
endif

ifeq ($(BR2_PACKAGE_WOLFSSL),y)
SWUPDATE_DEPENDENCIES += wolfssl
SWUPDATE_MAKE_ENV += HAVE_WOLFSSL=y
else
SWUPDATE_MAKE_ENV += HAVE_WOLFSSL=n
endif

ifeq ($(BR2_PACKAGE_ZCHUNK),y)
SWUPDATE_DEPENDENCIES += zchunk
SWUPDATE_MAKE_ENV += HAVE_ZCK=y
else
SWUPDATE_MAKE_ENV += HAVE_ZCK=n
endif

ifeq ($(BR2_PACKAGE_ZEROMQ),y)
SWUPDATE_DEPENDENCIES += zeromq
SWUPDATE_MAKE_ENV += HAVE_LIBZEROMQ=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBZEROMQ=n
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
SWUPDATE_DEPENDENCIES += zlib
SWUPDATE_MAKE_ENV += HAVE_ZLIB=y
else
SWUPDATE_MAKE_ENV += HAVE_ZLIB=n
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
SWUPDATE_DEPENDENCIES += zstd
SWUPDATE_MAKE_ENV += HAVE_ZSTD=y
else
SWUPDATE_MAKE_ENV += HAVE_ZSTD=n
endif

ifeq ($(BR2_PACKAGE_LIBRSYNC),y)
SWUPDATE_DEPENDENCIES += librsync
SWUPDATE_MAKE_ENV += HAVE_LIBRSYNC=y
else
SWUPDATE_MAKE_ENV += HAVE_LIBRSYNC=n
endif

ifeq ($(BR2_PACKAGE_SWUPDATE_WEBSERVER),y)
define SWUPDATE_SET_WEBSERVER
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEBSERVER)
endef
else
define SWUPDATE_SET_WEBSERVER
	$(call KCONFIG_DISABLE_OPT,CONFIG_WEBSERVER)
endef
endif

SWUPDATE_BUILD_CONFIG = $(@D)/.config

SWUPDATE_KCONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_SWUPDATE_CONFIG))
SWUPDATE_KCONFIG_EDITORS = menuconfig xconfig gconfig nconfig

SWUPDATE_MAKE_OPTS = \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
	CONFIG_EXTRA_LDFLAGS="$(TARGET_LDFLAGS)"

define SWUPDATE_KCONFIG_FIXUP_CMDS
	$(SWUPDATE_SET_LUA_VERSION)
	$(SWUPDATE_SET_SYSTEMD)
	$(SWUPDATE_SET_WEBSERVER)
endef

define SWUPDATE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(SWUPDATE_MAKE_ENV) $(MAKE) -C $(@D) $(SWUPDATE_MAKE_OPTS)
endef

define SWUPDATE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(SWUPDATE_MAKE_ENV) $(MAKE) -C $(@D) \
		$(SWUPDATE_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install
	$(if $(BR2_PACKAGE_SWUPDATE_INSTALL_WEBSITE), \
		mkdir -p $(TARGET_DIR)/var/www/swupdate; \
		cp -dpfr $(@D)/examples/www/v2/* $(TARGET_DIR)/var/www/swupdate)
endef

# Checks to give errors that the user can understand
# Must be before we call to kconfig-package
ifeq ($(BR2_PACKAGE_SWUPDATE)$(BR_BUILDING),yy)
ifeq ($(call qstrip,$(BR2_PACKAGE_SWUPDATE_CONFIG)),)
$(error No Swupdate configuration file specified, check your BR2_PACKAGE_SWUPDATE_CONFIG setting)
endif
endif

# Services and configs derived from meta-swupdate(MIT license)
# https://github.com/sbabic/meta-swupdate/tree/master/recipes-support/swupdate/swupdate
define SWUPDATE_INSTALL_COMMON
	mkdir -p $(TARGET_DIR)/etc/swupdate/conf.d \
		$(TARGET_DIR)/usr/lib/swupdate/conf.d
	$(INSTALL) -D -m 755 $(SWUPDATE_PKGDIR)/swupdate.sh \
		$(TARGET_DIR)/usr/lib/swupdate/swupdate.sh
	$(if $(BR2_PACKAGE_SWUPDATE_WEBSERVER), \
		$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/10-mongoose-args \
			$(TARGET_DIR)/usr/lib/swupdate/conf.d/10-mongoose-args)
endef
define SWUPDATE_INSTALL_INIT_SYSTEMD
	$(SWUPDATE_INSTALL_COMMON)
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/swupdate.service \
		$(TARGET_DIR)/usr/lib/systemd/system/swupdate.service
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/swupdate.socket \
		$(TARGET_DIR)/usr/lib/systemd/system/swupdate.socket
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/swupdate-usb@.service \
		$(TARGET_DIR)/usr/lib/systemd/system/swupdate-usb@.service
	$(if $(BR2_PACKAGE_SWUPDATE_USB), \
		$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/swupdate-usb.rules \
			$(TARGET_DIR)/lib/udev/rules.d/swupdate-usb.rules)
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/swupdate-progress.service \
		$(TARGET_DIR)/usr/lib/systemd/system/swupdate-progress.service
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/tmpfiles-swupdate.conf \
		$(TARGET_DIR)/usr/lib/tmpfiles.d/tmpfiles-swupdate.conf
endef
define SWUPDATE_INSTALL_INIT_SYSV
	$(SWUPDATE_INSTALL_COMMON)
	$(INSTALL) -D -m 755 $(SWUPDATE_PKGDIR)/S80swupdate \
		$(TARGET_DIR)/etc/init.d/S80swupdate
	$(INSTALL) -D -m 644 $(SWUPDATE_PKGDIR)/90-start-progress \
		$(TARGET_DIR)/usr/lib/swupdate/conf.d/90-start-progress
endef

$(eval $(kconfig-package))

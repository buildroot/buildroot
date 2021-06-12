################################################################################
#
# seatd
#
################################################################################

SEATD_VERSION = 0.5.0
SEATD_SOURCE = $(SEATD_VERSION).tar.gz
SEATD_SITE = https://git.sr.ht/~kennylevinsen/seatd/archive
SEATD_LICENSE = MIT
SEATD_LICENSE_FILES = LICENSE
SEATD_INSTALL_STAGING = YES

SEATD_CONF_OPTS += \
	-Dman-pages=disabled \
	-Dexamples=disabled \
	-Dwerror=false

ifeq ($(BR2_PACKAGE_SYSTEMD_LOGIND),y)
SEATD_CONF_OPTS += -Dlogind=enabled
SEATD_DEPENDENCIES += systemd
else
SEATD_CONF_OPTS += -Dlogind=disabled
endif

ifeq ($(BR2_PACKAGE_SEATD_BUILTIN),y)
SEATD_CONF_OPTS += -Dbuiltin=enabled
else
SEATD_CONF_OPTS += -Dbuiltin=disabled
endif

ifeq ($(BR2_PACKAGE_SEATD_DAEMON),y)
SEATD_CONF_OPTS += -Dseatd=enabled -Dserver=enabled

define SEATD_USERS
	- - video -1 - - - - -
endef

define SEATD_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(SEATD_PKGDIR)/S70seatd \
		$(TARGET_DIR)/etc/init.d/S70seatd
endef

define SEATD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 -D $(@D)/contrib/systemd/seatd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/seatd.service
endef

else
SEATD_CONF_OPTS += -Dseatd=disabled -Dserver=disabled
endif

$(eval $(meson-package))

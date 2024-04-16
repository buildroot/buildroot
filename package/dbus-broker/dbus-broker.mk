################################################################################
#
# dbus-broker
#
################################################################################

DBUS_BROKER_VERSION = 33
DBUS_BROKER_SOURCE = dbus-broker-$(DBUS_BROKER_VERSION).tar.xz
DBUS_BROKER_SITE = https://github.com/bus1/dbus-broker/releases/download/v$(DBUS_BROKER_VERSION)

DBUS_BROKER_LICENSE = \
	Apache-2.0, \
	Apache-2.0 and/or LGPL-2.1+ (c-dvar, c-ini, c-list, c-rbtree, c-shquote, c-stdaux, c-utf8)
# For the third-party code, the licensing legal-info is inconsistent between
# the AUTHORS and README, so keep both
DBUS_BROKER_LICENSE_FILES = \
	LICENSE \
	subprojects/libcdvar-1/AUTHORS subprojects/libcdvar-1/README.md \
	subprojects/libcini-1/AUTHORS subprojects/libcini-1/README.md \
	subprojects/libclist-3/AUTHORS subprojects/libclist-3/README.md \
	subprojects/libcrbtree-3/AUTHORS subprojects/libcrbtree-3/README.md \
	subprojects/libcshquote-1/AUTHORS subprojects/libcshquote-1/README.md \
	subprojects/libcstdaux-1/AUTHORS subprojects/libcstdaux-1/README.md \
	subprojects/libcutf8-1/AUTHORS subprojects/libcutf8-1/README.md

DBUS_BROKER_CPE_ID_VALID = YES
DBUS_BROKER_DEPENDENCIES = expat systemd
DBUS_BROKER_CONF_OPTS = -Dlauncher=true

ifeq ($(BR2_PACKAGE_AUDIT),y)
# libcap-ng selected from Config.in
DBUS_BROKER_DEPENDENCIES += audit libcap-ng
DBUS_BROKER_CONF_OPTS += -Daudit=true
else
DBUS_BROKER_CONF_OPTS += -Daudit=false
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
DBUS_BROKER_DEPENDENCIES += libselinux
DBUS_BROKER_CONF_OPTS += -Dselinux=true
else
DBUS_BROKER_CONF_OPTS += -Dselinux=false
endif

# We must be using the same user as the original dbus, so we can share
# the home directory and create a socket there. As a consequence, the
# username and groupname must be dbus:dbus, and they both need to have
# the same home.
define DBUS_BROKER_USERS
	dbus -1 dbus -1 * /run/dbus - dbus DBus messagebus user
endef

# We overwrite some files from dbus, so add a dependency.
ifeq ($(BR2_PACKAGE_DBUS),y)
DBUS_BROKER_DEPENDENCIES += dbus
endif

define DBUS_BROKER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(DBUS_BROKER_PKGDIR)/session.conf \
		$(TARGET_DIR)/usr/share/dbus-1/session.conf
	$(INSTALL) -D -m 0644 $(DBUS_BROKER_PKGDIR)/system.conf \
		$(TARGET_DIR)/usr/share/dbus-1/system.conf
	$(INSTALL) -D -m 0644 $(DBUS_BROKER_PKGDIR)/dbus.socket \
		$(TARGET_DIR)/usr/lib/systemd/system/dbus.socket
	$(HOST_MAKE_ENV) ln -sf ../dbus.socket \
		$(TARGET_DIR)/usr/lib/systemd/system/sockets.target.wants/dbus.socket
endef

$(eval $(meson-package))

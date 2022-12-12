################################################################################
#
# modem-manager
#
################################################################################

MODEM_MANAGER_VERSION = 1.20.2
MODEM_MANAGER_SOURCE = ModemManager-$(MODEM_MANAGER_VERSION).tar.gz
MODEM_MANAGER_SITE = https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/archive/$(MODEM_MANAGER_VERSION)
MODEM_MANAGER_LICENSE = GPL-2.0+ (programs, plugins), LGPL-2.0+ (libmm-glib)
MODEM_MANAGER_LICENSE_FILES = COPYING COPYING.LIB
MODEM_MANAGER_SELINUX_MODULES = modemmanager
MODEM_MANAGER_DEPENDENCIES = host-pkgconf dbus libglib2 $(TARGET_NLS_DEPENDENCIES) host-libxslt
MODEM_MANAGER_INSTALL_STAGING = YES
MODEM_MANAGER_CONF_OPTS = \
	-Dpowerd_suspend_resume=false \
	-Dudevdir=/usr/lib/udev

ifeq ($(BR2_PACKAGE_LIBGUDEV),y)
MODEM_MANAGER_DEPENDENCIES += libgudev
MODEM_MANAGER_CONF_OPTS += -Dudev=true
else
MODEM_MANAGER_CONF_OPTS += -Dudev=false
endif

ifeq ($(BR2_PACKAGE_MODEM_MANAGER_LIBQMI),y)
MODEM_MANAGER_DEPENDENCIES += libqmi
MODEM_MANAGER_CONF_OPTS += -Dqmi=true
else
MODEM_MANAGER_CONF_OPTS += -Dqmi=false
endif

ifeq ($(BR2_PACKAGE_MODEM_MANAGER_LIBMBIM),y)
MODEM_MANAGER_DEPENDENCIES += libmbim
MODEM_MANAGER_CONF_OPTS += -Dmbim=true
else
MODEM_MANAGER_CONF_OPTS += -Dmbim=false
endif

ifeq ($(BR2_PACKAGE_LIBQRTR_GLIB),y)
MODEM_MANAGER_DEPENDENCIES += libqrtr-glib
MODEM_MANAGER_CONF_OPTS += -Dqrtr=true
else
MODEM_MANAGER_CONF_OPTS += -Dqrtr=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
MODEM_MANAGER_DEPENDENCIES += systemd
MODEM_MANAGER_CONF_OPTS += \
	-Dsystemd_journal=true \
	-Dsystemd_suspend_resume=true \
	-Dsystemdsystemunitdir=/usr/lib/systemd/system
else
MODEM_MANAGER_CONF_OPTS += \
	-Dsystemd_journal=false \
	-Dsystemd_suspend_resume=false \
	-Dsystemdsystemunitdir=no
endif

ifeq ($(BR2_PACKAGE_POLKIT),y)
MODEM_MANAGER_DEPENDENCIES += polkit
MODEM_MANAGER_CONF_OPTS += -Dpolkit=strict
else
MODEM_MANAGER_CONF_OPTS += -Dpolkit=no
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
MODEM_MANAGER_DEPENDENCIES += gobject-introspection
MODEM_MANAGER_CONF_OPTS += -Dintrospection=true
else
MODEM_MANAGER_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
MODEM_MANAGER_DEPENDENCIES += bash-completion
MODEM_MANAGER_CONF_OPTS += -Dbash_completion=true
else
MODEM_MANAGER_CONF_OPTS += -Dbash_completion=false
endif

define MODEM_MANAGER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/modem-manager/S44modem-manager \
		$(TARGET_DIR)/etc/init.d/S44modem-manager
endef

$(eval $(meson-package))

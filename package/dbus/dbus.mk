################################################################################
#
# dbus
#
################################################################################

# When updating dbus, check if there are changes in session.conf and
# system.conf, and update the versions in the dbus-broker package accordingly.
DBUS_VERSION = 1.16.2
DBUS_SOURCE = dbus-$(DBUS_VERSION).tar.xz
DBUS_SITE = https://dbus.freedesktop.org/releases/dbus
DBUS_LICENSE = \
	AFL-2.0 or GPL-2.0+ (dbus/dbus-arch-deps.h.in), \
	AFL-2.1 or GPL-2.0+ (library, daemon, some tools), \
	GPL-2.0+ (some tools), MIT (some files), \
	Public Domain (dbus-sha), TCL (dbus-hash), \
	LicenseRef-CMakeScripts (cmake/modules/FindGLIB2.cmake), \
	LicenseRef-GAP (dbus/versioninfo.rc.in)
DBUS_LICENSE_FILES = \
	COPYING \
	LICENSES/AFL-2.0.txt \
	LICENSES/AFL-2.1.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/LicenseRef-CMakeScripts.txt \
	LICENSES/LicenseRef-GAP.txt \
	LICENSES/LicenseRef-pycrypto-orig.txt \
	LICENSES/MIT.txt \
	LICENSES/TCL.txt
DBUS_CPE_ID_VENDOR = freedesktop
DBUS_INSTALL_STAGING = YES

define DBUS_PERMISSIONS
	/usr/libexec/dbus-daemon-launch-helper f 4750 0 dbus - - - - -
endef

define DBUS_USERS
	dbus -1 dbus -1 * /run/dbus - dbus DBus messagebus user
endef

DBUS_DEPENDENCIES = host-pkgconf expat

DBUS_SELINUX_MODULES = dbus

DBUS_CONF_OPTS = \
	-Dapparmor=disabled \
	-Dasserts=false \
	-Ddbus_user=dbus \
	-Ddoxygen_docs=disabled \
	-Dducktype_docs=disabled \
	-Dinstalled_tests=false \
	-Dintrusive_tests=false \
	-Dlaunchd=disabled \
	-Dmodular_tests=disabled \
	-Dqt_help=disabled \
	-Druntime_dir=/run \
	-Dsession_socket_dir=/tmp \
	-Dsystem_pid_file=/run/dbus-daemon.pid \
	-Dsystem_socket=/run/dbus/system_bus_socket \
	-Dxml_docs=disabled

ifeq ($(BR2_microblaze),y)
# microblaze toolchain doesn't provide inotify_rm_* but does have sys/inotify.h
DBUS_CONF_OPTS += -Dinotify=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
DBUS_CONF_OPTS += -Dselinux=enabled
DBUS_DEPENDENCIES += libselinux
else
DBUS_CONF_OPTS += -Dselinux=disabled
endif

ifeq ($(BR2_PACKAGE_AUDIT)$(BR2_PACKAGE_LIBCAP_NG),yy)
DBUS_CONF_OPTS += -Dlibaudit=enabled
DBUS_DEPENDENCIES += audit libcap-ng
else
DBUS_CONF_OPTS += -Dlibaudit=disabled
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
DBUS_CONF_OPTS += -Dx11_autolaunch=enabled
DBUS_DEPENDENCIES += xlib_libX11
else
DBUS_CONF_OPTS += -Dx11_autolaunch=disabled
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
DBUS_CONF_OPTS += \
	-Dsystemd=enabled \
	-Dsystemd_system_unitdir=/usr/lib/systemd/system \
	-Dsystemd_user_unitdir=/usr/lib/systemd/user \
	-Duser_session=true
DBUS_DEPENDENCIES += systemd
else
DBUS_CONF_OPTS += \
	-Dsystemd=disabled \
	-Duser_session=false
endif

# fix rebuild (dbus makefile errors out if /var/lib/dbus is a symlink)
define DBUS_REMOVE_VAR_LIB_DBUS
	rm -rf $(TARGET_DIR)/var/lib/dbus
endef

DBUS_PRE_INSTALL_TARGET_HOOKS += DBUS_REMOVE_VAR_LIB_DBUS

define DBUS_REMOVE_DEVFILES
	rm -rf $(TARGET_DIR)/usr/lib/dbus-1.0
endef

DBUS_POST_INSTALL_TARGET_HOOKS += DBUS_REMOVE_DEVFILES

define DBUS_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/dbus/S30dbus-daemon \
		$(TARGET_DIR)/etc/init.d/S30dbus-daemon

	mkdir -p $(TARGET_DIR)/var/lib
	rm -rf $(TARGET_DIR)/var/lib/dbus
	ln -sf /tmp/dbus $(TARGET_DIR)/var/lib/dbus
endef

# If dbus-broker is installed, don't install the activation links for
# dbus itself, not the configuration files. They will be overwritten
# by dbus-broker
ifeq ($(BR2_PACKAGE_DBUS_BROKER),y)
define DBUS_REMOVE_SYSTEMD_ACTIVATION_LINKS
	rm -f $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/dbus.service
	rm -f $(TARGET_DIR)/usr/lib/systemd/system/sockets.target.wants/dbus.socket
	rm -f $(TARGET_DIR)/usr/lib/systemd/system/dbus.socket
	rm -f $(TARGET_DIR)/usr/share/dbus-1/session.conf
	rm -f $(TARGET_DIR)/usr/share/dbus-1/system.conf
endef
DBUS_POST_INSTALL_TARGET_HOOKS += DBUS_REMOVE_SYSTEMD_ACTIVATION_LINKS
endif

define DBUS_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/var/lib/dbus
	ln -sf /etc/machine-id $(TARGET_DIR)/var/lib/dbus/machine-id
endef

HOST_DBUS_DEPENDENCIES = host-pkgconf host-expat
HOST_DBUS_CONF_OPTS = \
	-Dapparmor=disabled \
	-Dasserts=false \
	-Ddbus_user=dbus \
	-Ddoxygen_docs=disabled \
	-Dducktype_docs=disabled \
	-Dinstalled_tests=false \
	-Dintrusive_tests=false \
	-Dlaunchd=disabled \
	-Dlibaudit=disabled \
	-Dmodular_tests=disabled \
	-Dqt_help=disabled \
	-Dselinux=disabled \
	-Dsystemd=disabled \
	-Duser_session=false \
	-Dx11_autolaunch=disabled \
	-Dxml_docs=disabled

# dbus for the host
DBUS_HOST_INTROSPECT = $(HOST_DBUS_DIR)/introspect.xml

HOST_DBUS_GEN_INTROSPECT = \
	$(HOST_DIR)/bin/dbus-daemon --introspect > $(DBUS_HOST_INTROSPECT)

HOST_DBUS_POST_INSTALL_HOOKS += HOST_DBUS_GEN_INTROSPECT

$(eval $(meson-package))
$(eval $(host-meson-package))

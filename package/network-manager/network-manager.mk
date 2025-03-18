################################################################################
#
# network-manager
#
################################################################################

NETWORK_MANAGER_VERSION_MAJOR = 1.52
NETWORK_MANAGER_VERSION = $(NETWORK_MANAGER_VERSION_MAJOR).0
NETWORK_MANAGER_SOURCE = NetworkManager-$(NETWORK_MANAGER_VERSION).tar.xz
NETWORK_MANAGER_SITE = https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/releases/$(NETWORK_MANAGER_VERSION)/downloads
NETWORK_MANAGER_INSTALL_STAGING = YES
NETWORK_MANAGER_LICENSE = GPL-2.0+ (app), LGPL-2.1+ (libnm)
NETWORK_MANAGER_LICENSE_FILES = COPYING COPYING.LGPL
NETWORK_MANAGER_CPE_ID_VENDOR = gnome
NETWORK_MANAGER_CPE_ID_PRODUCT = networkmanager
NETWORK_MANAGER_SELINUX_MODULES = networkmanager

NETWORK_MANAGER_DEPENDENCIES = \
	host-intltool \
	host-libxslt \
	host-pkgconf \
	dbus \
	libglib2 \
	libndp \
	udev \
	util-linux

NETWORK_MANAGER_CONF_OPTS = \
	-Ddocs=false \
	-Dtests=no \
	-Dqt=false \
	-Diptables=/usr/sbin/iptables \
	-Difupdown=false \
	-Dnm_cloud_setup=false \
	-Dsession_tracking_consolekit=false

ifeq ($(BR2_PACKAGE_AUDIT),y)
NETWORK_MANAGER_DEPENDENCIES += audit
NETWORK_MANAGER_CONF_OPTS += -Dlibaudit=yes
else
NETWORK_MANAGER_CONF_OPTS += -Dlibaudit=no
endif

ifeq ($(BR2_PACKAGE_DHCP_CLIENT),y)
NETWORK_MANAGER_CONF_OPTS += -Ddhclient=/sbin/dhclient
endif

ifeq ($(BR2_PACKAGE_DHCPCD),y)
NETWORK_MANAGER_CONF_OPTS += -Ddhcpcd=/sbin/dhcpcd
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
NETWORK_MANAGER_CONF_OPTS += -Dintrospection=true
else
NETWORK_MANAGER_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_IWD),y)
NETWORK_MANAGER_DEPENDENCIES += iwd
NETWORK_MANAGER_CONF_OPTS += -Diwd=true
ifeq ($(BR2_PACKAGE_WPA_SUPPLICANT),y)
NETWORK_MANAGER_CONF_OPTS += -Dconfig_wifi_backend_default=wpa_supplicant
else
NETWORK_MANAGER_CONF_OPTS += -Dconfig_wifi_backend_default=iwd
endif
else
NETWORK_MANAGER_CONF_OPTS += \
	-Diwd=false \
	-Dconfig_wifi_backend_default=wpa_supplicant
endif

ifeq ($(BR2_PACKAGE_LIBCURL),y)
NETWORK_MANAGER_DEPENDENCIES += libcurl
NETWORK_MANAGER_CONF_OPTS += -Dconcheck=true
else
NETWORK_MANAGER_CONF_OPTS += -Dconcheck=false
endif

ifeq ($(BR2_PACKAGE_LIBNSS),y)
NETWORK_MANAGER_DEPENDENCIES += libnss
NETWORK_MANAGER_CONF_OPTS += -Dcrypto=nss
else
NETWORK_MANAGER_DEPENDENCIES += gnutls
NETWORK_MANAGER_CONF_OPTS += -Dcrypto=gnutls
endif

ifeq ($(BR2_PACKAGE_LIBPSL),y)
NETWORK_MANAGER_DEPENDENCIES += libpsl
NETWORK_MANAGER_CONF_OPTS += -Dlibpsl=true
else
NETWORK_MANAGER_CONF_OPTS += -Dlibpsl=false
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
NETWORK_MANAGER_DEPENDENCIES += libselinux
NETWORK_MANAGER_CONF_OPTS += -Dselinux=true
else
NETWORK_MANAGER_CONF_OPTS += -Dselinux=false
endif

ifeq ($(BR2_PACKAGE_NETWORK_MANAGER_MODEM_MANAGER),y)
NETWORK_MANAGER_DEPENDENCIES += modem-manager mobile-broadband-provider-info
NETWORK_MANAGER_CONF_OPTS += -Dmodem_manager=true
NETWORK_MANAGER_CONF_OPTS += -Dmobile_broadband_provider_info_database=/usr/share/mobile-broadband-provider-info/serviceproviders.xml
else
NETWORK_MANAGER_CONF_OPTS += -Dmodem_manager=false
endif

ifeq ($(BR2_PACKAGE_NETWORK_MANAGER_OVS),y)
NETWORK_MANAGER_CONF_OPTS += -Dovs=true
NETWORK_MANAGER_DEPENDENCIES += jansson
else
NETWORK_MANAGER_CONF_OPTS += -Dovs=false
endif

ifeq ($(BR2_PACKAGE_NETWORK_MANAGER_PPPD),y)
NETWORK_MANAGER_DEPENDENCIES += pppd
NETWORK_MANAGER_CONF_OPTS += \
	-Dppp=true \
	-Dpppd=/usr/sbin/pppd \
	-Dpppd_plugin_dir=/usr/lib/pppd/$(PPPD_VERSION)
else
NETWORK_MANAGER_CONF_OPTS += -Dppp=false
endif

ifeq ($(BR2_PACKAGE_NETWORK_MANAGER_TUI),y)
NETWORK_MANAGER_DEPENDENCIES += newt
NETWORK_MANAGER_CONF_OPTS += -Dnmtui=true
else
NETWORK_MANAGER_CONF_OPTS += -Dnmtui=false
endif

ifeq ($(BR2_PACKAGE_OFONO),y)
NETWORK_MANAGER_DEPENDENCIES += ofono
NETWORK_MANAGER_CONF_OPTS += -Dofono=true
else
NETWORK_MANAGER_CONF_OPTS += -Dofono=false
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
NETWORK_MANAGER_DEPENDENCIES += systemd
NETWORK_MANAGER_CONF_OPTS += \
	-Dsystemd_journal=true \
	-Dconfig_logging_backend_default=journal \
	-Dsession_tracking=systemd \
	-Dsuspend_resume=systemd
else
NETWORK_MANAGER_CONF_OPTS += \
	-Dsystemd_journal=false \
	-Dconfig_logging_backend_default=syslog \
	-Dsession_tracking=no \
	-Dsuspend_resume=consolekit \
	-Dsystemdsystemunitdir=no
endif

ifeq ($(BR2_PACKAGE_POLKIT),y)
NETWORK_MANAGER_DEPENDENCIES += polkit
NETWORK_MANAGER_CONF_OPTS += -Dpolkit=true
else
NETWORK_MANAGER_CONF_OPTS += -Dpolkit=false
endif

ifeq ($(BR2_PACKAGE_NETWORK_MANAGER_CLI),y)
NETWORK_MANAGER_DEPENDENCIES += readline
NETWORK_MANAGER_CONF_OPTS += -Dnmcli=true
else
NETWORK_MANAGER_CONF_OPTS += -Dnmcli=false
endif

define NETWORK_MANAGER_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/network-manager/S45NetworkManager $(TARGET_DIR)/etc/init.d/S45NetworkManager
endef

define NETWORK_MANAGER_INSTALL_INIT_SYSTEMD
	ln -sf /usr/lib/systemd/system/NetworkManager.service \
		$(TARGET_DIR)/etc/systemd/system/dbus-org.freedesktop.NetworkManager.service

endef

$(eval $(meson-package))

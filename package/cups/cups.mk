################################################################################
#
# cups
#
################################################################################

CUPS_VERSION = 2.4.7
CUPS_SOURCE = cups-$(CUPS_VERSION)-source.tar.gz
CUPS_SITE = https://github.com/OpenPrinting/cups/releases/download/v$(CUPS_VERSION)
CUPS_LICENSE = Apache-2.0 with GPL-2.0/LGPL-2.0 exception
CUPS_LICENSE_FILES = LICENSE NOTICE
CUPS_CPE_ID_VENDOR = openprinting
CUPS_SELINUX_MODULES = cups
CUPS_INSTALL_STAGING = YES

# Using autoconf, not autoheader, so we cannot use AUTORECONF = YES.
define CUPS_RUN_AUTOCONF
	cd $(@D); $(AUTOCONF) -f
endef
CUPS_PRE_CONFIGURE_HOOKS += CUPS_RUN_AUTOCONF

CUPS_CONF_OPTS = \
	--with-docdir=/usr/share/cups/doc-root \
	--disable-gssapi \
	--disable-pam \
	--libdir=/usr/lib \
	--with-cups-user=lp \
	--with-cups-group=lp \
	--with-system-groups="lpadmin sys root" \
	--disable-libpaper \
	--without-rcdir
CUPS_CONFIG_SCRIPTS = cups-config
CUPS_DEPENDENCIES = \
	host-autoconf \
	host-pkgconf \
	$(if $(BR2_PACKAGE_ZLIB),zlib)

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
CUPS_CONF_OPTS += --with-systemd=/usr/lib/systemd/system \
	--with-ondemand=systemd
CUPS_DEPENDENCIES += systemd
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
CUPS_CONF_OPTS += --enable-dbus
CUPS_DEPENDENCIES += dbus
else
CUPS_CONF_OPTS += --disable-dbus
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
CUPS_CONF_OPTS += --with-tls=gnutls
CUPS_DEPENDENCIES += gnutls
else ifeq ($(BR2_PACKAGE_OPENSSL),y)
CUPS_CONF_OPTS += --with-tls=openssl
CUPS_DEPENDENCIES += openssl
else
CUPS_CONF_OPTS += --with-tls=no
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
CUPS_CONF_OPTS += --enable-libusb
CUPS_DEPENDENCIES += libusb
else
CUPS_CONF_OPTS += --disable-libusb
endif

ifeq ($(BR2_PACKAGE_AVAHI_LIBAVAHI_CLIENT),y)
CUPS_DEPENDENCIES += avahi
CUPS_CONF_OPTS += --with-dnssd=avahi
else
CUPS_CONF_OPTS += --with-dnssd=no
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
define CUPS_INSTALL_UDEV_RULES
	$(INSTALL) -D -m 0644 package/cups/70-usb-printers.rules \
		$(TARGET_DIR)/lib/udev/rules.d/70-usb-printers.rules
endef

CUPS_POST_INSTALL_TARGET_HOOKS += CUPS_INSTALL_UDEV_RULES
endif

define CUPS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/cups/S81cupsd \
		$(TARGET_DIR)/etc/init.d/S81cupsd
endef

# lp user is needed to run cups spooler
# lpadmin group membership grants administrative privileges
define CUPS_USERS
	lp -1 lp -1 * /var/spool/lpd /bin/false - lp
	- - lpadmin -1 * - - - Printers admin group.
endef

$(eval $(autotools-package))

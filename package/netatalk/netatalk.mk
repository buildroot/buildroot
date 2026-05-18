################################################################################
#
# netatalk
#
################################################################################

NETATALK_VERSION = 4.4.3
NETATALK_SITE = https://downloads.sourceforge.net/project/netatalk/netatalk-$(subst .,-,$(NETATALK_VERSION))
NETATALK_SOURCE = netatalk-$(NETATALK_VERSION).tar.xz
NETATALK_CONFIG_SCRIPTS = netatalk-config
NETATALK_DEPENDENCIES = \
	host-pkgconf \
	berkeleydb \
	iniparser \
	libevent \
	libgcrypt \
	libgpg-error \
	openssl
NETATALK_LICENSE = GPL-2.0+, LGPL-3.0+, MIT-like
NETATALK_LICENSE_FILES = COPYING COPYRIGHT
NETATALK_CPE_ID_VENDOR = netatalk

NETATALK_CONF_OPTS += \
	-Dwith-init-style=none \
	-Dwith-afpstats=false \
	-Dwith-cnid-backends=dbd \
	-Dwith-bdb-path=$(STAGING_DIR)/usr \
	-Dwith-libgcrypt-path=$(STAGING_DIR)/usr \
	-Dwith-shell-check=false \
	-Dwith-gssapi=false \
	-Dwith-kerberos=false \
	-Dwith-krbV-uam=false \
	-Dwith-pam=false \
	-Dwith-quota=false \
	-Dwith-dtrace=false \
	-Dwith-spotlight=false \
	-Dwith-docs="" \
	-Dwith-tcp-wrappers=false

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
NETATALK_CONF_OPTS += -Dwith-libiconv=false
else
NETATALK_CONF_OPTS += -Dwith-libiconv=true
endif

ifeq ($(BR2_PACKAGE_ACL),y)
NETATALK_DEPENDENCIES += acl
NETATALK_CONF_OPTS += -Dwith-acls=true
else
NETATALK_CONF_OPTS += -Dwith-acls=false
endif

ifeq ($(BR2_PACKAGE_AVAHI_DAEMON)$(BR2_PACKAGE_DBUS),yy)
NETATALK_DEPENDENCIES += avahi
NETATALK_CONF_OPTS += -Dwith-zeroconf=true
else
NETATALK_CONF_OPTS += -Dwith-zeroconf=false
endif

ifeq ($(BR2_PACKAGE_CRACKLIB),y)
NETATALK_DEPENDENCIES += cracklib
NETATALK_CONF_OPTS += -Dwith-cracklib=true
else
NETATALK_CONF_OPTS += -Dwith-cracklib=false
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
NETATALK_DEPENDENCIES += cups
NETATALK_CONF_OPTS += -Dwith-appletalk=true -Dwith-cups=true
NETATALK_MESON_EXTRA_BINARIES += cups-config='$(STAGING_DIR)/usr/bin/cups-config'
else
NETATALK_CONF_OPTS += -Dwith-appletalk=false -Dwith-cups=false
endif

ifeq ($(BR2_PACKAGE_OPENLDAP),y)
NETATALK_DEPENDENCIES += openldap
NETATALK_CONF_OPTS += -Dwith-ldap=true
else
NETATALK_CONF_OPTS += -Dwith-ldap=false
endif

define NETATALK_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/netatalk/S50netatalk \
		$(TARGET_DIR)/etc/init.d/S50netatalk
endef

$(eval $(meson-package))

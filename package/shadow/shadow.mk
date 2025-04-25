################################################################################
#
# shadow
#
################################################################################

SHADOW_VERSION = 4.17.4
SHADOW_SITE = https://github.com/shadow-maint/shadow/releases/download/$(SHADOW_VERSION)
SHADOW_SOURCE = shadow-$(SHADOW_VERSION).tar.xz
SHADOW_LICENSE = BSD-3-Clause
SHADOW_LICENSE_FILES = COPYING
SHADOW_CPE_ID_VENDOR = debian
SHADOW_DEPENDENCIES = $(TARGET_NLS_DEPENDENCIES)
SHADOW_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)

SHADOW_CONF_OPTS = \
	--disable-man \
	--without-btrfs \
	--without-nscd \
	--without-skey \
	--without-sssd \
	--without-su \
	--without-tcb

ifeq ($(BR2_PACKAGE_SHADOW_SHADOWGRP),y)
SHADOW_CONF_OPTS += --enable-shadowgrp
else
SHADOW_CONF_OPTS += --disable-shadowgrp
endif

ifeq ($(BR2_PACKAGE_SHADOW_ACCOUNT_TOOLS_SETUID),y)
SHADOW_CONF_OPTS += --enable-account-tools-setuid
define SHADOW_ACCOUNT_TOOLS_SETUID_PERMISSIONS
	/usr/sbin/chgpasswd f 4755 0 0 - - - - -
	/usr/sbin/chpasswd f 4755 0 0 - - - - -
	/usr/sbin/groupadd f 4755 0 0 - - - - -
	/usr/sbin/groupdel f 4755 0 0 - - - - -
	/usr/sbin/groupmod f 4755 0 0 - - - - -
	/usr/sbin/newusers f 4755 0 0 - - - - -
	/usr/sbin/useradd f 4755 0 0 - - - - -
	/usr/sbin/userdel f 4755 0 0 - - - - -
	/usr/sbin/usermod f 4755 0 0 - - - - -
endef
else
SHADOW_CONF_OPTS += --disable-account-tools-setuid
endif

ifeq ($(BR2_PACKAGE_SHADOW_SUBORDINATE_IDS),y)
SHADOW_INSTALL_STAGING = YES
SHADOW_CONF_OPTS += --enable-subordinate-ids
define SHADOW_SUBORDINATE_IDS_PERMISSIONS
	/usr/bin/newuidmap f 4755 0 0 - - - - -
	/usr/bin/newgidmap f 4755 0 0 - - - - -
endef
else
SHADOW_CONF_OPTS += --disable-subordinate-ids
endif

ifeq ($(BR2_PACKAGE_ACL),y)
SHADOW_CONF_OPTS += --with-acl
SHADOW_DEPENDENCIES += acl
else
SHADOW_CONF_OPTS += --without-acl
endif

ifeq ($(BR2_PACKAGE_ATTR),y)
SHADOW_CONF_OPTS += --with-attr
SHADOW_DEPENDENCIES += attr
else
SHADOW_CONF_OPTS += --without-attr
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
SHADOW_CONF_OPTS += --with-audit
SHADOW_DEPENDENCIES += audit
else
SHADOW_CONF_OPTS += --without-audit
endif

ifeq ($(BR2_PACKAGE_CRACKLIB),y)
SHADOW_CONF_OPTS += --with-libcrack
SHADOW_DEPENDENCIES += cracklib
else
SHADOW_CONF_OPTS += --without-libcrack
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX)$(BR2_PACKAGE_LIBSEMANAGE),yy)
SHADOW_CONF_OPTS += --with-selinux
SHADOW_DEPENDENCIES += libselinux libsemanage
else
SHADOW_CONF_OPTS += --without-selinux
endif

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
SHADOW_DEPENDENCIES += libxcrypt
endif

# linux-pam is also used without account-tools-setuid enabled
ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
SHADOW_CONF_OPTS += --with-libpam
SHADOW_DEPENDENCIES += linux-pam
else
SHADOW_CONF_OPTS += --without-libpam
endif

ifeq ($(BR2_PACKAGE_SHADOW_SHA_CRYPT),y)
SHADOW_CONF_OPTS += --with-sha-crypt
else
SHADOW_CONF_OPTS += --without-sha-crypt
endif

ifeq ($(BR2_PACKAGE_SHADOW_BCRYPT),y)
SHADOW_CONF_OPTS += --with-bcrypt
else
SHADOW_CONF_OPTS += --without-bcrypt
endif

ifeq ($(BR2_PACKAGE_SHADOW_YESCRYPT),y)
SHADOW_CONF_OPTS += --with-yescrypt
else
SHADOW_CONF_OPTS += --without-yescrypt
endif

ifeq ($(BR2_PACKAGE_LIBBSD),y)
SHADOW_CONF_OPTS += --with-libbsd
SHADOW_DEPENDENCIES += libbsd
else
SHADOW_CONF_OPTS += --without-libbsd
endif

define SHADOW_PERMISSIONS
	/usr/bin/chage f 4755 0 0 - - - - -
	/usr/bin/chfn f 4755 0 0 - - - - -
	/usr/bin/chsh f 4755 0 0 - - - - -
	/usr/bin/expiry f 4755 0 0 - - - - -
	/usr/bin/gpasswd f 4755 0 0 - - - - -
	/usr/bin/newgrp f 4755 0 0 - - - - -
	/usr/bin/passwd f 4755 0 0 - - - - -
	$(SHADOW_ACCOUNT_TOOLS_SETUID_PERMISSIONS)
	$(SHADOW_SUBORDINATE_IDS_PERMISSIONS)
endef

$(eval $(autotools-package))

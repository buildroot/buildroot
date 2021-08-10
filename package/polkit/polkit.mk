################################################################################
#
# polkit
#
################################################################################

POLKIT_VERSION = 0.119
POLKIT_SITE = $(call github,aduskett,polkit-duktape,v$(POLKIT_VERSION))
POLKIT_LICENSE = GPL-2.0
POLKIT_LICENSE_FILES = COPYING
POLKIT_CPE_ID_VENDOR = polkit_project
POLKIT_AUTORECONF = YES
POLKIT_INSTALL_STAGING = YES

POLKIT_DEPENDENCIES = \
	duktape libglib2 host-intltool expat $(TARGET_NLS_DEPENDENCIES)

POLKIT_CONF_ENV = \
	CXXFLAGS="$(TARGET_CXXFLAGS)" \
	LIBS=$(TARGET_NLS_LIBS)

POLKIT_CONF_OPTS = \
	--with-os-type=unknown \
	--disable-man-pages \
	--disable-examples \
	--disable-libelogind \
	--disable-libsystemd-login \
	--with-duktape

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
POLKIT_CONF_OPTS += --enable-introspection
POLKIT_DEPENDENCIES += gobject-introspection
else
POLKIT_CONF_OPTS += --disable-introspection
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
POLKIT_DEPENDENCIES += linux-pam
POLKIT_CONF_OPTS += --with-authfw=pam
else
POLKIT_CONF_OPTS += --with-authfw=shadow
endif

# polkit.its is needed for gvfs and must be installed in $(HOST_DIR)
# and not $(STAGING_DIR)
define POLKIT_INSTALL_ITS
	$(INSTALL) -D -m 644 $(@D)/data/polkit.its \
		$(HOST_DIR)/share/gettext/its
endef
POLKIT_POST_INSTALL_TARGET_HOOKS += POLKIT_INSTALL_ITS

define POLKIT_USERS
	polkitd -1 polkitd -1 * - - - Polkit Daemon
endef

define POLKIT_PERMISSIONS
	/etc/polkit-1 r 750 root polkitd - - - - -
	/usr/share/polkit-1 r 750 root polkitd - - - - -
	/usr/bin/pkexec f 4755 root root - - - - -
endef

define POLKIT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(POLKIT_PKGDIR)/polkit.service \
		$(TARGET_DIR)/usr/lib/systemd/system/polkit.service

endef

define POLKIT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/polkit/S50polkit \
		$(TARGET_DIR)/etc/init.d/S50polkit
endef

$(eval $(autotools-package))

################################################################################
#
# thermald
#
################################################################################

THERMALD_VERSION = 2.4.8
THERMALD_SITE = $(call github,intel,thermal_daemon,v$(THERMALD_VERSION))
# fetched from Github, with no configure script
THERMALD_AUTORECONF = YES
THERMALD_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive
THERMALD_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-autoconf-archive \
	dbus \
	dbus-glib \
	libevdev \
	libxml2 \
	upower \
	xz
# tools are GPL-3.0+ but are not added to the target
THERMALD_LICENSE = GPL-2.0+
THERMALD_LICENSE_FILES = COPYING
THERMALD_CPE_ID_VENDOR = intel
THERMALD_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)

# avoid this error when reconfiguring:
# automake: error: cannot open < gtk-doc.make: No such file or directory
define THERMALD_GTK_DOC_HOOK
	echo "CLEANFILES=" > $(@D)/gtk-doc.make
endef
THERMALD_PRE_CONFIGURE_HOOKS += THERMALD_GTK_DOC_HOOK

# Autoreconf is missing the m4/ directory, which might actually be missing
# iff it was the first argument, but unfortunately we are overriding the
# first include directory above. Thus we need that hook here.
define THERMALD_CREATE_M4
	mkdir -p $(@D)/m4
endef
THERMALD_POST_PATCH_HOOKS += THERMALD_CREATE_M4

ifeq ($(BR2_INIT_SYSTEMD),y)
THERMALD_DEPENDENCIES += systemd
THERMALD_CONF_OPTS += --with-systemdsystemunitdir=/usr/lib/systemd/system
endif

$(eval $(autotools-package))

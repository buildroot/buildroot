################################################################################
#
# neard
#
################################################################################

NEARD_VERSION = 0.19
NEARD_SITE = https://git.kernel.org/pub/scm/network/nfc/neard.git/snapshot
NEARD_LICENSE = GPL-2.0
NEARD_LICENSE_FILES = COPYING

NEARD_DEPENDENCIES = host-autoconf-archive host-pkgconf dbus libglib2 libnl
# From git
NEARD_AUTORECONF = YES
NEARD_AUTORECONF_OPTS = --include=$(HOST_DIR)/share/autoconf-archive
NEARD_CONF_OPTS = --disable-traces

# Autoreconf is missing the m4/ directory, which might actually be missing
# iff it was the first argument, but unfortunately we are overriding the
# first include directory above. Thus we need that hook here.
define NEARD_CREATE_M4
	mkdir -p $(@D)/m4
endef
NEARD_POST_PATCH_HOOKS += NEARD_CREATE_M4

ifeq ($(BR2_PACKAGE_NEARD_TOOLS),y)
NEARD_CONF_OPTS += --enable-tools
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
NEARD_CONF_OPTS += --enable-systemd
NEARD_DEPENDENCIES += systemd
else
NEARD_CONF_OPTS += --disable-systemd
endif

define NEARD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/neard/S53neard \
		$(TARGET_DIR)/etc/init.d/S53neard
endef

$(eval $(autotools-package))

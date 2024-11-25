################################################################################
#
# restorecond
#
################################################################################

RESTORECOND_VERSION = 3.7
RESTORECOND_SITE = https://github.com/SELinuxProject/selinux/releases/download/$(RESTORECOND_VERSION)
RESTORECOND_LICENSE = GPL-2.0
RESTORECOND_LICENSE_FILES = LICENSE

RESTORECOND_DEPENDENCIES = libglib2 libsepol libselinux dbus-glib

RESTORECOND_MAKE_OPTS += \
	$(TARGET_CONFIGURE_OPTS) \
	ARCH="$(BR2_ARCH)"

# We need to pass DESTDIR at build time because it's used by
# restorecond build system to find headers and libraries.
define RESTORECOND_BUILD_CMDS
	$(MAKE) -C $(@D) $(RESTORECOND_MAKE_OPTS) DESTDIR=$(STAGING_DIR) all
endef

define RESTORECOND_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/restorecond/S02restorecond \
		$(TARGET_DIR)/etc/init.d/S02restorecond
endef

define RESTORECOND_INSTALL_INIT_SYSTEMD
	$(INSTALL) -m 0644 -D $(@D)/restorecond.service \
		$(TARGET_DIR)/usr/lib/systemd/system/restorecond.service

	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	ln -fs ../../../../usr/lib/systemd/system/restorecond.service \
		$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/restorecond.service

	$(INSTALL) -m 0600 -D $(@D)/org.selinux.Restorecond.service \
		$(TARGET_DIR)/etc/systemd/system/org.selinux.Restorecond.service
endef

define RESTORECOND_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/restorecond.conf $(TARGET_DIR)/etc/selinux/restorecond.conf
	$(INSTALL) -m 0644 -D $(@D)/restorecond_user.conf $(TARGET_DIR)/etc/selinux/restorecond_user.conf
	$(INSTALL) -m 0755 -D $(@D)/restorecond $(TARGET_DIR)/usr/sbin/restorecond
endef

$(eval $(generic-package))

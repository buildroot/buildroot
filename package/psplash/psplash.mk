################################################################################
#
# psplash
#
################################################################################

PSPLASH_VERSION = 53ae74a36bf17675228552abb927d2f981940a6a
PSPLASH_SITE = https://git.yoctoproject.org/psplash
PSPLASH_SITE_METHOD = git
PSPLASH_LICENSE = GPL-2.0+
PSPLASH_LICENSE_FILES = COPYING
PSPLASH_AUTORECONF = YES
PSPLASH_DEPENDENCIES = host-gdk-pixbuf host-pkgconf

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PSPLASH_DEPENDENCIES += systemd
PSPLASH_CONF_OPTS += --with-systemd
else
PSPLASH_CONF_OPTS += --without-systemd
endif

ifeq ($(BR2_PACKAGE_PSPLASH_PROGRESS_BAR),y)
PSPLASH_CONF_OPTS += --enable-progress-bar
else
PSPLASH_CONF_OPTS += --disable-progress-bar
endif

ifeq ($(BR2_PACKAGE_PSPLASH_STARTUP_MSG),y)
PSPLASH_CONF_OPTS += --enable-startup-msg
else
PSPLASH_CONF_OPTS += --disable-startup-msg
endif

ifeq ($(BR2_PACKAGE_PSPLASH_FULL_SCREEN),y)
PSPLASH_CONF_OPTS += --enable-img-fullscreen
else
PSPLASH_CONF_OPTS += --disable-img-fullscreen
endif

PSPLASH_IMAGE = $(call qstrip,$(BR2_PACKAGE_PSPLASH_IMAGE))

ifneq ($(PSPLASH_IMAGE),)
define PSPLASH_COPY_IMAGE
	cp $(PSPLASH_IMAGE) $(@D)/base-images/psplash-poky.png
endef

PSPLASH_POST_EXTRACT_HOOKS += PSPLASH_COPY_IMAGE
endif

define PSPLASH_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/psplash/psplash-start.service \
		$(TARGET_DIR)/usr/lib/systemd/system/psplash-start.service

	$(INSTALL) -D -m 644 package/psplash/psplash-systemd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/psplash-systemd.service
endef

$(eval $(autotools-package))

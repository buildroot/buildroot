################################################################################
#
# rauc-hawkbit-updater
#
################################################################################

RAUC_HAWKBIT_UPDATER_VERSION = 1.3
RAUC_HAWKBIT_UPDATER_SITE = https://github.com/rauc/rauc-hawkbit-updater/releases/download/v$(RAUC_HAWKBIT_UPDATER_VERSION)
RAUC_HAWKBIT_UPDATER_SOURCE = rauc-hawkbit-updater-$(RAUC_HAWKBIT_UPDATER_VERSION).tar.xz
RAUC_HAWKBIT_UPDATER_LICENSE = LGPL-2.1
RAUC_HAWKBIT_UPDATER_LICENSE_FILES = LICENSE
RAUC_HAWKBIT_UPDATER_DEPENDENCIES = json-glib libcurl
RAUC_HAWKBIT_UPDATER_CFLAGS = $(TARGET_CFLAGS) -std=c99

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
RAUC_HAWKBIT_UPDATER_DEPENDENCIES += systemd
RAUC_HAWKBIT_UPDATER_CONF_OPTS += -Dsystemd=enabled
else
RAUC_HAWKBIT_UPDATER_CONF_OPTS += -Dsystemd=disabled
endif

$(eval $(meson-package))

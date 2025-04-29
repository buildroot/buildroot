################################################################################
#
# rauc
#
################################################################################

RAUC_VERSION = 1.14
RAUC_SITE = https://github.com/rauc/rauc/releases/download/v$(RAUC_VERSION)
RAUC_SOURCE = rauc-$(RAUC_VERSION).tar.xz
RAUC_LICENSE = LGPL-2.1
RAUC_LICENSE_FILES = COPYING
RAUC_CPE_ID_VENDOR = pengutronix
RAUC_DEPENDENCIES = host-pkgconf openssl libglib2
RAUC_CONF_OPTS += -Dtests=false

ifeq ($(BR2_PACKAGE_RAUC_DBUS),y)
RAUC_CONF_OPTS += -Dservice=true
RAUC_DEPENDENCIES += dbus

# systemd service uses dbus interface
ifeq ($(BR2_PACKAGE_SYSTEMD),y)
# configure uses pkg-config --variable=systemdsystemunitdir systemd
RAUC_DEPENDENCIES += systemd
define RAUC_INSTALL_INIT_SYSTEMD
	mkdir -p $(TARGET_DIR)/usr/lib/systemd/system/rauc.service.d
	printf '[Install]\nWantedBy=multi-user.target\n' \
		>$(TARGET_DIR)/usr/lib/systemd/system/rauc.service.d/buildroot-enable.conf
endef
endif

else
RAUC_CONF_OPTS += -Dservice=false
endif

ifeq ($(BR2_PACKAGE_RAUC_GPT),y)
RAUC_CONF_OPTS += -Dgpt=enabled
RAUC_DEPENDENCIES += util-linux-libs
else
RAUC_CONF_OPTS += -Dgpt=disabled
endif

ifeq ($(BR2_PACKAGE_RAUC_NETWORK),y)
RAUC_CONF_OPTS += -Dnetwork=true
RAUC_DEPENDENCIES += libcurl
else
RAUC_CONF_OPTS += -Dnetwork=false
endif

ifeq ($(BR2_PACKAGE_RAUC_JSON),y)
RAUC_CONF_OPTS += -Djson=enabled
RAUC_DEPENDENCIES += json-glib
else
RAUC_CONF_OPTS += -Djson=disabled
endif

ifeq ($(BR2_PACKAGE_RAUC_STREAMING),y)
RAUC_CONF_OPTS += -Dstreaming=true
RAUC_DEPENDENCIES += libnl
else
RAUC_CONF_OPTS += -Dstreaming=false
endif

HOST_RAUC_DEPENDENCIES = \
	host-json-glib \
	host-pkgconf \
	host-openssl \
	host-libglib2 \
	host-squashfs \
	$(if $(BR2_PACKAGE_HOST_LIBP11),host-libp11)

HOST_RAUC_CONF_OPTS += \
	-Djson=enabled \
	-Dnetwork=false \
	-Dstreaming=false \
	-Dservice=false \
	-Dtests=false

$(eval $(meson-package))
$(eval $(host-meson-package))

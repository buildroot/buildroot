################################################################################
#
# rygel
#
################################################################################

RYGEL_VERSION_MAJOR = 0.40
RYGEL_VERSION = $(RYGEL_VERSION_MAJOR).2
RYGEL_SOURCE = rygel-$(RYGEL_VERSION).tar.xz
RYGEL_SITE = https://download.gnome.org/sources/rygel/$(RYGEL_VERSION_MAJOR)
RYGEL_LICENSE = LGPL-2.1+, CC-BY-SA-3.0 (logo)
RYGEL_LICENSE_FILES = COPYING COPYING.logo
RYGEL_DEPENDENCIES = \
	gdk-pixbuf \
	gobject-introspection \
	gupnp-av \
	gupnp-dlna \
	libgee \
	libmediaart \
	sqlite \
	$(TARGET_NLS_DEPENDENCIES)
RYGEL_INSTALL_STAGING = YES

RYGEL_CONF_ENV = LIBS=$(TARGET_NLS_LIBS)
RYGEL_CONF_OPTS += \
	-Dapi-docs=false \
	-Dexamples=false \
	-Dintrospection=enabled \
	-Dman_pages=false \
	-Dtests=false
RYGEL_PLUGINS = external,lms,mpris,ruih

ifeq ($(BR2_PACKAGE_RYGEL_MEDIA_ENGINE_GSTREAMER1),y)
RYGEL_CONF_OPTS += \
	-Dengines=gstreamer \
	-Dgstreamer=enabled
RYGEL_PLUGINS += ,playbin,media-export,gst-launch
RYGEL_DEPENDENCIES += \
	gst1-plugins-base \
	gstreamer1 \
	gstreamer1-editing-services
else ifeq ($(BR2_PACKAGE_RYGEL_MEDIA_ENGINE_SIMPLE),y)
RYGEL_CONF_OPTS += \
	-Dengines=simple \
	-Dgstreamer=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
RYGEL_CONF_OPTS += -Dgtk=enabled
RYGEL_DEPENDENCIES += libgtk3
else
RYGEL_CONF_OPTS += -Dgtk=disabled
endif

RYGEL_CONF_OPTS += -Dplugins="$(RYGEL_PLUGINS)"

define RYGEL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/rygel/S99rygel \
		$(TARGET_DIR)/etc/init.d/S99rygel
endef

define RYGEL_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 package/rygel/rygel.service \
		$(TARGET_DIR)/usr/lib/systemd/system/rygel.service
endef

$(eval $(meson-package))

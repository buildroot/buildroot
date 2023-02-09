################################################################################
#
# pipewire-media-session
#
################################################################################

PIPEWIRE_MEDIA_SESSION_VERSION = 0.4.2
PIPEWIRE_MEDIA_SESSION_SOURCE = media-session-$(PIPEWIRE_MEDIA_SESSION_VERSION).tar.bz2
PIPEWIRE_MEDIA_SESSION_SITE = https://gitlab.freedesktop.org/pipewire/media-session/-/archive/$(PIPEWIRE_MEDIA_SESSION_VERSION)
PIPEWIRE_MEDIA_SESSION_LICENSE = MIT
PIPEWIRE_MEDIA_SESSION_LICENSE_FILES = COPYING LICENSE
PIPEWIRE_MEDIA_SESSION_INSTALL_STAGING = YES
PIPEWIRE_MEDIA_SESSION_DEPENDENCIES = \
	host-pkgconf \
	alsa-lib \
	dbus \
	pipewire \
	$(TARGET_NLS_DEPENDENCIES)

PIPEWIRE_MEDIA_SESSION_CONF_OPTS = \
	-Ddocs=disabled \
	-Dtests=disabled \
	-Dinstalled_tests=disabled

PIPEWIRE_MEDIA_SESSION_MODULE_SETS_LIST = alsa

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PIPEWIRE_MEDIA_SESSION_DEPENDENCIES += systemd
PIPEWIRE_MEDIA_SESSION_CONF_OPTS += \
	-Dsystemd=enabled \
	-Dsystemd-system-service=enabled \
	-Dsystemd-user-service=enabled
else
PIPEWIRE_MEDIA_SESSION_CONF_OPTS += \
	-Dsystemd=disabled \
	-Dsystemd-system-service=disabled \
	-Dsystemd-user-service=disabled
endif

ifeq ($(BR2_PACKAGE_JACK2),y)
PIPEWIRE_MEDIA_SESSION_DEPENDENCIES += jack2
PIPEWIRE_MEDIA_SESSION_MODULE_SETS_LIST += jack
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
PIPEWIRE_MEDIA_SESSION_DEPENDENCIES += pulseaudio
PIPEWIRE_MEDIA_SESSION_MODULE_SETS_LIST += pulseaudio
endif

PIPEWIRE_MEDIA_SESSION_CONF_OPTS += -Dwith-module-sets='$(subst $(space),$(comma),$(PIPEWIRE_MEDIA_SESSION_MODULE_SETS_LIST))'

$(eval $(meson-package))

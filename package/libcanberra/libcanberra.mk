################################################################################
#
# libcanberra
#
################################################################################

LIBCANBERRA_VERSION = 0.30
LIBCANBERRA_SOURCE = libcanberra-$(LIBCANBERRA_VERSION).tar.xz
LIBCANBERRA_SITE = http://0pointer.de/lennart/projects/libcanberra
LIBCANBERRA_LICENSE = LGPL-2.1+
LIBCANBERRA_LICENSE_FILES = LGPL
LIBCANBERRA_INSTALL_STAGING = YES

LIBCANBERRA_DEPENDENCIES = host-pkgconf libtool libvorbis
LIBCANBERRA_CONF_OPTS = --disable-oss --disable-null --disable-tdb --disable-lynx

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
LIBCANBERRA_CONF_OPTS += --enable-udev
LIBCANBERRA_DEPENDENCIES += udev
else
LIBCANBERRA_CONF_OPTS += --disable-udev
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBCANBERRA_CONF_OPTS += --enable-alsa
LIBCANBERRA_DEPENDENCIES += alsa-lib
else
LIBCANBERRA_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
LIBCANBERRA_CONF_OPTS += --enable-pulse
LIBCANBERRA_DEPENDENCIES += pulseaudio
else
LIBCANBERRA_CONF_OPTS += --disable-pulse
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
LIBCANBERRA_CONF_OPTS += --enable-gstreamer
LIBCANBERRA_DEPENDENCIES += gstreamer1
else
LIBCANBERRA_CONF_OPTS += --disable-gstreamer
endif

ifeq ($(BR2_PACKAGE_LIBGTK2),y)
LIBCANBERRA_CONF_OPTS += --enable-gtk
LIBCANBERRA_DEPENDENCIES += libgtk2
else
LIBCANBERRA_CONF_OPTS += --disable-gtk
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
LIBCANBERRA_CONF_OPTS += --enable-gtk3
LIBCANBERRA_DEPENDENCIES += libgtk3
else
LIBCANBERRA_CONF_OPTS += --disable-gtk3
endif

$(eval $(autotools-package))

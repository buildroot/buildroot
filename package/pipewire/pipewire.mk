################################################################################
#
# pipewire
#
################################################################################

PIPEWIRE_VERSION = 0.3.35
PIPEWIRE_SOURCE = pipewire-$(PIPEWIRE_VERSION).tar.bz2
PIPEWIRE_SITE = https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/$(PIPEWIRE_VERSION)
PIPEWIRE_LICENSE = MIT, LGPL-2.1+ (libspa-alsa), GPL-2.0 (libjackserver)
PIPEWIRE_LICENSE_FILES = COPYING LICENSE
PIPEWIRE_INSTALL_STAGING = YES
PIPEWIRE_DEPENDENCIES = host-pkgconf dbus $(TARGET_NLS_DEPENDENCIES)

PIPEWIRE_CONF_OPTS += \
	-Ddocs=disabled \
	-Dman=disabled \
	-Dtests=disabled \
	-Dspa-plugins=enabled \
	-Daudiomixer=enabled \
	-Daudioconvert=enabled \
	-Dcontrol=enabled \
	-Daudiotestsrc=enabled \
	-Dsupport=enabled \
	-Devl=disabled \
	-Dtest=disabled \
	-Dvideoconvert=enabled \
	-Dvideotestsrc=enabled \
	-Dvolume=enabled

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
PIPEWIRE_CONF_OPTS += -Dudev=enabled
PIPEWIRE_DEPENDENCIES += udev
else
PIPEWIRE_CONF_OPTS += -Dudev=disabled
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE_EXAMPLES),y)
PIPEWIRE_CONF_OPTS += -Dexamples=enabled
else
PIPEWIRE_CONF_OPTS += -Dexamples=disabled
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE_GSTREAMER),y)
PIPEWIRE_CONF_OPTS += -Dgstreamer=enabled
PIPEWIRE_DEPENDENCIES += libglib2 gstreamer1 gst1-plugins-base
else
PIPEWIRE_CONF_OPTS += -Dgstreamer=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
PIPEWIRE_CONF_OPTS += -Dsystemd=enabled
PIPEWIRE_DEPENDENCIES += systemd
else
PIPEWIRE_CONF_OPTS += -Dsystemd=disabled
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
PIPEWIRE_CONF_OPTS += -Dpipewire-alsa=enabled
PIPEWIRE_DEPENDENCIES += alsa-lib
ifeq ($(BR2_PACKAGE_ALSA_LIB_SEQ)$(BR2_PACKAGE_ALSA_LIB_UCM)$(BR2_PACKAGE_HAS_UDEV),yyy)
PIPEWIRE_CONF_OPTS += -Dalsa=enabled
else
PIPEWIRE_CONF_OPTS += -Dalsa=disabled
endif
else
PIPEWIRE_CONF_OPTS += -Dalsa=disabled -Dpipewire-alsa=disabled
endif

ifeq ($(BR2_PACKAGE_AVAHI),y)
PIPEWIRE_CONF_OPTS += -Davahi=enabled
PIPEWIRE_DEPENDENCIES += avahi
else
PIPEWIRE_CONF_OPTS += -Davahi=disabled
endif

ifeq ($(BR2_PACKAGE_JACK2),y)
PIPEWIRE_CONF_OPTS += -Dpipewire-jack=enabled -Djack=enabled
PIPEWIRE_DEPENDENCIES += jack2
else
PIPEWIRE_CONF_OPTS += -Dpipewire-jack=disabled -Djack=disabled
endif

ifeq ($(BR2_PACKAGE_BLUEZ5_UTILS)$(BR2_PACKAGE_SBC),yy)
PIPEWIRE_CONF_OPTS += -Dbluez5=enabled
PIPEWIRE_DEPENDENCIES += bluez5_utils sbc
else
PIPEWIRE_CONF_OPTS += -Dbluez5=disabled
endif

ifeq ($(BR2_PACKAGE_FFMPEG),y)
PIPEWIRE_CONF_OPTS += -Dffmpeg=enabled
PIPEWIRE_DEPENDENCIES += ffmpeg
else
PIPEWIRE_CONF_OPTS += -Dffmpeg=disabled
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE_V4L2),y)
PIPEWIRE_CONF_OPTS += -Dv4l2=enabled
else
PIPEWIRE_CONF_OPTS += -Dv4l2=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCAMERA)$(BR2_PACKAGE_LIBDRM)$(BR2_PACKAGE_HAS_UDEV),yyy)
PIPEWIRE_CONF_OPTS += -Dlibcamera=enabled
PIPEWIRE_DEPENDENCIES += libcamera libdrm
else
PIPEWIRE_CONF_OPTS += -Dlibcamera=disabled
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
PIPEWIRE_CONF_OPTS += -Dlibusb=enabled
PIPEWIRE_DEPENDENCIES += libusb
else
PIPEWIRE_CONF_OPTS += -Dlibusb=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_VULKAN_DRIVER),y)
PIPEWIRE_CONF_OPTS += -Dvulkan=enabled
PIPEWIRE_DEPENDENCIES += mesa3d
else
PIPEWIRE_CONF_OPTS += -Dvulkan=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
PIPEWIRE_CONF_OPTS += -Dpw-cat=enabled -Dsndfile=enabled
PIPEWIRE_DEPENDENCIES += libsndfile
else
PIPEWIRE_CONF_OPTS += -Dpw-cat=disabled -Dsndfile=disabled
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
PIPEWIRE_CONF_OPTS += -Dlibpulse=enabled
PIPEWIRE_DEPENDENCIES += pulseaudio
else
PIPEWIRE_CONF_OPTS += -Dlibpulse=disabled
endif

ifeq ($(BR2_PACKAGE_SDL2),y)
PIPEWIRE_DEPENDENCIES += sdl2
PIPEWIRE_CONF_OPTS += -Dsdl2=enabled
else
PIPEWIRE_CONF_OPTS += -Dsdl2=disabled
endif

ifeq ($(WEBRTC_AUDIO_PROCESSING),y)
PIPEWIRE_CONF_OPTS += -Decho-cancel-webrtc=enabled
PIPEWIRE_DEPENDENCIES += webrtc-audio-processing
else
PIPEWIRE_CONF_OPTS += -Decho-cancel-webrtc=disabled
endif

$(eval $(meson-package))

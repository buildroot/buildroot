################################################################################
#
# pipewire
#
################################################################################

PIPEWIRE_VERSION = 0.3.74
PIPEWIRE_SOURCE = pipewire-$(PIPEWIRE_VERSION).tar.bz2
PIPEWIRE_SITE = https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/$(PIPEWIRE_VERSION)
PIPEWIRE_LICENSE = MIT, LGPL-2.1+ (libspa-alsa), GPL-2.0 (libjackserver)
PIPEWIRE_LICENSE_FILES = COPYING LICENSE
PIPEWIRE_INSTALL_STAGING = YES
PIPEWIRE_DEPENDENCIES = host-pkgconf $(TARGET_NLS_DEPENDENCIES)
PIPEWIRE_LDFLAGS = $(TARGET_NLS_LIBS)

PIPEWIRE_CONF_OPTS += \
	-Ddocs=disabled \
	-Dman=disabled \
	-Dtests=disabled \
	-Dspa-plugins=enabled \
	-Daudiomixer=enabled \
	-Daudioconvert=enabled \
	-Dbluez5-codec-lc3=disabled \
	-Dbluez5-codec-lc3plus=disabled \
	-Dcontrol=enabled \
	-Daudiotestsrc=enabled \
	-Dsupport=enabled \
	-Devl=disabled \
	-Dtest=disabled \
	-Dvideoconvert=enabled \
	-Dvideotestsrc=enabled \
	-Dvolume=enabled \
	-Dvulkan=disabled \
	-Dsession-managers=[] \
	-Dlegacy-rtkit=false \
	-Davb=disabled \
	-Dlibcanberra=disabled \
	-Dlibmysofa=disabled \
	-Dlibffado=disabled \
	-Dflatpak=disabled

ifeq ($(BR2_PACKAGE_DBUS),y)
PIPEWIRE_CONF_OPTS += -Ddbus=enabled
PIPEWIRE_DEPENDENCIES += dbus
else
PIPEWIRE_CONF_OPTS += -Ddbus=disabled
endif

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
PIPEWIRE_CONF_OPTS += \
	-Dsystemd=enabled \
	-Dsystemd-system-service=enabled \
	-Dsystemd-user-service=enabled
PIPEWIRE_DEPENDENCIES += systemd
else
PIPEWIRE_CONF_OPTS += \
	-Dsystemd=disabled \
	-Dsystemd-system-service=disabled \
	-Dsystemd-user-service=disabled
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
PIPEWIRE_CONF_OPTS += -Dpipewire-alsa=enabled
PIPEWIRE_DEPENDENCIES += alsa-lib
ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
PIPEWIRE_CONF_OPTS += -Dalsa=enabled
else
PIPEWIRE_CONF_OPTS += -Dalsa=disabled
endif
else
PIPEWIRE_CONF_OPTS += -Dalsa=disabled -Dpipewire-alsa=disabled
endif

ifeq ($(BR2_PACKAGE_AVAHI_LIBAVAHI_CLIENT),y)
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
ifeq ($(BR2_PACKAGE_MODEM_MANAGER),y)
PIPEWIRE_CONF_OPTS += -Dbluez5-backend-native-mm=enabled
PIPEWIRE_DEPENDENCIES += modem-manager
else
PIPEWIRE_CONF_OPTS += -Dbluez5-backend-native-mm=disabled
endif
ifeq ($(BR2_PACKAGE_OPUS),y)
PIPEWIRE_CONF_OPTS += -Dbluez5-codec-opus=enabled
PIPEWIRE_DEPENDENCIES += opus
else
PIPEWIRE_CONF_OPTS += -Dbluez5-codec-opus=disabled
endif
else
PIPEWIRE_CONF_OPTS += -Dbluez5=disabled -Dbluez5-codec-opus=disabled
endif

ifeq ($(BR2_PACKAGE_FFMPEG),y)
PIPEWIRE_CONF_OPTS += -Dffmpeg=enabled -Dpw-cat-ffmpeg=enabled
PIPEWIRE_DEPENDENCIES += ffmpeg
else
PIPEWIRE_CONF_OPTS += -Dffmpeg=disabled -Dpw-cat-ffmpeg=disabled
endif

ifeq ($(BR2_PACKAGE_NCURSES_WCHAR),y)
PIPEWIRE_DEPENDENCIES += ncurses
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE_V4L2),y)
PIPEWIRE_CONF_OPTS += -Dpipewire-v4l2=enabled -Dv4l2=enabled
else
PIPEWIRE_CONF_OPTS += -Dpipewire-v4l2=disabled -Dv4l2=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCAMERA)$(BR2_PACKAGE_LIBDRM)$(BR2_PACKAGE_HAS_UDEV),yyy)
PIPEWIRE_CONF_OPTS += -Dlibcamera=enabled
PIPEWIRE_DEPENDENCIES += libcamera libdrm
else
PIPEWIRE_CONF_OPTS += -Dlibcamera=disabled
endif

ifeq ($(BR2_PACKAGE_LILV),y)
PIPEWIRE_CONF_OPTS += -Dlv2=enabled
PIPEWIRE_DEPENDENCIES += lilv
else
PIPEWIRE_CONF_OPTS += -Dlv2=disabled
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
PIPEWIRE_CONF_OPTS += -Dx11=enabled
PIPEWIRE_DEPENDENCIES += xlib_libX11
else
PIPEWIRE_CONF_OPTS += -Dx11=disabled
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXFIXES),y)
PIPEWIRE_CONF_OPTS += -Dx11-xfixes=enabled
PIPEWIRE_DEPENDENCIES += xlib_libXfixes
else
PIPEWIRE_CONF_OPTS += -Dx11-xfixes=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
PIPEWIRE_CONF_OPTS += -Dgsettings=enabled
PIPEWIRE_DEPENDENCIES += libglib2
else
PIPEWIRE_CONF_OPTS += -Dgsettings=disabled
endif

ifeq ($(BR2_PACKAGE_LIBUSB),y)
PIPEWIRE_CONF_OPTS += -Dlibusb=enabled
PIPEWIRE_DEPENDENCIES += libusb
else
PIPEWIRE_CONF_OPTS += -Dlibusb=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
PIPEWIRE_CONF_OPTS += -Dpw-cat=enabled -Dsndfile=enabled
PIPEWIRE_DEPENDENCIES += libsndfile
else
PIPEWIRE_CONF_OPTS += -Dpw-cat=disabled -Dsndfile=disabled
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
PIPEWIRE_CONF_OPTS += -Dopus=enabled
PIPEWIRE_DEPENDENCIES += opus
else
PIPEWIRE_CONF_OPTS += -Dopus=disabled
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
PIPEWIRE_CONF_OPTS += -Dlibpulse=enabled
PIPEWIRE_DEPENDENCIES += pulseaudio
else
PIPEWIRE_CONF_OPTS += -Dlibpulse=disabled
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
PIPEWIRE_CONF_OPTS += -Dreadline=enabled
PIPEWIRE_DEPENDENCIES += readline
else
PIPEWIRE_CONF_OPTS += -Dreadline=disabled
endif

ifeq ($(BR2_PACKAGE_SDL2),y)
PIPEWIRE_DEPENDENCIES += sdl2
PIPEWIRE_CONF_OPTS += -Dsdl2=enabled
else
PIPEWIRE_CONF_OPTS += -Dsdl2=disabled
endif

ifeq ($(BR2_PACKAGE_PIPEWIRE_COMPRESS_OFFLOAD),y)
PIPEWIRE_CONF_OPTS += -Dcompress-offload=enabled
PIPEWIRE_DEPENDENCIES += tinycompress
else
PIPEWIRE_CONF_OPTS += -Dcompress-offload=disabled
endif

ifeq ($(WEBRTC_AUDIO_PROCESSING),y)
PIPEWIRE_CONF_OPTS += -Decho-cancel-webrtc=enabled
PIPEWIRE_DEPENDENCIES += webrtc-audio-processing
else
PIPEWIRE_CONF_OPTS += -Decho-cancel-webrtc=disabled
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
PIPEWIRE_CONF_OPTS += -Draop=enabled
PIPEWIRE_DEPENDENCIES += openssl
else
PIPEWIRE_CONF_OPTS += -Draop=disabled
endif

define PIPEWIRE_USERS
	pipewire -1 pipewire -1 * - - audio,video PipeWire System Daemon
endef

$(eval $(meson-package))

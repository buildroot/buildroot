################################################################################
#
# gst1-vaapi
#
################################################################################

GST1_VAAPI_VERSION = 1.22.9
GST1_VAAPI_SITE = https://gstreamer.freedesktop.org/src/gstreamer-vaapi
GST1_VAAPI_SOURCE = gstreamer-vaapi-$(GST1_VAAPI_VERSION).tar.xz
GST1_VAAPI_LICENSE = LGPL-2.1+
GST1_VAAPI_LICENSE_FILES = COPYING.LIB

GST1_VAAPI_DEPENDENCIES += \
	gstreamer1 \
	gst1-plugins-base \
	gst1-plugins-bad \
	libva \
	libdrm

GST1_VAAPI_CONF_OPTS += \
	-Ddrm=enabled \
	-Degl=enabled \
	-Dexamples=disabled \
	-Dtests=disabled \
	-Ddoc=disabled

ifeq ($(BR2_PACKAGE_GST1_VAAPI_ENCODERS),y)
GST1_VAAPI_CONF_OPTS += -Dencoders=enabled
else
GST1_VAAPI_CONF_OPTS += -Dencoders=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
GST1_VAAPI_CONF_OPTS += -Degl=enabled
GST1_VAAPI_DEPENDENCIES += libegl
else
GST1_VAAPI_CONF_OPTS += -Degl=disabled
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
GST1_VAAPI_CONF_OPTS += -Dwayland=enabled
GST1_VAAPI_DEPENDENCIES += wayland wayland-protocols
else
GST1_VAAPI_CONF_OPTS += -Dwayland=disabled
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11)$(BR2_PACKAGE_XLIB_LIBXRANDR),yy)
GST1_VAAPI_CONF_OPTS += -Dx11=enabled
GST1_VAAPI_DEPENDENCIES += xlib_libX11 xlib_libXrandr
ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
GST1_VAAPI_CONF_OPTS += -Dglx=enabled
else
GST1_VAAPI_CONF_OPTS += -Dglx=disabled
endif
else
GST1_VAAPI_CONF_OPTS += -Dx11=disabled -Dglx=disabled
endif

$(eval $(meson-package))

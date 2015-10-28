################################################################################
#
# WPE
#
################################################################################

WPE_VERSION = 81ae1cb29ce71441a14d27ddd9aed51f88db24a3
WPE_SITE = $(call github,Metrological,WebKitForWayland,$(WPE_VERSION))

WPE_INSTALL_STAGING = YES
WPE_DEPENDENCIES = host-flex host-bison host-gperf host-ruby host-pkgconf zlib \
	openssl pcre libgles libegl cairo freetype fontconfig harfbuzz icu libxml2 \
	libxslt sqlite libsoup jpeg libpng webp libinput libxkbcommon xkeyboard-config \
	gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad

ifeq ($(BR2_PACKAGE_WAYLAND),y)
WPE_DEPENDENCIES += wayland
endif

ifeq ($(BR2_PACKAGE_WESTON),y)
WPE_DEPENDENCIES += weston
endif

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
WPE_EXTRA_CFLAGS += \
	-D__UCLIBC__
endif

WPE_FLAGS = \
	-DENABLE_VIDEO=ON \
	-DENABLE_VIDEO_TRACK=ON \
	-DENABLE_WEB_AUDIO=ON

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_GOOD_PLUGIN_ISOMP4),y)
WPE_FLAGS += -DENABLE_MEDIA_SOURCE=ON
endif

ifeq ($(BR2_PACKAGE_WPE_USE_ENCRYPTED_MEDIA_V1),y)
WPE_FLAGS += -DENABLE_ENCRYPTED_MEDIA=ON
endif

ifeq ($(BR2_PACKAGE_WPE_USE_ENCRYPTED_MEDIA_V2),y)
WPE_FLAGS += -DENABLE_ENCRYPTED_MEDIA_V2=ON
endif

ifeq ($(BR2_PACKAGE_DXDRM),y)
WPE_DEPENDENCIES += dxdrm
WPE_FLAGS += -DENABLE_DXDRM=ON
ifeq ($(BR2_PACKAGE_DXDRM_EXTERNAL),y)
WPE_FLAGS += -DENABLE_PROVISIONING=ON
endif
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_GL),y)
WPE_FLAGS += -DUSE_GSTREAMER_GL=ON
else
ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_DISPMANX),y)
WPE_FLAGS += -DUSE_HOLE_PUNCH_GSTREAMER=ON
else
WPE_FLAGS += -DUSE_HOLE_PUNCH_EXTERNAL=ON
endif
endif

WPE_CONF_OPTS = -DPORT=WPE -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align" \
	-DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align" \
	$(WPE_EXTRA_CFLAGS) \
	$(WPE_FLAGS)

$(eval $(cmake-package))

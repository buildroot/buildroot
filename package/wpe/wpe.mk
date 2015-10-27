################################################################################
#
# WPE
#
################################################################################

WPE_VERSION = ae9091e2168b8de95033f77c1e20861363da9bc8
WPE_SITE = $(call github,Metrological,WebKitForWayland,$(WPE_VERSION))

WPE_INSTALL_STAGING = YES
WPE_DEPENDENCIES = host-flex host-bison host-gperf host-ruby host-pkgconf zlib \
	pcre libgles libegl cairo freetype fontconfig harfbuzz icu libxml2 libxslt \
	sqlite libsoup jpeg libpng webp libinput libxkbcommon xkeyboard-config \
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

WPE_CONF_OPTS = -DPORT=WPE -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align" \
	-DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align" \
	$(WPE_EXTRA_CFLAGS) \
	$(WPE_FLAGS)

$(eval $(cmake-package))

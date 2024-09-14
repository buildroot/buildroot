################################################################################
#
# wpewebkit
#
################################################################################

# The middle number is even for stable releases, odd for development ones.
WPEWEBKIT_VERSION = 2.44.4
WPEWEBKIT_SITE = https://wpewebkit.org/releases
WPEWEBKIT_SOURCE = wpewebkit-$(WPEWEBKIT_VERSION).tar.xz
WPEWEBKIT_INSTALL_STAGING = YES
WPEWEBKIT_LICENSE = LGPL-2.1+, BSD-2-Clause
WPEWEBKIT_LICENSE_FILES = \
	Source/WebCore/LICENSE-APPLE \
	Source/WebCore/LICENSE-LGPL-2.1
WPEWEBKIT_CPE_ID_VENDOR = wpewebkit
WPEWEBKIT_CPE_ID_PRODUCT = wpe_webkit
WPEWEBKIT_DEPENDENCIES = host-gperf host-python3 host-ruby host-unifdef \
	harfbuzz cairo icu jpeg libepoxy libgcrypt libgles libsoup3 libtasn1 \
	libpng libxslt wayland-protocols webp wpebackend-fdo

WPEWEBKIT_CMAKE_BACKEND = ninja

WPEWEBKIT_CONF_OPTS = \
	-DPORT=WPE \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_DOCUMENTATION=OFF \
	-DENABLE_INTROSPECTION=OFF \
	-DENABLE_MINIBROWSER=OFF \
	-DENABLE_WEB_RTC=OFF \
	-DUSE_ATK=OFF

ifeq ($(BR2_PACKAGE_WPEWEBKIT_SANDBOX),y)
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_BUBBLEWRAP_SANDBOX=ON \
	-DBWRAP_EXECUTABLE=/usr/bin/bwrap \
	-DDBUS_PROXY_EXECUTABLE=/usr/bin/xdg-dbus-proxy
WPEWEBKIT_DEPENDENCIES += libseccomp
else
WPEWEBKIT_CONF_OPTS += -DENABLE_BUBBLEWRAP_SANDBOX=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_MULTIMEDIA),y)
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEB_AUDIO=ON \
	-DENABLE_WEB_CODECS=ON
WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-libav gst1-plugins-base
else
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_VIDEO=OFF \
	-DENABLE_WEB_AUDIO=OFF \
	-DENABLE_WEB_CODECS=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_MEDIA_STREAM),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_MEDIA_STREAM=ON
WPEWEBKIT_DEPENDENCIES += gst1-plugins-bad
else
WPEWEBKIT_CONF_OPTS += -DENABLE_MEDIA_STREAM=OFF
endif

ifeq ($(BR2_PACKAGE_LIBAVIF),y)
WPEWEBKIT_CONF_OPTS += -DUSE_AVIF=ON
WPEWEBKIT_DEPENDENCIES += libavif
else
WPEWEBKIT_CONF_OPTS += -DUSE_AVIF=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=ON
else
WPEWEBKIT_CONF_OPTS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_WEBDRIVER),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=ON
else
WPEWEBKIT_CONF_OPTS += -DENABLE_WEBDRIVER=OFF
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
WPEWEBKIT_CONF_OPTS += -DUSE_LCMS=ON
WPEWEBKIT_DEPENDENCIES += lcms2
else
WPEWEBKIT_CONF_OPTS += -DUSE_LCMS=OFF
endif

ifeq ($(BR2_PACKAGE_LIBBACKTRACE),y)
WPEWEBKIT_CONF_OPTS += -DUSE_LIBBACKTRACE=ON
WPEWEBKIT_DEPENDENCIES += libbacktrace
else
WPEWEBKIT_CONF_OPTS += -DUSE_LIBBACKTRACE=OFF
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
WPEWEBKIT_CONF_OPTS += -DUSE_LIBDRM=ON
WPEWEBKIT_DEPENDENCIES += libdrm
else
WPEWEBKIT_CONF_OPTS += -DUSE_LIBDRM=OFF
endif

ifeq ($(BR2_PACKAGE_WOFF2),y)
WPEWEBKIT_CONF_OPTS += -DUSE_WOFF2=ON
WPEWEBKIT_DEPENDENCIES += woff2
else
WPEWEBKIT_CONF_OPTS += -DUSE_WOFF2=OFF
endif

ifeq ($(BR2_PACKAGE_LIBJXL),y)
WPEWEBKIT_CONF_OPTS += -DUSE_JPEGXL=ON
WPEWEBKIT_DEPENDENCIES += libjxl
else
WPEWEBKIT_CONF_OPTS += -DUSE_JPEGXL=OFF
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
WPEWEBKIT_CONF_OPTS += -DENABLE_JOURNALD_LOG=ON
WPEWEBKIT_DEPENDENCIES += systemd
else
WPEWEBKIT_CONF_OPTS += -DENABLE_JOURNALD_LOG=OFF
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGBM),y)
WPEWEBKIT_CONF_OPTS += -DUSE_GBM=ON
WPEWEBKIT_DEPENDENCIES += libgbm
else
WPEWEBKIT_CONF_OPTS += -DUSE_GBM=OFF
endif

# JIT is not supported for MIPS r6, but the WebKit build system does not
# have a check for these processors. The same goes for ARMv5 and ARMv6.
# Disable JIT forcibly here and use the CLoop interpreter instead.
#
# Also, we have to disable the sampling profiler and WebAssembly, which
# do NOT work with ENABLE_C_LOOP.
#
# Upstream bugs: https://bugs.webkit.org/show_bug.cgi?id=191258
#                https://bugs.webkit.org/show_bug.cgi?id=172765
#                https://bugs.webkit.org/show_bug.cgi?id=265218
#
ifeq ($(BR2_ARM_CPU_ARMV5)$(BR2_ARM_CPU_ARMV6)$(BR2_MIPS_CPU_MIPS32R6)$(BR2_MIPS_CPU_MIPS64R6),y)
WPEWEBKIT_CONF_OPTS += \
	-DENABLE_JIT=OFF \
	-DENABLE_C_LOOP=ON \
	-DENABLE_SAMPLING_PROFILER=OFF \
	-DENABLE_WEBASSEMBLY=OFF
endif

$(eval $(cmake-package))

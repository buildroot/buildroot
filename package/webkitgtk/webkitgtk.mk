################################################################################
#
# webkitgtk
#
################################################################################

WEBKITGTK_VERSION = 2.40.5
WEBKITGTK_SITE = https://www.webkitgtk.org/releases
WEBKITGTK_SOURCE = webkitgtk-$(WEBKITGTK_VERSION).tar.xz
WEBKITGTK_INSTALL_STAGING = YES
WEBKITGTK_LICENSE = LGPL-2.1+, BSD-2-Clause
WEBKITGTK_LICENSE_FILES = \
	Source/WebCore/LICENSE-APPLE \
	Source/WebCore/LICENSE-LGPL-2.1
WEBKITGTK_CPE_ID_VENDOR = webkitgtk
WEBKITGTK_DEPENDENCIES = host-ruby host-python3 host-gperf host-unifdef \
	enchant harfbuzz icu jpeg libgcrypt libgtk3 libsecret libsoup \
	libtasn1 libxml2 libxslt openjpeg sqlite webp woff2
WEBKITGTK_CONF_OPTS = \
	-DENABLE_API_TESTS=OFF \
	-DENABLE_DOCUMENTATION=OFF \
	-DENABLE_GEOLOCATION=OFF \
	-DENABLE_MINIBROWSER=ON \
	-DENABLE_SPELLCHECK=ON \
	-DENABLE_WEB_RTC=OFF \
	-DPORT=GTK \
	-DUSE_AVIF=OFF \
	-DUSE_LIBHYPHEN=OFF \
	-DUSE_OPENJPEG=ON \
	-DUSE_SOUP2=ON \
	-DUSE_WOFF2=ON

ifeq ($(BR2_PACKAGE_WEBKITGTK_SANDBOX),y)
WEBKITGTK_CONF_OPTS += \
	-DENABLE_BUBBLEWRAP_SANDBOX=ON \
	-DBWRAP_EXECUTABLE=/usr/bin/bwrap \
	-DDBUS_PROXY_EXECUTABLE=/usr/bin/xdg-dbus-proxy
WEBKITGTK_DEPENDENCIES += libseccomp
else
WEBKITGTK_CONF_OPTS += -DENABLE_BUBBLEWRAP_SANDBOX=OFF
endif

ifeq ($(BR2_PACKAGE_WEBKITGTK_MULTIMEDIA),y)
WEBKITGTK_CONF_OPTS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEB_AUDIO=ON
WEBKITGTK_DEPENDENCIES += gstreamer1 gst1-libav gst1-plugins-base
else
WEBKITGTK_CONF_OPTS += \
	-DENABLE_VIDEO=OFF \
	-DENABLE_WEB_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_WEBKITGTK_WEBDRIVER),y)
WEBKITGTK_CONF_OPTS += -DENABLE_WEBDRIVER=ON
else
WEBKITGTK_CONF_OPTS += -DENABLE_WEBDRIVER=OFF
endif

ifeq ($(BR2_PACKAGE_LCMS2),y)
WEBKITGTK_CONF_OPTS += -DUSE_LCMS=ON
WEBKITGTK_DEPENDENCIES += lcms2
else
WEBKITGTK_CONF_OPTS += -DUSE_LCMS=OFF
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
WEBKITGTK_CONF_OPTS += -DENABLE_INTROSPECTION=ON
WEBKITGTK_DEPENDENCIES += gobject-introspection
else
WEBKITGTK_CONF_OPTS += -DENABLE_INTROSPECTION=OFF
endif

ifeq ($(BR2_PACKAGE_LIBMANETTE),y)
WEBKITGTK_CONF_OPTS += -DENABLE_GAMEPAD=ON
WEBKITGTK_DEPENDENCIES += libmanette
else
WEBKITGTK_CONF_OPTS += -DENABLE_GAMEPAD=OFF
endif

# Only one target platform can be built, assume X11 > Wayland

# GTK3-X11 target gives OpenGL from newer libgtk3 versions
# Consider this better than EGL + maybe GLESv2 since both can't be built
# 2D CANVAS acceleration requires OpenGL proper with cairo-gl
ifeq ($(BR2_PACKAGE_LIBGTK3_X11),y)
WEBKITGTK_CONF_OPTS += \
	-DENABLE_GLES2=OFF \
	-DENABLE_X11_TARGET=ON
WEBKITGTK_DEPENDENCIES += libgl \
	xlib_libXcomposite xlib_libXdamage xlib_libXrender xlib_libXt
else # !X11
# GTK3-BROADWAY/WAYLAND needs at least EGL
WEBKITGTK_DEPENDENCIES += libegl
# GLESv2 support is optional though
ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
WEBKITGTK_CONF_OPTS += -DENABLE_GLES2=ON
WEBKITGTK_DEPENDENCIES += libgles
else
# Disable general OpenGL (shading) if there's no GLESv2
WEBKITGTK_CONF_OPTS += -DENABLE_GLES2=OFF
endif
# We must explicitly state the wayland target
ifeq ($(BR2_PACKAGE_LIBGTK3_WAYLAND),y)
WEBKITGTK_CONF_OPTS += -DENABLE_WAYLAND_TARGET=ON
endif
endif

ifeq ($(BR2_PACKAGE_LIBGTK3_WAYLAND)$(BR2_PACKAGE_WPEBACKEND_FDO),yy)
WEBKITGTK_CONF_OPTS += -DUSE_WPE_RENDERER=ON
WEBKITGTK_DEPENDENCIES += wpebackend-fdo
else
WEBKITGTK_CONF_OPTS += -DUSE_WPE_RENDERER=OFF
endif

ifeq ($(BR2_PACKAGE_WEBKITGTK_USE_GSTREAMER_GL),y)
WEBKITGTK_CONF_OPTS += -DUSE_GSTREAMER_GL=ON
else
WEBKITGTK_CONF_OPTS += -DUSE_GSTREAMER_GL=OFF
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
WEBKITGTK_CONF_OPTS += -DENABLE_JOURNALD_LOG=ON
WEBKITGTK_DEPENDENCIES += systemd
else
WEBKITGTK_CONF_OPTS += -DENABLE_JOURNALD_LOG=OFF
endif

# JIT is not supported for MIPS r6, but the WebKit build system does not
# have a check for these processors. The same goes for ARMv5 and ARMv6.
# Disable JIT forcibly here and use the CLoop interpreter instead.
#
# Also, we have to disable the sampling profiler, which does NOT work
# with ENABLE_C_LOOP.
#
# Upstream bugs: https://bugs.webkit.org/show_bug.cgi?id=191258
#                https://bugs.webkit.org/show_bug.cgi?id=172765
#
ifeq ($(BR2_ARM_CPU_ARMV5)$(BR2_ARM_CPU_ARMV6)$(BR2_MIPS_CPU_MIPS32R6)$(BR2_MIPS_CPU_MIPS64R6),y)
WEBKITGTK_CONF_OPTS += -DENABLE_JIT=OFF -DENABLE_C_LOOP=ON -DENABLE_SAMPLING_PROFILER=OFF
endif

# webkitgtk needs cmake >= 3.20 when not building with ninja, which is
# above our minimal version in
# support/dependencies/check-host-cmake.mk, so use the ninja backend:
# https://github.com/WebKit/WebKit/commit/6cd89696b5d406c1a3d9a7a9bbb18fda9284fa1f
WEBKITGTK_CONF_OPTS += -GNinja
WEBKITGTK_DEPENDENCIES += host-ninja

define WEBKITGTK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(BR2_CMAKE) --build $(WEBKITGTK_BUILDDIR)
endef

define WEBKITGTK_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) DESTDIR=$(STAGING_DIR) $(BR2_CMAKE) --install $(WEBKITGTK_BUILDDIR)
endef

define WEBKITGTK_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) DESTDIR=$(TARGET_DIR) $(BR2_CMAKE) --install $(WEBKITGTK_BUILDDIR)
endef

$(eval $(cmake-package))

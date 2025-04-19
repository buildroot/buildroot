################################################################################
#
# mpv
#
################################################################################

MPV_VERSION = 0.35.1
MPV_SITE = $(call github,mpv-player,mpv,v$(MPV_VERSION))
MPV_DEPENDENCIES = \
	host-pkgconf ffmpeg libass zlib \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)
MPV_LICENSE = GPL-2.0+
MPV_LICENSE_FILES = LICENSE.GPL
MPV_CPE_ID_VENDOR = mpv
MPV_INSTALL_STAGING = YES

# Some of these options need testing and/or tweaks
MPV_CONF_OPTS = \
	-Dcaca=disabled \
	-Dcocoa=disabled \
	-Dcoreaudio=disabled \
	-Dcuda-hwaccel=disabled \
	-Dlibmpv=true \
	-Dopensles=disabled \
	-Drubberband=disabled \
	-Duchardet=disabled \
	-Dvapoursynth=disabled

ifeq ($(BR2_REPRODUCIBLE),y)
MPV_CONF_OPTS += -Dbuild-date=false
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
MPV_CONF_OPTS += -Dalsa=enabled
MPV_DEPENDENCIES += alsa-lib
else
MPV_CONF_OPTS += -Dalsa=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_GBM),y)
MPV_CONF_OPTS += -Dgbm=enabled
MPV_DEPENDENCIES += mesa3d
ifeq ($(BR2_PACKAGE_LIBDRM),y)
MPV_CONF_OPTS += -Degl-drm=enabled
else
MPV_CONF_OPTS += -Degl-drm=disabled
endif
else
MPV_CONF_OPTS += -Dgbm=disabled -Degl-drm=disabled
endif

# jack support
# It also requires 64-bit sync intrinsics
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_8)$(BR2_PACKAGE_JACK2),yy)
MPV_CONF_OPTS += -Djack=enabled
MPV_DEPENDENCIES += jack2
else
MPV_CONF_OPTS += -Djack=disabled
endif

# jpeg support
ifeq ($(BR2_PACKAGE_JPEG),y)
MPV_CONF_OPTS += -Djpeg=enabled
MPV_DEPENDENCIES += jpeg
else
MPV_CONF_OPTS += -Djpeg=disabled
endif

# lcms2 support
ifeq ($(BR2_PACKAGE_LCMS2),y)
MPV_CONF_OPTS += -Dlcms2=enabled
MPV_DEPENDENCIES += lcms2
else
MPV_CONF_OPTS += -Dlcms2=disabled
endif

# libarchive support
ifeq ($(BR2_PACKAGE_LIBARCHIVE),y)
MPV_CONF_OPTS += -Dlibarchive=enabled
MPV_DEPENDENCIES += libarchive
else
MPV_CONF_OPTS += -Dlibarchive=disabled
endif

# bluray support
ifeq ($(BR2_PACKAGE_LIBBLURAY),y)
MPV_CONF_OPTS += -Dlibbluray=enabled
MPV_DEPENDENCIES += libbluray
else
MPV_CONF_OPTS += -Dlibbluray=disabled
endif

# libcdio-paranoia
ifeq ($(BR2_PACKAGE_LIBCDIO_PARANOIA),y)
MPV_CONF_OPTS += -Dcdda=enabled
MPV_DEPENDENCIES += libcdio-paranoia
else
MPV_CONF_OPTS += -Dcdda=disabled
endif

# libdvdnav
ifeq ($(BR2_PACKAGE_LIBDVDNAV),y)
MPV_CONF_OPTS += -Ddvdnav=enabled
MPV_DEPENDENCIES += libdvdnav
else
MPV_CONF_OPTS += -Ddvdnav=disabled
endif

# libdrm
ifeq ($(BR2_PACKAGE_LIBDRM),y)
MPV_CONF_OPTS += -Ddrm=enabled
MPV_DEPENDENCIES += libdrm
else
MPV_CONF_OPTS += -Ddrm=disabled
endif

# libvdpau
ifeq ($(BR2_PACKAGE_LIBVDPAU),y)
MPV_CONF_OPTS += -Dvdpau=enabled
MPV_DEPENDENCIES += libvdpau
else
MPV_CONF_OPTS += -Dvdpau=disabled
endif

# LUA support, only for lua51/lua52/luajit
# This enables the controller (OSD) together with libass
ifeq ($(BR2_PACKAGE_LUA_5_1)$(BR2_PACKAGE_LUAJIT),y)
MPV_CONF_OPTS += -Dlua=enabled
MPV_DEPENDENCIES += luainterpreter
else
MPV_CONF_OPTS += -Dlua=disabled
endif

# OpenGL support
ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
MPV_CONF_OPTS += -Dgl=enabled
MPV_DEPENDENCIES += libgl
else ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
MPV_CONF_OPTS += -Dgl=enabled
MPV_DEPENDENCIES += libgles
else ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
MPV_CONF_OPTS += -Dgl=enabled
MPV_DEPENDENCIES += libegl
else
MPV_CONF_OPTS += -Dgl=disabled
endif

# pulseaudio support
ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
MPV_CONF_OPTS += -Dpulse=enabled
MPV_DEPENDENCIES += pulseaudio
else
MPV_CONF_OPTS += -Dpulse=disabled
endif

# SDL support
# Sdl2 requires 64-bit sync intrinsics
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_8)$(BR2_PACKAGE_SDL2),yy)
MPV_CONF_OPTS += -Dsdl2=enabled
MPV_DEPENDENCIES += sdl2
else
MPV_CONF_OPTS += -Dsdl2=disabled
endif

# Raspberry Pi support
ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
MPV_CONF_OPTS += -Drpi=enabled -Dgl=enabled
MPV_DEPENDENCIES += rpi-userland
else
MPV_CONF_OPTS += -Drpi=disabled
endif

# va-api support
ifeq ($(BR2_PACKAGE_LIBVA)$(BR2_PACKAGE_MPV_SUPPORTS_VAAPI),yy)
MPV_CONF_OPTS += -Dvaapi=enabled
MPV_DEPENDENCIES += libva
ifeq ($(BR2_PACKAGE_LIBDRM)$(BR2_PACKAGE_MESA3D_OPENGL_EGL),yy)
MPV_CONF_OPTS += -Dvaapi-drm=enabled
else
MPV_CONF_OPTS += -Dvaapi-drm=disabled
endif
else
MPV_CONF_OPTS += -Dvaapi=disabled -Dvaapi-drm=disabled
endif

# wayland support
ifeq ($(BR2_PACKAGE_WAYLAND),y)
MPV_CONF_OPTS += -Dwayland=enabled
MPV_DEPENDENCIES += libxkbcommon wayland wayland-protocols
else
MPV_CONF_OPTS += -Dwayland=disabled
endif

# Base X11 support. Config.in ensures that if BR2_PACKAGE_XORG7 is
# enabled, xlib_libX11, xlib_libXext, xlib_libXinerama,
# xlib_libXrandr, xlib_libXScrnSaver.
ifeq ($(BR2_PACKAGE_XORG7),y)
MPV_CONF_OPTS += -Dx11=enabled
MPV_DEPENDENCIES += \
	xlib_libX11 \
	xlib_libXext \
	xlib_libXinerama \
	xlib_libXpresent \
	xlib_libXrandr \
	xlib_libXScrnSaver
# XVideo
ifeq ($(BR2_PACKAGE_XLIB_LIBXV),y)
MPV_CONF_OPTS += -Dxv=enabled
MPV_DEPENDENCIES += xlib_libXv
else
MPV_CONF_OPTS += -Dxv=disabled
endif
else
MPV_CONF_OPTS += -Dx11=disabled
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
MPV_CONF_OPTS += -Dstdatomic=enabled
else
MPV_CONF_OPTS += -Dstdatomic=disabled
endif

$(eval $(meson-package))

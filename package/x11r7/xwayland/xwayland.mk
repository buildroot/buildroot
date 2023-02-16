################################################################################
#
# xwayland
#
################################################################################

XWAYLAND_VERSION = 22.1.8
XWAYLAND_SOURCE = xwayland-$(XWAYLAND_VERSION).tar.xz
XWAYLAND_SITE = https://xorg.freedesktop.org/archive/individual/xserver
XWAYLAND_LICENSE = MIT
XWAYLAND_LICENSE_FILES = COPYING
XWAYLAND_INSTALL_STAGING = YES
XWAYLAND_DEPENDENCIES = \
	pixman \
	wayland \
	wayland-protocols \
	xlib_libxcvt \
	xlib_libXfont2 \
	xlib_libxkbfile \
	xlib_libXrandr \
	xlib_xtrans \
	xorgproto
XWAYLAND_CONF_OPTS = \
	-Dxwayland_eglstream=false \
	-Dxvfb=false \
	-Ddefault_font_path=/usr/share/fonts/X11/ \
	-Ddtrace=false \
	-Ddocs=false

ifeq ($(BR2_PACKAGE_LIBDRM)$(BR2_PACKAGE_LIBEPOXY),yy)
XWAYLAND_CONF_OPTS += -Dglamor=true
XWAYLAND_DEPENDENCIES += libdrm libepoxy
else
XWAYLAND_CONF_OPTS += -Dglamor=false
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
XWAYLAND_CONF_OPTS += -Dglx=true
XWAYLAND_DEPENDENCIES += libgl
else
XWAYLAND_CONF_OPTS += -Dglx=false
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXDMCP),y)
XWAYLAND_CONF_OPTS += \
	-Dxdmcp=true \
	-Dxdm-auth-1=true
XWAYLAND_DEPENDENCIES += xlib_libXdmcp
else
XWAYLAND_CONF_OPTS += \
	-Dxdmcp=false \
	-Dxdm-auth-1=false
endif

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
XWAYLAND_CONF_OPTS += -Dsecure-rpc=true
XWAYLAND_DEPENDENCIES += libtirpc
else
XWAYLAND_CONF_OPTS += -Dsecure-rpc=false
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX)$(BR2_PACKAGE_AUDIT),yy)
XWAYLAND_CONF_OPTS += -Dxselinux=true
XWAYLAND_DEPENDENCIES += libselinux audit
else
XWAYLAND_CONF_OPTS += -Dxselinux=false
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
XWAYLAND_CONF_OPTS += -Dsha1=libcrypto
XWAYLAND_DEPENDENCIES += openssl
else ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
XWAYLAND_CONF_OPTS += -Dsha1=libgcrypt
XWAYLAND_DEPENDENCIES += libgcrypt
else
XWAYLAND_CONF_OPTS += -Dsha1=libsha1
XWAYLAND_DEPENDENCIES += libsha1
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXSHMFENCE)$(BR2_PACKAGE_LIBDRM),yy)
XWAYLAND_CONF_OPTS += -Ddri3=true
XWAYLAND_DEPENDENCIES += xlib_libxshmfence libdrm
else
XWAYLAND_CONF_OPTS += -Ddri3=false
endif

ifeq ($(BR2_PACKAGE_LIBUNWIND),y)
XWAYLAND_CONF_OPTS += -Dlibunwind=true
XWAYLAND_DEPENDENCIES += libunwind
else
XWAYLAND_CONF_OPTS += -Dlibunwind=false
endif

$(eval $(meson-package))

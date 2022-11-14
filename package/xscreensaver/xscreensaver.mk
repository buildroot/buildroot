################################################################################
#
# xscreensaver
#
################################################################################

XSCREENSAVER_VERSION = 6.03
XSCREENSAVER_SITE = https://www.jwz.org/xscreensaver

# N.B. GPL-2.0+ code (in the hacks/glx subdirectory) is not currently built.
XSCREENSAVER_LICENSE = MIT-like, GPL-2.0+
XSCREENSAVER_LICENSE_FILES = hacks/screenhack.h hacks/glx/chessmodels.h
XSCREENSAVER_CPE_ID_VENDOR = xscreensaver_project
XSCREENSAVER_SELINUX_MODULES = xdg xscreensaver xserver

XSCREENSAVER_DEPENDENCIES = \
	gdk-pixbuf \
	gdk-pixbuf-xlib \
	jpeg \
	libgl \
	libglu \
	libgtk2 \
	libxml2 \
	xlib_libX11 \
	xlib_libXft \
	xlib_libXi \
	xlib_libXt \
	$(TARGET_NLS_DEPENDENCIES) \
	host-intltool

# otherwise we end up with host include/library dirs passed to the
# compiler/linker
XSCREENSAVER_CONF_OPTS = \
	--includedir=$(STAGING_DIR)/usr/include \
	--libdir=$(STAGING_DIR)/usr/lib \
	--with-gl=yes

ifeq ($(BR2_PACKAGE_LIBPNG),y)
XSCREENSAVER_CONF_OPTS += --with-png=yes
XSCREENSAVER_DEPENDENCIES += libpng
else
XSCREENSAVER_CONF_OPTS += --with-png=no
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
XSCREENSAVER_CONF_OPTS += --with-systemd=yes
XSCREENSAVER_DEPENDENCIES += systemd
else
XSCREENSAVER_CONF_OPTS += --with-systemd=no
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
XSCREENSAVER_CONF_OPTS += --with-xinerama-ext=yes
XSCREENSAVER_DEPENDENCIES += xlib_libXinerama
else
XSCREENSAVER_CONF_OPTS += --with-xinerama-ext=no
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXRANDR),y)
XSCREENSAVER_CONF_OPTS += --with-randr-ext=yes
XSCREENSAVER_DEPENDENCIES += xlib_libXrandr
else
XSCREENSAVER_CONF_OPTS += --with-randr-ext=no
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXXF86VM),y)
XSCREENSAVER_CONF_OPTS += --with-xf86vmode-ext=yes
XSCREENSAVER_DEPENDENCIES += xlib_libXxf86vm
else
XSCREENSAVER_CONF_OPTS += --with-xf86vmode-ext=no
endif

XSCREENSAVER_INSTALL_TARGET_OPTS = install_prefix="$(TARGET_DIR)" install

$(eval $(autotools-package))

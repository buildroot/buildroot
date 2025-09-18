################################################################################
#
# xapp_xdm
#
################################################################################

XAPP_XDM_VERSION = 1.1.17
XAPP_XDM_SOURCE = xdm-$(XAPP_XDM_VERSION).tar.xz
XAPP_XDM_SITE = https://xorg.freedesktop.org/archive/individual/app
XAPP_XDM_LICENSE = MIT
XAPP_XDM_LICENSE_FILES = COPYING
XAPP_XDM_CONF_ENV = ac_cv_file__dev_urandom=yes
XAPP_XDM_DEPENDENCIES = \
	xapp_sessreg \
	xapp_xrdb \
	xlib_libX11 \
	xlib_libXaw \
	xlib_libXdmcp \
	xlib_libXt \
	xorgproto
XAPP_XDM_CONF_OPTS = \
	--with-appdefaultdir=/usr/share/X11/app-defaults \
	--with-utmp-file=/var/adm/utmpx \
	--with-wtmp-file=/var/adm/wtmpx

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
XAPP_XDM_CONF_OPTS += --with-xinerama
XAPP_XDM_DEPENDENCIES += xlib_libXinerama
else
XAPP_XDM_CONF_OPTS += --without-xinerama
endif

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
XAPP_XDM_DEPENDENCIES += libxcrypt
endif

define XAPP_XDM_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/x11r7/xapp_xdm/S99xdm \
		$(TARGET_DIR)/etc/init.d/S99xdm
endef

$(eval $(autotools-package))

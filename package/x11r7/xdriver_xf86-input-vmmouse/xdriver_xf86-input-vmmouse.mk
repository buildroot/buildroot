################################################################################
#
# xdriver_xf86-input-vmmouse
#
################################################################################

XDRIVER_XF86_INPUT_VMMOUSE_VERSION = 13.2.0
XDRIVER_XF86_INPUT_VMMOUSE_SOURCE = xf86-input-vmmouse-$(XDRIVER_XF86_INPUT_VMMOUSE_VERSION).tar.xz
XDRIVER_XF86_INPUT_VMMOUSE_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_INPUT_VMMOUSE_LICENSE = MIT
XDRIVER_XF86_INPUT_VMMOUSE_LICENSE_FILES = COPYING
XDRIVER_XF86_INPUT_VMMOUSE_DEPENDENCIES = xserver_xorg-server xorgproto

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
XDRIVER_XF86_INPUT_VMMOUSE_CONF_OPTS += --with-libudev
XDRIVER_XF86_INPUT_VMMOUSE_DEPENDENCIES += udev
else
XDRIVER_XF86_INPUT_VMMOUSE_CONF_OPTS += --without-libudev
endif

$(eval $(autotools-package))

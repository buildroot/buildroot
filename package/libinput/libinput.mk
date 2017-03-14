################################################################################
#
# libinput
#
################################################################################

LIBINPUT_VERSION = 1.6.3
LIBINPUT_SOURCE = libinput-$(LIBINPUT_VERSION).tar.xz
LIBINPUT_SITE = http://www.freedesktop.org/software/libinput
LIBINPUT_DEPENDENCIES = host-pkgconf host-python3 libevdev mtdev udev
LIBINPUT_INSTALL_STAGING = YES
LIBINPUT_LICENSE = MIT
LIBINPUT_LICENSE_FILES = COPYING
# Tests need fork, so just disable them everywhere.
LIBINPUT_CONF_OPTS = --disable-tests --disable-libwacom
LIBINPUT_CONF_ENV = PYTHON=python3

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
LIBINPUT_CONF_OPTS += --enable-event-gui
LIBINPUT_DEPENDENCIES += libgtk3
else
LIBINPUT_CONF_OPTS += --disable-event-gui
endif

$(eval $(autotools-package))

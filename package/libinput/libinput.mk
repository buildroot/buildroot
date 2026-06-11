################################################################################
#
# libinput
#
################################################################################

LIBINPUT_VERSION = 1.27.0
LIBINPUT_SOURCE = libinput-$(LIBINPUT_VERSION).tar.bz2
LIBINPUT_SITE = https://gitlab.freedesktop.org/libinput/libinput/-/archive/$(LIBINPUT_VERSION)
LIBINPUT_DEPENDENCIES = host-pkgconf libevdev mtdev udev
LIBINPUT_INSTALL_STAGING = YES
LIBINPUT_LICENSE = MIT
LIBINPUT_LICENSE_FILES = COPYING
LIBINPUT_CPE_ID_VENDOR = freedesktop
# Tests need fork, so just disable them everywhere.
LIBINPUT_CONF_OPTS = -Dtests=false -Dlibwacom=false -Ddocumentation=false

# Code not present in 1.27.0, see
# https://gitlab.freedesktop.org/libinput/libinput/-/commit/9e37bc0cfa4d975291e5a2899e148fb83526d4a2
LIBINPUT_IGNORE_CVES += CVE-2026-35093 CVE-2026-35094

# 0001-dont-call-function-in-macro-argument.patch
# 0002-util-sanitize-control-characters-in-str-sanitize.patch
# 0003-libinput-device-group-sanitize-phys-before-printing-it.patch
LIBINPUT_IGNORE_CVES += CVE-2026-50292

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
LIBINPUT_CONF_OPTS += -Ddebug-gui=true
LIBINPUT_DEPENDENCIES += libgtk3
ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBINPUT_DEPENDENCIES += wayland
endif
ifeq ($(BR2_PACKAGE_WAYLAND_PROTOCOLS),y)
LIBINPUT_DEPENDENCIES += wayland-protocols
endif
ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
LIBINPUT_DEPENDENCIES += xlib_libX11
endif
else
LIBINPUT_CONF_OPTS += -Ddebug-gui=false
endif

ifeq ($(BR2_PACKAGE_LIBINPUT_PYTHON_TOOLS),)
LIBINPUT_PYTHON_TOOLS = libinput-analyze-per-slot-delta \
	libinput-analyze-recording \
	libinput-analyze-touch-down-state \
	libinput-measure-fuzz \
	libinput-measure-touchpad-pressure \
	libinput-measure-touchpad-size \
	libinput-measure-touchpad-tap \
	libinput-measure-touch-size \
	libinput-replay

define LIBINPUT_REMOVE_UNNEEDED_FILES
	$(foreach f,$(LIBINPUT_PYTHON_TOOLS), \
		rm -f $(TARGET_DIR)/usr/libexec/libinput/$(f)
	)
endef
LIBINPUT_POST_INSTALL_TARGET_HOOKS += LIBINPUT_REMOVE_UNNEEDED_FILES
endif

$(eval $(meson-package))

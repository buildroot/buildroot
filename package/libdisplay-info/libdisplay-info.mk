################################################################################
#
# libdisplay-info
#
################################################################################

LIBDISPLAY_INFO_VERSION = 0.1.1
LIBDISPLAY_INFO_SOURCE = libdisplay-info-$(LIBDISPLAY_INFO_VERSION).tar.bz2
LIBDISPLAY_INFO_SITE = https://gitlab.freedesktop.org/emersion/libdisplay-info/-/archive/$(LIBDISPLAY_INFO_VERSION)
LIBDISPLAY_INFO_LICENSE = MIT
LIBDISPLAY_INFO_LICENSE_FILES = LICENSE
LIBDISPLAY_INFO_INSTALL_STAGING = YES
LIBDISPLAY_INFO_DEPENDENCIES = hwdata

# workaround for static_assert on uclibc-ng < 1.0.42
LIBDISPLAY_INFO_CFLAGS += $(TARGET_CFLAGS) -Dstatic_assert=_Static_assert

$(eval $(meson-package))

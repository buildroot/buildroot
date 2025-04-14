################################################################################
#
# libv4l
#
################################################################################

LIBV4L_VERSION = 1.28.1
LIBV4L_SOURCE = v4l-utils-$(LIBV4L_VERSION).tar.xz
LIBV4L_SITE = https://linuxtv.org/downloads/v4l-utils
LIBV4L_INSTALL_STAGING = YES
LIBV4L_DEPENDENCIES = host-pkgconf
LIBV4L_CONF_OPTS = -Ddoxygen-doc=disabled -Dqvidcap=disabled -Dv4l2-tracer=disabled
LIBV4L_LDFLAGS = $(TARGET_LDFLAGS)

# v4l-utils components have different licences, see v4l-utils.spec for details
LIBV4L_LICENSE = GPL-2.0+ (utilities), LGPL-2.1+ (libraries)
LIBV4L_LICENSE_FILES = COPYING COPYING.libv4l lib/libv4l1/libv4l1-kernelcode-license.txt

ifeq ($(BR2_STATIC_LIBS),y)
LIBV4L_CONF_OPTS += -Dv4l-plugins=false -Dv4l-wrappers=false
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
LIBV4L_DEPENDENCIES += alsa-lib
endif

ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
LIBV4L_DEPENDENCIES += argp-standalone $(TARGET_NLS_DEPENDENCIES)
LIBV4L_LDFLAGS += $(TARGET_NLS_LIBS)
endif

LIBV4L_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBICONV),libiconv)

ifeq ($(BR2_PACKAGE_JPEG),y)
LIBV4L_CONF_OPTS += -Djpeg=enabled
LIBV4L_DEPENDENCIES += jpeg
else
LIBV4L_CONF_OPTS += -Djpeg=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
LIBV4L_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
LIBV4L_CONF_OPTS += -Dlibdvbv5=enabled -Dudevdir=/usr/lib/udev
LIBV4L_DEPENDENCIES += udev
else
LIBV4L_CONF_OPTS += -Dlibdvbv5=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGLU),y)
LIBV4L_DEPENDENCIES += libglu
endif

ifeq ($(BR2_PACKAGE_LIBV4L_UTILS),y)
LIBV4L_CONF_OPTS += -Dv4l-utils=true
LIBV4L_DEPENDENCIES += $(TARGET_NLS_DEPENDENCIES)

# IR BPF decoder support needs toolchain with linux-headers >= 3.18
# libelf and clang support
LIBV4L_CONF_OPTS += -Dbpf=disabled

ifeq ($(BR2_PACKAGE_QT5BASE)$(BR2_PACKAGE_QT5BASE_GUI)$(BR2_PACKAGE_QT5BASE_WIDGETS),yyy)
LIBV4L_CONF_OPTS += -Dqv4l2=enabled
LIBV4L_DEPENDENCIES += qt5base
else
LIBV4L_CONF_OPTS += -Dqv4l2=disabled
endif
else
LIBV4L_CONF_OPTS += -Dv4l-utils=false
endif

ifeq ($(BR2_PACKAGE_SDL2_IMAGE),y)
LIBV4L_DEPENDENCIES += sdl2_image
endif

$(eval $(meson-package))

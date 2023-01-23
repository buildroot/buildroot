################################################################################
#
# libcamera-apps
#
################################################################################

LIBCAMERA_APPS_VERSION = 1.1.0
LIBCAMERA_APPS_SITE = $(call github,raspberrypi,libcamera-apps,v$(LIBCAMERA_APPS_VERSION))
LIBCAMERA_APPS_LICENSE = BSD-2-Clause
LIBCAMERA_APPS_LICENSE_FILES = license.txt
LIBCAMERA_APPS_DEPENDENCIES = \
	host-pkgconf \
	boost \
	jpeg \
	libcamera \
	libexif \
	libpng \
	tiff

LIBCAMERA_APPS_CONF_OPTS = \
	-DENABLE_COMPILE_FLAGS_FOR_TARGET=disabled \
	-DENABLE_OPENCV=0 \
	-DENABLE_TFLITE=0

ifeq ($(BR2_PACKAGE_LIBDRM),y)
LIBCAMERA_APPS_DEPENDENCIES += libdrm
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_DRM=1
else
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_DRM=0
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBCAMERA_APPS_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_LIBEPOXY),libepoxy) \
	$(if $(BR2_PACKAGE_XLIB_LIBX11),xlib_libX11)
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_X11=1
else
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_X11=0
endif

ifeq ($(BR2_PACKAGE_QT5),y)
LIBCAMERA_APPS_DEPENDENCIES += qt5base
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_QT=1
else
LIBCAMERA_APPS_CONF_OPTS += -DENABLE_QT=0
endif

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBCAMERA_APPS_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

$(eval $(cmake-package))

################################################################################
#
# libcamera-apps
#
################################################################################

LIBCAMERA_APPS_VERSION = v1.7.0-10-ge9645231008146fa0e75c2b3e0ff8c48ad70511a
LIBCAMERA_APPS_SITE = $(call github,raspberrypi,rpicam-apps,$(LIBCAMERA_APPS_VERSION))
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
	-Denable_opencv=disabled \
	-Denable_tflite=disabled

ifeq ($(BR2_PACKAGE_LIBDRM),y)
LIBCAMERA_APPS_DEPENDENCIES += libdrm
LIBCAMERA_APPS_CONF_OPTS += -Denable_drm=enabled
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_drm=disabled
endif

ifeq ($(BR2_PACKAGE_FFMPEG)$(BR2_PACKAGE_LIBDRM),yy)
LIBCAMERA_APPS_DEPENDENCIES += ffmpeg libdrm
LIBCAMERA_APPS_CONF_OPTS += -Denable_libav=enabled
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_libav=disabled
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
LIBCAMERA_APPS_CONF_OPTS += -Ddisable_rpi_features=false
else
LIBCAMERA_APPS_CONF_OPTS += -Ddisable_rpi_features=true
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBCAMERA_APPS_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_LIBEPOXY),libepoxy) \
	$(if $(BR2_PACKAGE_XLIB_LIBX11),xlib_libX11)
LIBCAMERA_APPS_CONF_OPTS += -Denable_egl=enabled
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_egl=disabled
endif

ifeq ($(BR2_PACKAGE_QT5),y)
LIBCAMERA_APPS_DEPENDENCIES += qt5base
LIBCAMERA_APPS_CONF_OPTS += -Denable_qt=enabled
else
LIBCAMERA_APPS_CONF_OPTS += -Denable_qt=disabled
endif

$(eval $(meson-package))

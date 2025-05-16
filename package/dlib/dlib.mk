################################################################################
#
# dlib
#
################################################################################

DLIB_VERSION = 19.24.9
DLIB_SITE = $(call github,davisking,dlib,v$(DLIB_VERSION))
DLIB_CMAKE_BACKEND = ninja
DLIB_INSTALL_STAGING = YES
DLIB_SUPPORTS_IN_SOURCE_BUILD = NO

DLIB_LICENSE = \
	BSD-3-Clause (kissfft, pybind11) \
	BSL-1.0 (dlib, tools) \
	CC0-1.0 (examples) \
	libpng-2.0 (libpng) \
	MIT or CC0-1.0 (JoinPaths.cmake)

DLIB_LICENSE_FILES = \
	dlib/external/libjpeg/README \
	dlib/external/libpng/LICENSE \
	dlib/external/pybind11/LICENSE \
	dlib/LICENSE.txt \
	dlib/test/ffmpeg_data/LICENSE.TXT \
	examples/LICENSE_FOR_EXAMPLE_PROGRAMS.txt \
	examples/video_frames/license.txt \
	LICENSE.txt \
	python_examples/LICENSE_FOR_EXAMPLE_PROGRAMS.txt

DLIB_CONF_OPTS = \
	-DDLIB_LINK_WITH_SQLITE3=OFF \
	-DDLIB_USE_CUDA=OFF \
	-DDLIB_USE_MKL_FFT=OFF

ifeq ($(BR2_PACKAGE_FFMPEG)$(BR2_PACKAGE_FFMPEG_SWSCALE),yy)
DLIB_CONF_OPTS += -DDLIB_USE_FFMPEG=ON
DLIB_DEPENDENCIES += ffmpeg
else
DLIB_CONF_OPTS += -DDLIB_USE_FFMPEG=OFF
endif

ifeq ($(BR2_PACKAGE_GIFLIB),y)
DLIB_CONF_OPTS += -DDLIB_GIF_SUPPORT=ON
DLIB_DEPENDENCIES += giflib
else
DLIB_CONF_OPTS += -DDLIB_GIF_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
DLIB_CONF_OPTS += -DDLIB_JPEG_SUPPORT=ON
DLIB_DEPENDENCIES += jpeg
else
DLIB_CONF_OPTS += -DDLIB_JPEG_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_LAPACK),y)
DLIB_CONF_OPTS += -DDLIB_USE_LAPACK=ON
DLIB_DEPENDENCIES += lapack
else
DLIB_CONF_OPTS += -DDLIB_USE_LAPACK=OFF
endif

ifeq ($(BR2_PACKAGE_LIBJXL),y)
DLIB_CONF_OPTS += -DDLIB_JXL_SUPPORT=ON
DLIB_DEPENDENCIES += libjxl
else
DLIB_CONF_OPTS += -DDLIB_JXL_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
DLIB_CONF_OPTS += -DDLIB_PNG_SUPPORT=ON
DLIB_DEPENDENCIES += libpng
else
DLIB_CONF_OPTS += -DDLIB_PNG_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_OPENBLAS),y)
DLIB_CONF_OPTS += -DDLIB_USE_BLAS=ON
DLIB_DEPENDENCIES += openblas
else
DLIB_CONF_OPTS += -DDLIB_USE_BLAS=OFF
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
DLIB_CONF_OPTS += -DDLIB_WEBP_SUPPORT=ON
DLIB_DEPENDENCIES += webp
else
DLIB_CONF_OPTS += -DDLIB_WEBP_SUPPORT=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
DLIB_CONF_OPTS += -DDLIB_NO_GUI_SUPPORT=OFF
DLIB_DEPENDENCIES += xlib_libX11
else
DLIB_CONF_OPTS += -DDLIB_NO_GUI_SUPPORT=ON
endif

$(eval $(cmake-package))

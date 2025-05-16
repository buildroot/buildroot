################################################################################
#
# qt6multimedia
#
################################################################################

QT6MULTIMEDIA_VERSION = $(QT6_VERSION)
QT6MULTIMEDIA_SITE = $(QT6_SITE)
QT6MULTIMEDIA_SOURCE = qtmultimedia-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6MULTIMEDIA_VERSION).tar.xz
QT6MULTIMEDIA_INSTALL_STAGING = YES
QT6MULTIMEDIA_SUPPORTS_IN_SOURCE_BUILD = NO
QT6MULTIMEDIA_CMAKE_BACKEND = ninja
QT6MULTIMEDIA_LICENSE = GPL-3.0, LGPL-3.0

QT6MULTIMEDIA_LICENSE_FILES = \
	LICENSES/BSD-2-Clause.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/BSD-Source-Code.txt \
	LICENSES/BSL-1.0.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/IJG.txt \
	LICENSES/ISC.txt \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/MIT.txt \
	LICENSES/MPL-2.0.txt \
	LICENSES/Qt-GPL-exception-1.0.txt \
	LICENSES/Zlib.txt \
	src/3rdparty/eigen/COPYING.BSD \
	src/3rdparty/eigen/COPYING.MPL2 \
	src/3rdparty/eigen/COPYRIGHTS \
	src/3rdparty/pffft/COPYRIGHTS \
	src/3rdparty/pffft/LICENSE

QT6MULTIMEDIA_CONF_OPTS = \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_TESTS=OFF \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DFEATURE_gstreamer_gl=OFF

QT6MULTIMEDIA_DEPENDENCIES = \
	qt6base \
	qt6shadertools

# for multimedia quick module
ifeq ($(BR2_PACKAGE_QT6DECLARATIVE),y)
QT6MULTIMEDIA_DEPENDENCIES += qt6declarative
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_ALSA),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_alsa=ON
QT6MULTIMEDIA_DEPENDENCIES += alsa-lib
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_alsa=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_EXAMPLES),y)
QT6MULTIMEDIA_CONF_OPTS += -DQT_BUILD_EXAMPLES=ON
QT6MULTIMEDIA_DEPENDENCIES += qt6svg
else
QT6MULTIMEDIA_CONF_OPTS += -DQT_BUILD_EXAMPLES=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_FFMPEG),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_ffmpeg=ON
QT6MULTIMEDIA_DEPENDENCIES += ffmpeg
# libxext/libxrandr are needed for ffmpeg plugin to build with X11
# support:
# https://code.qt.io/cgit/qt/qtmultimedia.git/tree/src/plugins/multimedia/ffmpeg/CMakeLists.txt?h=6.8.1#n198
ifeq ($(BR2_PACKAGE_XORG7),y)
QT6MULTIMEDIA_DEPENDENCIES += xlib_libXext xlib_libXrandr
endif
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_ffmpeg=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_GSTREAMER),y)
QT6MULTIMEDIA_CONF_OPTS += \
	-DFEATURE_gstreamer=ON \
	-DFEATURE_gstreamer_1_0=ON \
	-DFEATURE_gstreamer_app=ON
QT6MULTIMEDIA_DEPENDENCIES += \
	gst1-plugins-base \
	gstreamer1
else
QT6MULTIMEDIA_CONF_OPTS += \
	-DFEATURE_gstreamer=OFF \
	-DFEATURE_gstreamer_1_0=OFF \
	-DFEATURE_gstreamer_app=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_GST1_PLUGINS_PHOTOGRAPHY),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_gstreamer_photography=ON
QT6MULTIMEDIA_DEPENDENCIES += gst1-plugins-bad
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_gstreamer_photography=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_LINUX_DMA_BUF),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_linux_dmabuf=ON
QT6MULTIMEDIA_DEPENDENCIES += \
	libgbm \
	libegl
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_linux_dmabuf=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_PULSEAUDIO),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_pulseaudio=ON
QT6MULTIMEDIA_DEPENDENCIES += pulseaudio
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_pulseaudio=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_SPATIALAUDIO),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_spatialaudio=ON
ifeq ($(BR2_PACKAGE_QT6QUICK3D),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_spatialaudio_quick3d=ON
QT6MULTIMEDIA_DEPENDENCIES += qt6quick3d
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_spatialaudio_quick3d=OFF
endif

else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_spatialaudio=OFF
endif

ifeq ($(BR2_PACKAGE_QT6MULTIMEDIA_VAAPI),y)
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_vaapi=ON
QT6MULTIMEDIA_DEPENDENCIES += libva
else
QT6MULTIMEDIA_CONF_OPTS += -DFEATURE_vaapi=OFF
endif

$(eval $(cmake-package))

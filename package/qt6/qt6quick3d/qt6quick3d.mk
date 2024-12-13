################################################################################
#
# qt6quick3d
#
################################################################################

QT6QUICK3D_VERSION = $(QT6_VERSION)
QT6QUICK3D_SITE = $(QT6_SITE)
QT6QUICK3D_SOURCE = qtquick3d-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6QUICK3D_VERSION).tar.xz
QT6QUICK3D_INSTALL_STAGING = YES
QT6QUICK3D_SUPPORTS_IN_SOURCE_BUILD = NO
QT6QUICK3D_CMAKE_BACKEND = ninja
QT6QUICK3D_LICENSE = GPL-3.0

QT6QUICK3D_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/MIT.txt \
	src/3rdparty/assimp/LICENSE \
	src/3rdparty/embree/LICENSE.txt \
	src/3rdparty/meshoptimizer/LICENSE.md \
	src/3rdparty/tinyexr/LICENSE \
	src/3rdparty/xatlas/LICENSE \
	src/helpers/GODOT_LICENSE.txt \
	src/runtimerender/GODOT_LICENSE.txt

QT6QUICK3D_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6QUICK3D_DEPENDENCIES = \
	host-qt6quick3d \
	host-qt6shadertools \
	qt6base \
	qt6declarative

ifeq ($(BR2_PACKAGE_ASSIMP),y)
QT6QUICK3D_CONF_OPTS += -DFEATURE_system_assimp=ON
QT6QUICK3D_DEPENDENCIES += assimp
else
QT6QUICK3D_CONF_OPTS += -DFEATURE_system_assimp=OFF
endif

ifeq ($(BR2_PACKAGE_QT6QUICKTIMELINE),y)
QT6QUICK3D_DEPENDENCIES += qt6quicktimeline
endif

ifeq ($(BR2_PACKAGE_QT6SHADERTOOLS),y)
QT6QUICK3D_DEPENDENCIES += qt6shadertools
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
QT6QUICK3D_CONF_OPTS += -DFEATURE_system_zlib=ON
QT6QUICK3D_DEPENDENCIES += zlib
else
QT6QUICK3D_CONF_OPTS += -DFEATURE_system_zlib=OFF
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))

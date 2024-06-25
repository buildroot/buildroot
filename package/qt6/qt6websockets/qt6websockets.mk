################################################################################
#
# qt6websockets
#
################################################################################

QT6WEBSOCKETS_VERSION = $(QT6_VERSION)
QT6WEBSOCKETS_SITE = $(QT6_SITE)
QT6WEBSOCKETS_SOURCE = qtwebsockets-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6WEBSOCKETS_VERSION).tar.xz
QT6WEBSOCKETS_INSTALL_STAGING = YES

QT6WEBSOCKETS_SUPPORTS_IN_SOURCE_BUILD = NO

QT6WEBSOCKETS_CMAKE_BACKEND = ninja

QT6WEBSOCKETS_LICENSE = \
	LGPL-3.0 or GPL-2.0 or GPL-3.0, \
	BSD-3-Clause (examples), \
	GPL-3.0 (tests)

QT6WEBSOCKETS_LICENSE_FILES = \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-3.0-only.txt \
	LICENSES/BSD-3-Clause.txt

QT6WEBSOCKETS_CONF_OPTS = \
	-DQT_FEATURE_thread=ON \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6WEBSOCKETS_DEPENDENCIES = qt6base

ifeq ($(BR2_PACKAGE_QT6DECLARATIVE),y)
QT6WEBSOCKETS_DEPENDENCIES += qt6declarative
endif

$(eval $(cmake-package))

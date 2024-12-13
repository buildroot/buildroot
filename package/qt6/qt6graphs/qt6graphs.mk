################################################################################
#
# qt6graphs
#
################################################################################

QT6GRAPHS_VERSION = $(QT6_VERSION)
QT6GRAPHS_SITE = $(QT6_SITE)
QT6GRAPHS_SOURCE = qtgraphs-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6GRAPHS_VERSION).tar.xz
QT6GRAPHS_INSTALL_STAGING = YES
QT6GRAPHS_SUPPORTS_IN_SOURCE_BUILD = NO
QT6GRAPHS_CMAKE_BACKEND = ninja
QT6GRAPHS_LICENSE = GPL-3.0
QT6GRAPHS_LICENSE_FILES = LICENSES/GPL-3.0-only.txt

QT6GRAPHS_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6GRAPHS_DEPENDENCIES = \
	qt6base \
	qt6declarative \
	qt6quick3d

$(eval $(cmake-package))

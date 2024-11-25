################################################################################
#
# qt6charts
#
################################################################################

QT6CHARTS_VERSION = $(QT6_VERSION)
QT6CHARTS_SITE = $(QT6_SITE)
QT6CHARTS_SOURCE = qtcharts-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6CHARTS_VERSION).tar.xz
QT6CHARTS_INSTALL_STAGING = YES
QT6CHARTS_SUPPORTS_IN_SOURCE_BUILD = NO
QT6CHARTS_CMAKE_BACKEND = ninja
QT6CHARTS_LICENSE = GPL-3.0
QT6CHARTS_LICENSE_FILES = LICENSES/GPL-3.0-only.txt

QT6CHARTS_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6CHARTS_DEPENDENCIES = qt6base

ifeq ($(BR2_PACKAGE_QT6DECLARATIVE),y)
QT6CHARTS_DEPENDENCIES += qt6declarative
endif

$(eval $(cmake-package))

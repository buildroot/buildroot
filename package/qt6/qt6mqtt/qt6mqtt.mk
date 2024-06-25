################################################################################
#
# qt6mqtt
#
################################################################################

QT6MQTT_VERSION = $(QT6_VERSION)
QT6MQTT_SITE = $(QT6_GIT)/qt/qtmqtt.git

QT6MQTT_INSTALL_STAGING = YES

QT6MQTT_SUPPORTS_IN_SOURCE_BUILD = NO

QT6MQTT_CMAKE_BACKEND = ninja

QT6MQTT_LICENSE = \
	BSD-3-Clause (examples), \
	GFDL-1.3-invariants-only (docs), \
	GPL-3.0

QT6MQTT_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-3.0-only.txt

QT6MQTT_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6MQTT_DEPENDENCIES = \
	qt6base

$(eval $(cmake-package))

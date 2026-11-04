################################################################################
#
# qt6coap
#
################################################################################

QT6COAP_VERSION = $(QT6_VERSION)
QT6COAP_SITE = $(QT6_GIT)/qt/qtcoap.git

QT6COAP_INSTALL_STAGING = YES

QT6COAP_SUPPORTS_IN_SOURCE_BUILD = NO

QT6COAP_CMAKE_BACKEND = ninja

QT6COAP_LICENSE = \
	BSD-3-Clause (examples), \
	GFDL-1.3-invariants-only (docs), \
	GPL-3.0

QT6COAP_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-3.0-only.txt

QT6COAP_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF \
	-DQT_BUILD_EXAMPLES=OFF \
	-DQT_BUILD_TESTS=OFF

QT6COAP_DEPENDENCIES = \
	qt6base

$(eval $(cmake-package))

################################################################################
#
# qt6opcua
#
################################################################################

QT6OPCUA_VERSION = $(QT6_VERSION)
QT6OPCUA_SITE = $(QT6_GIT)/qt/qtopcua.git
QT6OPCUA_SITE_METHOD = git
QT6OPCUA_INSTALL_STAGING = YES
QT6OPCUA_SUPPORTS_IN_SOURCE_BUILD = NO

QT6OPCUA_CMAKE_BACKEND = ninja

QT6OPCUA_LICENSE = \
	GPL-2.0 or GPL-3.0 or LGPL-3.0, \
	GFDL-1.3 no invariants (docs), \
	BSD-3-Clause (examples + buildsystem)

QT6OPCUA_LICENSE_FILES = \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/GFDL-1.3-no-invariants-only.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/GPL-3.0-only.txt \
	LICENSES/LGPL-3.0-only.txt

QT6OPCUA_CONF_OPTS = \
	-DQT_HOST_PATH=$(HOST_DIR) \
	-DBUILD_WITH_PCH=OFF

QT6OPCUA_DEPENDENCIES = \
	qt6base \
	host-qt6opcua

ifeq ($(BR2_PACKAGE_OPENSSL),y)
QT6OPCUA_DEPENDENCIES += openssl
endif

$(eval $(cmake-package))
$(eval $(host-cmake-package))

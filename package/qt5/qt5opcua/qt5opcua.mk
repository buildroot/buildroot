################################################################################
#
# qt5opcua
#
################################################################################

QT5OPCUA_VERSION = 5.15.2
QT5OPCUA_SITE = https://code.qt.io/qt/qtopcua.git
QT5OPCUA_SITE_METHOD = git
QT5OPCUA_INSTALL_STAGING = YES
QT5OPCUA_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs) CC0-1.0
QT5OPCUA_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPLv3 LICENSE.FDL LICENSE-CC0
QT5OPCUA_SYNC_QT_HEADERS = YES

ifeq ($(BR2_PACKAGE_MBEDTLS),y)
QT5OPCUA_DEPENDENCIES += mbedtls
endif

$(eval $(qmake-package))

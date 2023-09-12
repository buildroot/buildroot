################################################################################
#
# qt5coap
#
################################################################################

QT5COAP_VERSION = 5.15.2
QT5COAP_SITE = https://code.qt.io/qt/qtcoap.git
QT5COAP_SITE_METHOD = git
QT5COAP_INSTALL_STAGING = YES
QT5COAP_LICENSE = GPL-3.0, GFDL-1.3
QT5COAP_LICENSE_FILES = LICENSE.GPL3 LICENSE.FDL
QT5COAP_SYNC_QT_HEADERS = YES

$(eval $(qmake-package))

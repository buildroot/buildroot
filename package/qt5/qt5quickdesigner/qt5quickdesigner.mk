################################################################################
#
# qt5quickdesigner
#
################################################################################

QT5QUICKDESIGNER_VERSION = 57ac8b13654796256e6a20913d74e6bca2965a14 
QT5QUICKDESIGNER_SITE = https://github.com/qt-labs/qtquickdesigner-components.git
QT5QUICKDESIGNER_SITE_METHOD = git
#QT5QUICKDESIGNER_INSTALL_STAGING = YES
QT5QUICKDESIGNER_INSTALL_TARGET = YES

#QT5QUICKDESIGNER_LICENSE = GPL-3.0, GFDL-1.3 (docs)
#QT5QUICKDESIGNER_LICENSE_FILES = LICENSE.GPL3

$(eval $(qmake-package))

################################################################################
#
# qt5quickcontrols2
#
################################################################################

QT5QUICKCONTROLS2_VERSION = 1ce461bd1dc713cd2f79fc16c5454d587b45eefa
QT5QUICKCONTROLS2_SITE = $(QT5_SITE)/qtquickcontrols2/-/archive/$(QT5QUICKCONTROLS2_VERSION)
QT5QUICKCONTROLS2_SOURCE = qtquickcontrols2-$(QT5QUICKCONTROLS2_VERSION).tar.bz2
QT5QUICKCONTROLS2_DEPENDENCIES = qt5declarative
QT5QUICKCONTROLS2_INSTALL_STAGING = YES
QT5QUICKCONTROLS2_SYNC_QT_HEADERS = YES

QT5QUICKCONTROLS2_LICENSE = GPL-3.0 or LGPL-3.0, GFDL-1.3 (docs)
QT5QUICKCONTROLS2_LICENSE_FILES = LICENSE.GPLv3 LICENSE.LGPLv3 LICENSE.FDL

$(eval $(qmake-package))

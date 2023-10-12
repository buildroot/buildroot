################################################################################
#
# qt5webview
#
################################################################################

QT5WEBVIEW_VERSION = f078642eb9a440f6aa88f2beaf10f445de1e29bb
QT5WEBVIEW_SITE = $(QT5_SITE)/qtwebview/-/archive/$(QT5WEBVIEW_VERSION)
QT5WEBVIEW_SOURCE = qtwebview-$(QT5WEBVIEW_VERSION).tar.bz2
QT5WEBVIEW_DEPENDENCIES = qt5webengine
QT5WEBVIEW_INSTALL_STAGING = YES
QT5WEBVIEW_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0, GFDL-1.3 (docs)
QT5WEBVIEW_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPLv3 LICENSE.LGPLv3 LICENSE.FDL
QT5WEBVIEW_SYNC_QT_HEADERS = YES

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5WEBVIEW_LICENSE += , BSD-3-Clause (examples)
endif

$(eval $(qmake-package))

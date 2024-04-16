################################################################################
#
# qt5charts
#
################################################################################

QT5CHARTS_VERSION = e17308d5ce83a8b66aeeaaaf16ce16d4ee6b2826
QT5CHARTS_SITE = $(QT5_SITE)/qtcharts/-/archive/$(QT5CHARTS_VERSION)
QT5CHARTS_SOURCE = qtcharts-$(QT5CHARTS_VERSION).tar.bz2
QT5CHARTS_INSTALL_STAGING = YES
QT5CHARTS_SYNC_QT_HEADERS = YES

QT5CHARTS_LICENSE = GPL-3.0
QT5CHARTS_LICENSE_FILES = LICENSE.GPL3

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5CHARTS_DEPENDENCIES += qt5declarative
endif

$(eval $(qmake-package))

################################################################################
#
# qt5lottie
#
################################################################################

QT5LOTTIE_VERSION = 5f1be885cf4ee0f1eb5400bf0c5d138818fc01d0
QT5LOTTIE_SITE = $(QT5_SITE)/qtlottie/-/archive/$(QT5LOTTIE_VERSION)
QT5LOTTIE_SOURCE = qtlottie-$(QT5LOTTIE_VERSION).tar.bz2
QT5LOTTIE_DEPENDENCIES = qt5declarative
QT5LOTTIE_INSTALL_STAGING = YES
QT5LOTTIE_SYNC_QT_HEADERS = YES

QT5LOTTIE_LICENSE = GPL-3.0
QT5LOTTIE_LICENSE_FILES = LICENSE.GPL3 LICENSE.GPL3-EXCEPT

$(eval $(qmake-package))

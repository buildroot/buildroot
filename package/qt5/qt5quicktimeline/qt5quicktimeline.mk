################################################################################
#
# qt5quicktimeline
#
################################################################################

QT5QUICKTIMELINE_VERSION = 43130f2681b76a8d743a04704465b716b6b2faee
QT5QUICKTIMELINE_SITE = $(QT5_SITE)/qtquicktimeline/-/archive/$(QT5QUICKTIMELINE_VERSION)
QT5QUICKTIMELINE_SOURCE = qtquicktimeline-$(QT5QUICKTIMELINE_VERSION).tar.bz2
QT5QUICKTIMELINE_DEPENDENCIES = qt5declarative
QT5QUICKTIMELINE_INSTALL_STAGING = YES
QT5QUICKTIMELINE_SYNC_QT_HEADERS = YES

QT5QUICKTIMELINE_LICENSE = GPL-3.0, GFDL-1.3 (docs)
QT5QUICKTIMELINE_LICENSE_FILES = LICENSE.GPL3

$(eval $(qmake-package))

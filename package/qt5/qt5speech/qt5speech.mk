################################################################################
#
# qt5speech
#
################################################################################

QT5SPEECH_VERSION = 214dcefc7c408e11a3e9fe9d221e4a384e2eaca1
QT5SPEECH_SITE = $(QT5_SITE)/qtspeech/-/archive/$(QT5SPEECH_VERSION)
QT5SPEECH_SOURCE = qtspeech-$(QT5SPEECH_VERSION).tar.bz2
QT5SPEECH_INSTALL_STAGING = YES
QT5SPEECH_LICENSE = GPL-2.0+ or LGPL-3.0, GFDL-1.3 (docs)
QT5SPEECH_LICENSE_FILES = LICENSE.GPLv2 LICENSE.LGPLv3 LICENSE.FDL
QT5SPEECH_SYNC_QT_HEADERS = YES

ifeq ($(BR2_PACKAGE_FLITE),y)
QT5SPEECH_DEPENDENCIES += flite
endif

ifeq ($(BR2_PACKAGE_SPEECHD),y)
QT5SPEECH_DEPENDENCIES += speechd
endif

$(eval $(qmake-package))

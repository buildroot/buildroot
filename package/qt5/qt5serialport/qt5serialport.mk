################################################################################
#
# qt5serialport
#
################################################################################

QT5SERIALPORT_VERSION = b64a7eeda9b6a65b5ed01b1b40b07177f0aa4c0f
QT5SERIALPORT_SITE = $(QT5_SITE)/qtserialport/-/archive/$(QT5SERIALPORT_VERSION)
QT5SERIALPORT_SOURCE = qtserialport-$(QT5SERIALPORT_VERSION).tar.bz2
QT5SERIALPORT_INSTALL_STAGING = YES
QT5SERIALPORT_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5SERIALPORT_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
QT5SERIALPORT_SYNC_QT_HEADERS = YES

$(eval $(qmake-package))

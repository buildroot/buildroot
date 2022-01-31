################################################################################
#
# qt5websockets
#
################################################################################

QT5WEBSOCKETS_VERSION = b13b56904b76e96ea52d0efe56395acc94b17d96
QT5WEBSOCKETS_SITE = $(QT5_SITE)/qtwebsockets/-/archive/$(QT5WEBSOCKETS_VERSION)
QT5WEBSOCKETS_SOURCE = qtwebsockets-$(QT5WEBSOCKETS_VERSION).tar.bz2
QT5WEBSOCKETS_INSTALL_STAGING = YES
QT5WEBSOCKETS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
QT5WEBSOCKETS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3
QT5WEBSOCKETS_SYNC_QT_HEADERS = YES

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
QT5WEBSOCKETS_LICENSE += , BSD-3-Clause (examples)
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5WEBSOCKETS_DEPENDENCIES += qt5declarative
endif

$(eval $(qmake-package))

################################################################################
#
# qt5x11extras
#
################################################################################

QT5X11EXTRAS_VERSION = 3898f5484fd4864b047729bfeda9a1222f32364f
QT5X11EXTRAS_SITE = $(QT5_SITE)/qtx11extras/-/archive/$(QT5X11EXTRAS_VERSION)
QT5X11EXTRAS_SOURCE = qtx11extras-$(QT5X11EXTRAS_VERSION).tar.bz2
QT5X11EXTRAS_INSTALL_STAGING = YES
QT5X11EXTRAS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5X11EXTRAS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
QT5X11EXTRAS_SYNC_QT_HEADERS = YES

$(eval $(qmake-package))

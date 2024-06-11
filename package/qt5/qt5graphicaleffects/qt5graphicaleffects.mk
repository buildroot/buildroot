################################################################################
#
# qt5graphicaleffects
#
################################################################################

QT5GRAPHICALEFFECTS_VERSION = 2c39e673d6c15a84dcc7882d3772fa04cc79f9ed
QT5GRAPHICALEFFECTS_SITE = $(QT5_SITE)/qtgraphicaleffects/-/archive/$(QT5GRAPHICALEFFECTS_VERSION)
QT5GRAPHICALEFFECTS_SOURCE = qtgraphicaleffects-$(QT5GRAPHICALEFFECTS_VERSION).tar.bz2
QT5GRAPHICALEFFECTS_DEPENDENCIES = qt5declarative
QT5GRAPHICALEFFECTS_INSTALL_STAGING = YES
QT5GRAPHICALEFFECTS_SYNC_QT_HEADERS = YES

QT5GRAPHICALEFFECTS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5GRAPHICALEFFECTS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL

$(eval $(qmake-package))

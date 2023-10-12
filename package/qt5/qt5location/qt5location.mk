################################################################################
#
# qt5location
#
################################################################################

QT5LOCATION_VERSION = 0ec8f5e82da7369a92824167c4d7331f6c502325
QT5LOCATION_SITE = $(QT5_SITE)/qtlocation
QT5LOCATION_SITE_METHOD = git
QT5LOCATION_GIT_SUBMODULES = YES
QT5LOCATION_INSTALL_STAGING = YES
QT5LOCATION_SYNC_QT_HEADERS = YES

QT5LOCATION_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5LOCATION_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5LOCATION_DEPENDENCIES += qt5declarative
endif

$(eval $(qmake-package))

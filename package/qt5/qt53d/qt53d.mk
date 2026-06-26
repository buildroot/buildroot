################################################################################
#
# qt53d
#
################################################################################

QT53D_VERSION = 208f5835e6c2415c9dc5cbe92bba83aa28bab7ea
QT53D_SITE = $(QT5_SITE)/qt3d/-/archive/$(QT53D_VERSION)
QT53D_SOURCE = qt3d-$(QT53D_VERSION).tar.bz2
QT53D_DEPENDENCIES = qt5declarative
QT53D_INSTALL_STAGING = YES
QT53D_SYNC_QT_HEADERS = YES

# command line argument separator
QT53D_CONF_OPTS = --

# Assimp support is broken with both Buildroot assimp and the assimp module in
# the qt53d sources, therefore disable it for now.
QT53D_CONF_OPTS += \
	-no-feature-assimp

QT53D_LICENSE = GPL-2.0 or GPL-3.0 or LGPL-3.0
QT53D_LICENSE_FILES = LICENSE.GPL LICENSE.GPLv3 LICENSE.LGPLv3

$(eval $(qmake-package))

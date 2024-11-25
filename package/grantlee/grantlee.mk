################################################################################
#
# grantlee
#
################################################################################

GRANTLEE_VERSION = 5.3.1
GRANTLEE_SITE = $(call github,steveire,grantlee,v$(GRANTLEE_VERSION))
GRANTLEE_INSTALL_STAGING = YES
GRANTLEE_LICENSE = LGPL-2.1+
GRANTLEE_LICENSE_FILES = COPYING.LIB

ifeq ($(BR2_PACKAGE_QT5BASE),y)
GRANTLEE_DEPENDENCIES += qt5base qt5script
else ifeq ($(BR2_PACKAGE_QT6BASE),y)
GRANTLEE_DEPENDENCIES += qt6base qt6declarative
GRANTLEE_CONF_OPTS += -DGRANTLEE_BUILD_WITH_QT6=ON
endif

$(eval $(cmake-package))

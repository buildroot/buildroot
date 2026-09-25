################################################################################
#
# cutekeyboard
#
################################################################################

CUTEKEYBOARD_VERSION = 1.7.0
CUTEKEYBOARD_SITE = $(call github,amarula,cutekeyboard,v$(CUTEKEYBOARD_VERSION))
ifeq ($(BR2_PACKAGE_QT5),y)
CUTEKEYBOARD_DEPENDENCIES += qt5declarative qt5quickcontrols2
else
CUTEKEYBOARD_DEPENDENCIES += qt6declarative
endif
CUTEKEYBOARD_INSTALL_STAGING = YES
CUTEKEYBOARD_LICENSE = MIT
CUTEKEYBOARD_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_CUTEKEYBOARD_EXAMPLES),y)
CUTEKEYBOARD_CONF_OPTS += CONFIG+=BUILD_EXAMPLES
endif

$(eval $(qmake-package))

################################################################################
#
# cutekeyboard
#
################################################################################

CUTEKEYBOARD_VERSION = v1.3.0
CUTEKEYBOARD_SITE = $(call github,amarula,cutekeyboard,$(CUTEKEYBOARD_VERSION))
CUTEKEYBOARD_DEPENDENCIES = qt5declarative qt5quickcontrols2
CUTEKEYBOARD_INSTALL_STAGING = YES
CUTEKEYBOARD_LICENSE = MIT
CUTEKEYBOARD_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_CUTEKEYBOARD_EXAMPLES),y)
CUTEKEYBOARD_CONF_OPTS += CONFIG+=BUILD_EXAMPLES
endif

$(eval $(qmake-package))

################################################################################
#
# simple-mail
#
################################################################################

SIMPLE_MAIL_VERSION = 3.1.0
SIMPLE_MAIL_SITE = $(call github,cutelyst,simple-mail,v$(SIMPLE_MAIL_VERSION))
SIMPLE_MAIL_INSTALL_STAGING = YES
SIMPLE_MAIL_LICENSE = LGPL-2.1+
SIMPLE_MAIL_LICENSE_FILES = LICENSE
SIMPLE_MAIL_CONF_OPTS = -DBUILD_DEMOS=OFF
ifeq ($(BR2_PACKAGE_QT5BASE),y)
SIMPLE_MAIL_DEPENDENCIES += qt5base
else ifeq ($(BR2_PACKAGE_QT6BASE),y)
SIMPLE_MAIL_DEPENDENCIES += qt6base
SIMPLE_MAIL_CONF_OPTS += -DQT_VERSION_MAJOR=6
endif

$(eval $(cmake-package))

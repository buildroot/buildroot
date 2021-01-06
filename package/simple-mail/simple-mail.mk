################################################################################
#
# simple-mail
#
################################################################################

SIMPLE_MAIL_VERSION = 2.3.0
SIMPLE_MAIL_SITE = $(call github,cutelyst,simple-mail,v$(SIMPLE_MAIL_VERSION))
SIMPLE_MAIL_INSTALL_STAGING = YES
SIMPLE_MAIL_LICENSE = LGPL-2.1+
SIMPLE_MAIL_LICENSE_FILES = LICENSE
SIMPLE_MAIL_DEPENDENCIES = qt5base
SIMPLE_MAIL_CONF_OPTS = -DBUILD_DEMOS=OFF

$(eval $(cmake-package))

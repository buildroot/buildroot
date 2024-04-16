################################################################################
#
# termcolor
#
################################################################################

TERMCOLOR_VERSION = 2.1.0
TERMCOLOR_SITE = $(call github,ikalnytskyi,termcolor,v$(TERMCOLOR_VERSION))
TERMCOLOR_LICENSE = BSD-3-Clause
TERMCOLOR_LICENSE_FILES = LICENSE
TERMCOLOR_INSTALL_STAGING = YES
TERMCOLOR_INSTALL_TARGET = NO

$(eval $(cmake-package))

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
GRANTLEE_DEPENDENCIES = qt5base qt5script

$(eval $(cmake-package))

################################################################################
#
# dotconf
#
################################################################################

DOTCONF_VERSION = 1.3
DOTCONF_SITE = $(call github,williamh,dotconf,v$(DOTCONF_VERSION))
DOTCONF_LICENSE = LGPL-2.1
DOTCONF_LICENSE_FILES = COPYING
DOTCONF_INSTALL_STAGING = YES
# dotconf source code is released without configure script
DOTCONF_AUTORECONF = YES

$(eval $(autotools-package))

################################################################################
#
# log4c
#
################################################################################

LOG4C_VERSION = 1.2.4
LOG4C_SOURCE = log4c-$(LOG4C_VERSION).tar.gz
LOG4C_SITE = https://sourceforge.net/projects/log4c/files/log4c/$(LOG4C_VERSION)/
LOG4C_LICENSE = LGPL-2.1
LOG4C_LICENSE_FILES = COPYING
LOG4C_INSTALL_STAGING = YES

$(eval $(autotools-package))

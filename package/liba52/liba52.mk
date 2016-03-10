################################################################################
#
# liba52
#
################################################################################

LIBA52_VERSION = 0.7.4
LIBA52_SITE = http://liba52.sourceforge.net/files
LIBA52_SOURCE = a52dec-$(LIBA52_VERSION).tar.gz
LIBA52_LICENSE = GPL
LIBA52_LICENSE_FILES = COPYING
LIBA52_INSTALL_STAGING = YES
LIBA52_AUTORECONF = YES

$(eval $(autotools-package))

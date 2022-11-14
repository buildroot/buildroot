################################################################################
#
# catatonit
#
################################################################################

CATATONIT_VERSION = 0.1.7
CATATONIT_SITE = $(call github,openSUSE,catatonit,v$(CATATONIT_VERSION))
CATATONIT_LICENSE = GPL-3.0+
CATATONIT_LICENSE_FILES = COPYING

CATATONIT_AUTORECONF = YES

$(eval $(autotools-package))

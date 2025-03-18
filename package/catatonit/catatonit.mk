################################################################################
#
# catatonit
#
################################################################################

CATATONIT_VERSION = 0.2.1
CATATONIT_SITE = $(call github,openSUSE,catatonit,v$(CATATONIT_VERSION))
CATATONIT_LICENSE = GPL-2.0+
CATATONIT_LICENSE_FILES = COPYING

CATATONIT_AUTORECONF = YES

$(eval $(autotools-package))

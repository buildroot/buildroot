################################################################################
#
# genext2fs
#
################################################################################

GENEXT2FS_VERSION = 1.5.0
GENEXT2FS_SITE = $(call github,bestouff,genext2fs,v$(GENEXT2FS_VERSION))
GENEXT2FS_LICENSE = GPL-2.0
GENEXT2FS_LICENSE_FILES = COPYING
# From git
GENEXT2FS_AUTORECONF = YES

$(eval $(autotools-package))
$(eval $(host-autotools-package))

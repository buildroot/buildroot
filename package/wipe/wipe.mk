################################################################################
#
# wipe
#
################################################################################

WIPE_VERSION = 2.3.1
WIPE_SITE = http://downloads.sourceforge.net/project/wipe/wipe/$(WIPE_VERSION)
WIPE_SOURCE = wipe-$(WIPE_VERSION).tar.bz2
WIPE_LICENSE = GPL-2.0+
WIPE_LICENSE_FILES = LICENSE
# configure script not compatible with >= gcc-15
WIPE_AUTORECONF = YES

define WIPE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/wipe $(TARGET_DIR)/usr/bin/wipe
endef

$(eval $(autotools-package))

################################################################################
#
# collectl
#
################################################################################

COLLECTL_VERSION = 4.3.20.1
COLLECTL_SITE = $(call github,sharkcz,collectl,$(COLLECTL_VERSION))
COLLECTL_LICENSE = Artistic or GPL-2.0
COLLECTL_LICENSE_FILES = COPYING ARTISTIC GPL

define COLLECTL_INSTALL_TARGET_CMDS
	(cd $(@D); \
		DESTDIR=$(TARGET_DIR) ./INSTALL)
endef

$(eval $(generic-package))

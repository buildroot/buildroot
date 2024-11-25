################################################################################
#
# iotools
#
################################################################################

IOTOOLS_VERSION = 1.8
IOTOOLS_SITE = $(call github,andy-shev,iotools,v$(IOTOOLS_VERSION))
IOTOOLS_LICENSE = GPL-2.0+
IOTOOLS_LICENSE_FILES = COPYING

IOTOOLS_MAKE_OPTS = \
	CROSS_COMPILE=$(TARGET_CROSS)

ifeq ($(BR2_STATIC_LIBS),y)
IOTOOLS_MAKE_OPTS += STATIC=1
else
IOTOOLS_MAKE_OPTS += STATIC=0
endif

define IOTOOLS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(IOTOOLS_MAKE_OPTS) all
endef

define IOTOOLS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/iotools $(TARGET_DIR)/usr/bin/iotools
endef

$(eval $(generic-package))

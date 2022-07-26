################################################################################
#
# fscryptctl
#
################################################################################

FSCRYPTCTL_VERSION = 1.0.0
FSCRYPTCTL_SITE = $(call github,google,fscryptctl,v$(FSCRYPTCTL_VERSION))
FSCRYPTCTL_LICENSE = Apache-2.0
FSCRYPTCTL_LICENSE_FILES = LICENSE

define FSCRYPTCTL_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -std=c99" fscryptctl
endef

define FSCRYPTCTL_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/fscryptctl $(TARGET_DIR)/usr/bin/fscryptctl
endef

$(eval $(generic-package))

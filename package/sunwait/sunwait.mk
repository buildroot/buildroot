################################################################################
#
# sunwait
#
################################################################################

SUNWAIT_VERSION = 0.9.1
SUNWAIT_SITE = $(call github,risacher,sunwait,$(SUNWAIT_VERSION))
SUNWAIT_LICENSE = GPL-3.0
SUNWAIT_LICENSE_FILES = LICENSE

SUNWAIT_MAKE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	CFLAGS="$(TARGET_CFLAGS) -c" \
	LDFLAGS="$(TARGET_LDFLAGS) -lm"

define SUNWAIT_BUILD_CMDS
	$(MAKE) $(SUNWAIT_MAKE_OPTS) -C $(@D) all
endef

define SUNWAIT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sunwait $(TARGET_DIR)/usr/bin/sunwait
endef

$(eval $(generic-package))

################################################################################
#
# cpulimit
#
################################################################################

CPULIMIT_VERSION = 0.2
CPULIMIT_SITE = $(call github,opsengine,cpulimit,v$(CPULIMIT_VERSION))
CPULIMIT_LICENSE = GPL-2.0+
CPULIMIT_LICENSE_FILES = LICENSE

define CPULIMIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		CFLAGS="$(TARGET_CFLAGS) -D_GNU_SOURCE" \
		LDLIBS="$(TARGET_LDFLAGS)"
endef

define CPULIMIT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/cpulimit \
		$(TARGET_DIR)/usr/bin/cpulimit
endef

$(eval $(generic-package))

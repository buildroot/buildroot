################################################################################
#
# snooze
#
################################################################################

SNOOZE_VERSION = 0.5
SNOOZE_SITE = $(call github,leahneukirchen,snooze,v$(SNOOZE_VERSION))
SNOOZE_LICENSE = CC0-1.0

# Unfortunately, snooze doesn't have a dedicated file for the license, but it
# is mentioned in the README and in the manpage.
SNOOZE_LICENSE_FILES = README.md

SNOOZE_MAKE_OPTS = \
	PREFIX=/usr \
	CC=$(TARGET_CC) \
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_LDFLAGS)"

define SNOOZE_BUILD_CMDS
	$(MAKE) -C $(@D)/ $(SNOOZE_MAKE_OPTS)
endef

define SNOOZE_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D)/ $(SNOOZE_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

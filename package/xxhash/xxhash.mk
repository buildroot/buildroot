################################################################################
#
# xxhash
#
################################################################################

XXHASH_VERSION = 0.8.1
XXHASH_SITE = $(call github,Cyan4973,xxHash,v$(XXHASH_VERSION))
XXHASH_LICENSE = BSD-2-Clause (library), GPL-2.0+ (xxhsum)
XXHASH_LICENSE_FILES = LICENSE cli/COPYING
XXHASH_INSTALL_STAGING = YES

XXHASH_TARGETS = xxhsum
XXHASH_INSTALL_TARGETS = install_xxhsum

ifeq ($(BR2_STATIC_LIBS),y)
XXHASH_TARGETS += libxxhash.a libxxhash.pc
XXHASH_INSTALL_TARGETS += \
	install_libxxhash.a \
	install_libxxhash.includes \
	install_libxxhash.pc
else ifeq ($(BR2_SHARED_LIBS),y)
XXHASH_TARGETS += libxxhash libxxhash.pc
XXHASH_INSTALL_TARGETS += \
	install_libxxhash \
	install_libxxhash.includes \
	install_libxxhash.pc
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
XXHASH_TARGETS += libxxhash.a libxxhash libxxhash.pc
XXHASH_INSTALL_TARGETS += \
	install_libxxhash.a \
	install_libxxhash \
	install_libxxhash.includes \
	install_libxxhash.pc
endif

define XXHASH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		$(XXHASH_TARGETS)
endef

define XXHASH_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr DESTDIR=$(STAGING_DIR) $(XXHASH_INSTALL_TARGETS)
endef

define XXHASH_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) $(XXHASH_INSTALL_TARGETS)
endef

$(eval $(generic-package))

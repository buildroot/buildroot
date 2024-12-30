################################################################################
#
# xxhash
#
################################################################################

XXHASH_VERSION = 0.8.3
XXHASH_SITE = $(call github,Cyan4973,xxHash,v$(XXHASH_VERSION))
XXHASH_LICENSE = BSD-2-Clause (library), GPL-2.0+ (xxhsum)
XXHASH_LICENSE_FILES = LICENSE cli/COPYING
XXHASH_INSTALL_STAGING = YES

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_XXHASH_ADD_CCACHE_DEPENDENCY = NO

XXHASH_TARGETS = xxhsum libxxhash.pc
XXHASH_INSTALL_TARGETS = \
	install_libxxhash.includes \
	install_libxxhash.pc \
	install_xxhsum

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
XXHASH_TARGETS += libxxhash.a
XXHASH_INSTALL_TARGETS += install_libxxhash.a
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
XXHASH_TARGETS += libxxhash
XXHASH_INSTALL_TARGETS += install_libxxhash
endif

define XXHASH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		MOREFLAGS=-DXXH_NO_INLINE_HINTS $(XXHASH_TARGETS)
endef

define XXHASH_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr DESTDIR=$(STAGING_DIR) $(XXHASH_INSTALL_TARGETS)
endef

define XXHASH_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) $(XXHASH_INSTALL_TARGETS)
endef

# we are a ccache dependency, so we can't use ccache
HOST_XXHASH_ENV = $(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) CC="$(HOSTCC_NOCCACHE)" CXX="$(HOSTCXX_NOCCACHE)"
HOST_XXHASH_OPTS += DESTDIR=$(HOST_DIR) PREFIX=/usr

define HOST_XXHASH_BUILD_CMDS
	$(HOST_XXHASH_ENV) $(MAKE) $(HOST_XXHASH_OPTS) -C $(@D)
endef

define HOST_XXHASH_INSTALL_CMDS
	$(HOST_XXHASH_ENV) $(MAKE) $(HOST_XXHASH_OPTS) -C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

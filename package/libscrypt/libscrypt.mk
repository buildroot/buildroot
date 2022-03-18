################################################################################
#
# libscrypt
#
################################################################################

LIBSCRYPT_VERSION = 1.22
LIBSCRYPT_SITE = $(call github,technion,libscrypt,v$(LIBSCRYPT_VERSION))
LIBSCRYPT_LICENSE = BSD-2-Clause
LIBSCRYPT_LICENSE_FILES = LICENSE
LIBSCRYPT_INSTALL_STAGING = YES

LIBSCRYPT_MAKE_OPTS = \
	CC=$(TARGET_CC) \
	CFLAGS_EXTRA="$(TARGET_CFLAGS)" \
	LDFLAGS_EXTRA="$(TARGET_LDFLAGS)" \
	PREFIX=/usr

define LIBSCRYPT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LIBSCRYPT_MAKE_OPTS)
endef

define LIBSCRYPT_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LIBSCRYPT_MAKE_OPTS) \
		DESTDIR=$(STAGING_DIR) install
endef

define LIBSCRYPT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(LIBSCRYPT_MAKE_OPTS) \
		DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

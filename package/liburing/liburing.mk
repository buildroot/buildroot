################################################################################
#
# liburing
#
################################################################################

LIBURING_VERSION = 2.1
LIBURING_SOURCE = liburing-$(LIBURING_VERSION).tar.bz2
LIBURING_SITE = https://git.kernel.dk/cgit/liburing/snapshot
LIBURING_LICENSE = (GPL-2.0 with exceptions and LGPL-2.1+) or MIT
LIBURING_LICENSE_FILES = COPYING COPYING.GPL LICENSE README
LIBURING_INSTALL_STAGING = YES

define LIBURING_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_IO_URING)
endef

ifeq ($(BR2_STATIC_LIBS),y)
LIBURING_MAKE_OPTS += ENABLE_SHARED=0
else
LIBURING_MAKE_OPTS += ENABLE_SHARED=1
endif

define LIBURING_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_CONFIGURE_OPTS) ./configure)
endef

define LIBURING_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(LIBURING_MAKE_OPTS) -C $(@D)/src
endef

define LIBURING_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(LIBURING_MAKE_OPTS) -C $(@D) \
		DESTDIR=$(STAGING_DIR) install
endef

define LIBURING_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(LIBURING_MAKE_OPTS) -C $(@D) \
		DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

################################################################################
#
# libdeflate
#
################################################################################

LIBDEFLATE_VERSION = 1.12
LIBDEFLATE_SITE = $(call github,ebiggers,libdeflate,v$(LIBDEFLATE_VERSION))
LIBDEFLATE_LICENSE = MIT
LIBDEFLATE_LICENSE_FILES = COPYING
LIBDEFLATE_INSTALL_STAGING = YES

ifeq ($(BR2_STATIC_LIBS),y)
LIBDEFLATE_MAKE_OPTS += DISABLE_SHARED=yes
endif

define LIBDEFLATE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		$(LIBDEFLATE_MAKE_OPTS)
endef

define LIBDEFLATE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		$(LIBDEFLATE_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" PREFIX=/usr install
endef

define LIBDEFLATE_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		$(LIBDEFLATE_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" PREFIX=/usr install
endef

$(eval $(generic-package))

################################################################################
#
# lsof
#
################################################################################

LSOF_VERSION = 4.99.4
LSOF_SITE = $(call github,lsof-org,lsof,$(LSOF_VERSION))
LSOF_LICENSE = lsof license
LSOF_LICENSE_FILES = COPYING
LSOF_CPE_ID_VALID = YES

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
LSOF_DEPENDENCIES += libtirpc
endif

ifeq ($(BR2_USE_WCHAR),)
define LSOF_CONFIGURE_WCHAR_FIXUPS
	$(SED) 's,^#[[:space:]]*define HASWIDECHAR.*,#undef HASWIDECHAR,' \
		$(@D)/machine.h
endef
endif

ifeq ($(BR2_ENABLE_LOCALE),)
define LSOF_CONFIGURE_LOCALE_FIXUPS
	$(SED) 's,^#[[:space:]]*define HASSETLOCALE.*,#undef HASSETLOCALE,' \
		$(@D)/machine.h
endef
endif

define LSOF_CONFIGURE_CMDS
	(cd $(@D) ; \
		echo n | $(TARGET_CONFIGURE_OPTS) DEBUG="$(TARGET_CFLAGS)" \
		LSOF_AR="$(TARGET_AR) cr" LSOF_CC="$(TARGET_CC)" \
		LSOF_INCLUDE="$(STAGING_DIR)/usr/include" \
		LINUX_CLIB=-DGLIBCV=2 LSOF_CFGL="$(TARGET_LDFLAGS)" \
		./Configure linux)
	$(LSOF_CONFIGURE_WCHAR_FIXUPS)
	$(LSOF_CONFIGURE_LOCALE_FIXUPS)
endef

define LSOF_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LSOF_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/lsof $(TARGET_DIR)/usr/bin/lsof
endef

$(eval $(generic-package))

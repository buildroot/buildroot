################################################################################
#
# efivar
#
################################################################################

EFIVAR_VERSION = 39
EFIVAR_SITE = $(call github,rhboot,efivar,$(EFIVAR_VERSION))
EFIVAR_LICENSE = LGPL-2.1
EFIVAR_LICENSE_FILES = COPYING
EFIVAR_INSTALL_STAGING = YES
EFIVAR_DEPENDENCIES = host-efivar

# -fPIC is needed at least on MIPS, otherwise fails to build shared
# -library.
# SUBDIRS is redefined so it skips building docs.
# LD_DASH_T is redefined as the linker detection does not seem to
# work properly for cross-compilation.
EFIVAR_MAKE_OPTS = \
	libdir=/usr/lib \
	LDFLAGS="$(TARGET_LDFLAGS) -fPIC" \
	TOPDIR=$(@D) \
	SUBDIRS=src \
	LD_DASH_T=-T

define HOST_EFIVAR_BUILD_CMDS
	# makeguids is an internal host tool and must be built separately with
	# $(HOST_CC), otherwise it gets cross-built.
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) \
		CFLAGS="$(HOST_CFLAGS) -std=gnu99" \
		TOPDIR=$(@D) CFLAGS_GCC= \
		$(MAKE) -C $(@D)/src makeguids
endef

define EFIVAR_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) \
		$(EFIVAR_MAKE_OPTS) \
		all
endef

define HOST_EFIVAR_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/makeguids $(HOST_DIR)/bin/makeguids
endef

define EFIVAR_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) \
		$(EFIVAR_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" \
		install
endef

define EFIVAR_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) \
		$(EFIVAR_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" \
		install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

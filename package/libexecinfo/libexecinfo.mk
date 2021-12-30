################################################################################
#
# libexecinfo
#
################################################################################

LIBEXECINFO_VERSION = 1.1-3
LIBEXECINFO_SITE = $(call github,mikroskeem,libexecinfo,$(LIBEXECINFO_VERSION))
LIBEXECINFO_LICENSE = BSD-2-Clause
LIBEXECINFO_LICENSE_FILES = execinfo.h
LIBEXECINFO_INSTALL_STAGING = YES

define LIBEXECINFO_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		EXECINFO_CFLAGS="$(TARGET_CFLAGS) -c"
endef

define LIBEXECINFO_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		EXECINFO_CFLAGS="$(TARGET_CFLAGS) -c" \
		DESTDIR="$(STAGING_DIR)" PREFIX=/usr install
endef

define LIBEXECINFO_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		EXECINFO_CFLAGS="$(TARGET_CFLAGS) -c" \
		DESTDIR="$(TARGET_DIR)" PREFIX=/usr install
endef

$(eval $(generic-package))

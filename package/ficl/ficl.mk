################################################################################
#
# ficl
#
################################################################################

FICL_VERSION = 3.065
FICL_TAG = ficl$(subst .,,$(FICL_VERSION))
FICL_SOURCE = $(FICL_TAG).tar.gz
FICL_SITE = $(call github,jwsadler58,ficl,$(FICL_TAG))
FICL_LICENSE = BSD-3-Clause
FICL_LICENSE_FILES = LICENSE
FICL_INSTALL_STAGING = YES

FICL_DEPENDENCIES = host-python3

define FICL_BUILD_CMDS
	# workaround for static_assert on uclibc-ng < 1.0.42
	$(MAKE) -C $(@D) -f makefile.linux $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -std=c11 -Dlinux -D_POSIX_C_SOURCE=200809L -Dstatic_assert=_Static_assert -I. " CPPFLAGS="" ficl
endef

define FICL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/libficl.a $(STAGING_DIR)/usr/lib/libficl.a
	$(INSTALL) -D -m 0644 $(@D)/ficl.h $(STAGING_DIR)/usr/include/ficl.h
endef

define FICL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/ficl $(TARGET_DIR)/usr/bin/ficl
endef

$(eval $(generic-package))

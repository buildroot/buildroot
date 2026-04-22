################################################################################
#
# ficl
#
################################################################################

FICL_VERSION = 3.03
FICL_TAG = ficl$(subst .,,$(FICL_VERSION))
FICL_VERSION_SO = 3.0.1
FICL_SOURCE = $(FICL_TAG).tar.gz
FICL_SITE = https://sourceforge.net/projects/ficl/files/ficl-all/$(FICL_TAG)
FICL_LICENSE = BSD-2-Clause
FICL_LICENSE_FILES = ReadMe.txt
FICL_INSTALL_STAGING = YES

ifeq ($(BR2_STATIC_LIBS),y)
FICL_BUILD_TARGETS += ficl
define FICL_INSTALL_STATIC_BIN
	$(INSTALL) -D -m 0755 $(@D)/ficl $(TARGET_DIR)/usr/bin/ficl
endef
endif

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
FICL_BUILD_TARGETS += libficl.a
define FICL_INSTALL_STATIC_LIB
	$(INSTALL) -D -m 0644 $(@D)/libficl.a $(STAGING_DIR)/usr/lib/libficl.a
endef
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
FICL_BUILD_TARGETS += testmain libficl.so.$(FICL_VERSION_SO)
define FICL_INSTALL_SHARED_BIN
	$(INSTALL) -D -m 0755 $(@D)/testmain $(TARGET_DIR)/usr/bin/ficl
endef
define FICL_INSTALL_SHARED_LIB
	$(INSTALL) -D -m 0755 $(@D)/libficl.so.$(FICL_VERSION_SO) $(1)/usr/lib/libficl.so.$(FICL_VERSION_SO)
	ln -sf libficl.so.$(FICL_VERSION_SO) $(1)/usr/lib/libficl.so.3
	ln -sf libficl.so.$(FICL_VERSION_SO) $(1)/usr/lib/libficl.so
endef
endif

define FICL_BUILD_CMDS
	$(MAKE) -C $(@D) -f Makefile.linux $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) -fgnu89-inline -fPIC -I. -Dlinux" CPPFLAGS="" $(FICL_BUILD_TARGETS)
endef

define FICL_INSTALL_STAGING_CMDS
	$(FICL_INSTALL_STATIC_LIB)
	$(call FICL_INSTALL_SHARED_LIB,$(STAGING_DIR))
	$(INSTALL) -D -m 0644 $(@D)/ficl.h $(STAGING_DIR)/usr/include/ficl.h
endef

define FICL_INSTALL_TARGET_CMDS
	$(FICL_INSTALL_STATIC_BIN)
	$(FICL_INSTALL_SHARED_BIN)
	$(call FICL_INSTALL_SHARED_LIB,$(TARGET_DIR))
endef

$(eval $(generic-package))

################################################################################
#
# libshdata
#
################################################################################

LIBSHDATA_VERSION = d9ec4bdba834d8f3daf6bf9aa6da374bc462961f
LIBSHDATA_SITE = $(call github,Parrot-Developers,libshdata,$(LIBSHDATA_VERSION))
LIBSHDATA_LICENSE = BSD-3-Clause
LIBSHDATA_LICENSE_FILES = COPYING
LIBSHDATA_DEPENDENCIES = libfutils ulog host-alchemy
LIBSHDATA_INSTALL_STAGING = YES

LIBSHDATA_TARGETS = libshdata
ifeq ($(BR2_PACKAGE_LIBSHDATA_STRESS),y)
LIBSHDATA_TARGETS += libshdata-stress
endif

LIBSHDATA_TARGET_ENV = \
	$(ALCHEMY_TARGET_ENV) \
	ALCHEMY_TARGET_SDK_DIRS="$(ALCHEMY_SDK_BASEDIR)/libfutils $(ALCHEMY_SDK_BASEDIR)/ulog"

define LIBSHDATA_BUILD_CMDS
	$(LIBSHDATA_TARGET_ENV) $(ALCHEMY_MAKE) $(LIBSHDATA_TARGETS)
endef

ifeq ($(BR2_SHARED_LIBS),)
define LIBSHDATA_INSTALL_STATIC_LIBS
	$(INSTALL) -D -m 644 $(@D)/alchemy-out/staging/usr/lib/libshdata.a \
		$(STAGING_DIR)/usr/lib/libshdata.a
endef
endif

ifeq ($(BR2_STATIC_LIBS),)
# $(1): destination directory: target or staging
define LIBSHDATA_INSTALL_SHARED_LIBS
	mkdir -p $(1)/usr/lib/
	$(INSTALL) -m 644 $(@D)/alchemy-out/staging/usr/lib/libshdata.so* \
		$(1)/usr/lib/
endef
endif

ifeq ($(BR2_PACKAGE_LIBSHDATA_STRESS),y)
define LIBSHDATA_INSTALL_BIN
	$(INSTALL) -D -m 755 $(@D)/alchemy-out/staging/usr/bin/libshdata-stress \
		$(TARGET_DIR)/usr/bin/libshdata-stress
endef
endif

define LIBSHDATA_INSTALL_TARGET_CMDS
	$(LIBSHDATA_INSTALL_BIN)
	$(call LIBSHDATA_INSTALL_SHARED_LIBS, $(TARGET_DIR))
endef

# Even in dynamic libraries only, libshdata-section-lookup is only built as
# a static lib (include $(BUILD_STATIC_LIBRARY) in atom.mk) and it is needed
# for libshdata usage.
define LIBSHDATA_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 644 $(@D)/include/* $(STAGING_DIR)/usr/include/
	$(INSTALL) -D -m 644 $(@D)/alchemy-out/staging/usr/lib/libshdata-section-lookup.a \
		$(STAGING_DIR)/usr/lib/libshdata-section-lookup.a
	$(LIBSHDATA_INSTALL_STATIC_LIBS)
	$(call LIBSHDATA_INSTALL_SHARED_LIBS, $(STAGING_DIR))
	$(call ALCHEMY_INSTALL_LIB_SDK_FILE, libshdata, libshdata.so, libfutils libulog)
endef

$(eval $(generic-package))

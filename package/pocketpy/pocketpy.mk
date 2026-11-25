################################################################################
#
# pocketpy
#
################################################################################

POCKETPY_VERSION = 2.2.0
POCKETPY_SITE = $(call github,pocketpy,pocketpy,v$(POCKETPY_VERSION))
POCKETPY_LICENSE = MIT
POCKETPY_LICENSE_FILES = LICENSE
POCKETPY_INSTALL_STAGING = YES

POCKETPY_CONF_OPTS = -DPK_BUILD_SHARED_LIB=ON

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
POCKETPY_CONF_OPTS += -DPK_ENABLE_THREADS=ON
else
POCKETPY_CONF_OPTS += -DPK_ENABLE_THREADS=OFF
endif

# pocketpy uses C11 atomics, which on some architectures are provided by
# libatomic
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
POCKETPY_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic \
	-DCMAKE_SHARED_LINKER_FLAGS=-latomic
endif

define POCKETPY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libpocketpy.so* $(TARGET_DIR)/usr/lib
endef

define POCKETPY_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libpocketpy.so* $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/pocketpy
	cp -r $(@D)/include/* $(STAGING_DIR)/usr/include/pocketpy
endef

$(eval $(cmake-package))

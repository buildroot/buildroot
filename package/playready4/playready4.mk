################################################################################
#
# Playready v4
#
################################################################################

PLAYREADY4_VERSION = f67f8407d058fefbb5d4e4991604bc9d21f57833
PLAYREADY4_SITE = git@github.com:Metrological/playready.git
PLAYREADY4_SITE_METHOD = git
PLAYREADY4_LICENSE = PROPRIETARY
PLAYREADY4_DEPENDENCIES += libcurl
PLAYREADY4_INSTALL_STAGING = YES
PLAYREADY4_INSTALL_TARGET = YES
PLAYREADY4_SUBDIR = "source/linux"
PLAYREADY4_MAKE=$(MAKE1)
PLAYREADY_USE_PROVISION = "OFF"

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONPROXY), y)
    PLAYREADY_USE_PROVISION = "ON"
    PLAYREADY4_DEPENDENCIES += wpeframework-clientlibraries
endif


# Generic Buildroot
# Parallel build issues, Use MAKE1 to disable parallel
define PLAYREADY4_BUILD_CMDS
        ulimit -n 4096; \
	export PLAYREADY_DIR="$(@D)/$(PLAYREADY4_SUBDIR)";\
	export PLAYREADY_ROOT="$(@D)";\
	export PLAYREADY_PROFILE="drmprofilelinux.mk";\
	export LINUX_BUILD="1";\
	$(TARGET_MAKE_ENV) $(MAKE1) PLAYREADY_GXX=$(TARGET_CC) \
                                    CC=$(TARGET_CC) \
				    PLAYREADY_USE_PROVISION=$(PLAYREADY_USE_PROVISION) \
				    LIBPATHS=" -L$(STAGING_DIR)/usr/lib " \
                                    AR=$(TARGET_AR) \
				    PLAYREADY_PKGCONFIG="$(PKG_CONFIG_HOST_BINARY)" \
                                    MACHINE=$(KERNEL_ARCH) -C $(@D)/source;
endef

PLAYREADY4_DATA_DIR=/etc/playready

define PLAYREADY4_INSTALL
        $(INSTALL) -d $(1)/usr/lib
        $(INSTALL) -D -m 0755 $(@D)/bin/lib/libplayready.so $(1)/usr/lib/libplayready.so

        test -f $(@D)/bin/exe/prdy_test.exe && \
            $(INSTALL) -D -m 0755 $(@D)/bin/exe/prdy_test.exe $(1)/usr/bin/prdy_test.exe || true

        $(INSTALL) -d $(1)$(PLAYREADY4_DATA_DIR)
endef

define PLAYREADY4_INSTALL_DEV
        $(call PLAYREADY4_INSTALL, $(1))

        $(INSTALL) -d $(1)/usr/lib/pkgconfig
        $(INSTALL) -D package/playready4/playready.pc $(1)/usr/lib/pkgconfig/playready.pc

        $(INSTALL) -d $(1)/usr/include/playready
        cp -a $(@D)/source/inc/* $(1)/usr/include/playready

        $(INSTALL) -d $(1)/usr/include/playready/oem/common
	cp -a $(@D)/source/oem/common/inc/*.h $(1)/usr/include/playready/oem/common

        $(INSTALL) -d $(1)/usr/include/playready/oem/ansi
        cp -a $(@D)/source/oem/ansi/inc/*.h $(1)/usr/include/playready/oem/ansi
         
	cp -a $(@D)/source/results/*.h $(1)/usr/include/playready
endef

define PLAYREADY4_INSTALL_STAGING_CMDS
        $(call PLAYREADY4_INSTALL_DEV, ${STAGING_DIR})
endef

define PLAYREADY4_INSTALL_TARGET_CMDS
        $(call PLAYREADY4_INSTALL, ${TARGET_DIR})
endef

define PLAYREADY4_INSTALL_TARGET_ETC_PLAYREADY
        ln -sf /tmp $(TARGET_DIR)/etc/playready/storage
endef

PLAYREADY4_POST_INSTALL_TARGET_HOOKS += PLAYREADY4_INSTALL_TARGET_ETC_PLAYREADY

# It's not autotools-based
$(eval $(generic-package))

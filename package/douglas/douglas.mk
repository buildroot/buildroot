################################################################################
#
# Douglas
#
################################################################################

DOUGLAS_VERSION = 653b0654ac921d922799e875538723a30d06abfd
DOUGLAS_SITE_METHOD = git
DOUGLAS_SITE = git@github.com:Metrological/douglas.git
DOUGLAS_INSTALL_STAGING = NO
DOUGLAS_INSTALL_TARGET = YES
DOUGLAS_DEPENDENCIES = host-cmake zlib jpeg libcurl wpeframework

define DOUGLAS_CONFIGURATION
    $(call GENERATE_LOCAL_CONFIG)
    $(call DOUGLAS_MAKE, partner-device-code)
    $(call GENERATE_BOOST_CONFIG)
    $(call GENERATE_BUILD_CONFIG)
endef

define GENERATE_LOCAL_CONFIG
sed -e "s;%PLATFORM_FAMILY_NAME%;$(BR2_PACKAGE_DOUGLAS_PLATFORM_FAMILY_NAME);g" \
    -e "s;%PLATFORM_NAME%;$(BR2_PACKAGE_DOUGLAS_PLATFORM_NAME);g" \
    -e "s;%CC%;$(TARGET_CC);g" \
    -e "s;%CXX%;$(TARGET_CXX);g" \
    -e "s;%SDK_DIRECTORY%;$(STAGING_DIR);g" \
    -e "s;%DOUGLAS_TAG%;$(BR2_PACKAGE_DOUGLAS_TAG);g" \
    -e "s;%PARTNER_REPOSITORY_URL%;$(BR2_PACKAGE_DOUGLAS_PARTNER_REPOSITORY_URL);g" \
    -e "s;%NUMBER_OF_CONCURRENT_JOBS%;$(BR2_PACKAGE_DOUGLAS_NUMBER_OF_CONCURRENT_JOBS);g" \
    $(@D)/templates/local.config.in  > $(@D)/tools/scripts/configuration/local.config
endef

define GENERATE_BUILD_CONFIG
sed -e "s;%IG_INSTALL_PATH%;$(BR2_PACKAGE_DOUGLAS_IG_INSTALL_PATH);g" \
    -e "s;%IG_READ_WRITE_PATH%;$(BR2_PACKAGE_DOUGLAS_IG_READ_WRITE_PATH);g" \
    -e "s;%IG_TEST_INSTALL_PATH%;$(BR2_PACKAGE_DOUGLAS_IG_TEST_INSTALL_PATH);g" \
    -e "s;%DTID%;$(BR2_PACKAGE_DOUGLAS_DTID);g" \
    -e "s;%CPU_BIT_WIDTH_AND_ENDIANNESS%;$(BR2_PACKAGE_DOUGLAS_CPU_BIT_WIDTH_AND_ENDIANNESS);g" \
    $(@D)/templates/avpk-build.config.in  > $(@D)/$(BR2_PACKAGE_DOUGLAS_PLATFORM_FAMILY_NAME)/common/configuration/avpk-build-$(BR2_PACKAGE_DOUGLAS_PLATFORM_FAMILY_NAME)-${BR2_PACKAGE_DOUGLAS_PLATFORM_NAME}.config
endef

define GENERATE_BOOST_CONFIG
 sed -e "s;%TARGET_CROSS%;$(notdir $(TARGET_CROSS));g" \
    $(@D)/templates/user-config.jam.in  > $(@D)/$(BR2_PACKAGE_DOUGLAS_PLATFORM_FAMILY_NAME)/platform/ignition/com.amazon.ignition.framework.core/internal/platform/$(BR2_PACKAGE_DOUGLAS_PLATFORM_FAMILY_NAME)/boost/user-config.jam
endef

ifeq ($(BR2_PACKAGE_DOUGLAS),y)
ifeq ($(BR2_PACKAGE_DOUGLAS_BACKEND_DRM),y)
 DOUGLAS_DEPENDENCIES += libgles libegl playready
 DOUGLAS_BACKEND = mpb-drm
else ifeq  ($(BR2_PACKAGE_DOUGLAS_BACKEND_NO_DRM),y)
 DOUGLAS_DEPENDENCIES += libgles libegl
 DOUGLAS_BACKEND = mpb-no-drm
else ifeq  ($(BR2_PACKAGE_DOUGLAS_BACKEND_FAKE),y)
 DOUGLAS_BACKEND = fake-mpb
else
 $(error No backend specified)
endif

ifeq ($(BR2_PACKAGE_DOUGLAS_BUILD_TYPE_RELEASE),y)
 DOUGLAS_BUILD_TYPE = release
else ifeq  ($(BR2_PACKAGE_DOUGLAS_BUILD_TYPE_RELEASE_DEBUG),y)
 DOUGLAS_BUILD_TYPE = relwithdebinfo
else ifeq  ($(BR2_PACKAGE_DOUGLAS_BUILD_TYPE_DEBUG),y)
 DOUGLAS_BUILD_TYPE = debug
else
 $(error No build type specified)
endif
endif

define DOUGLAS_APPLY_CUSTOM_PATCHES
 $(call DOUGLAS_MAKE, ignition-repo-code)
 $(call DOUGLAS_MAKE, ruby-repo-code)
 $(APPLY_PATCHES) $(@D) $(@D)/patches \*.patch
endef

define DOUGLAS_MAKE
$(MAKE) -C $(@D)/tools/ $1 $2
endef

define DOUGLAS_BUILD_CMDS
    $(call GENERATE_LOCAL_CONFIG)
 export PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)
 $(call DOUGLAS_MAKE, dpc, BUILD_TYPE=$(DOUGLAS_BUILD_TYPE))
 $(call DOUGLAS_MAKE, dpp, BUILD_TYPE=$(DOUGLAS_BUILD_TYPE))
 $(call DOUGLAS_MAKE, ignition, BUILD_TYPE=$(DOUGLAS_BUILD_TYPE))
 $(call DOUGLAS_MAKE, ignition-device, BUILD_TYPE=$(DOUGLAS_BUILD_TYPE))
 $(call DOUGLAS_MAKE, ruby, BACKEND=$(DOUGLAS_BACKEND) BUILD_TYPE=$(DOUGLAS_BUILD_TYPE))
endef

define DOUGLAS_INSTALL_TARGET_CMDS
 $(INSTALL) -d -m 0755 $(TARGET_DIR)/$(BR2_PACKAGE_DOUGLAS_IG_INSTALL_PATH)
 cp -a $(@D)/install/$(BR2_PACKAGE_DOUGLAS_PLATFORM_NAME)/* $(TARGET_DIR)/$(BR2_PACKAGE_DOUGLAS_IG_INSTALL_PATH)
 
 if [ ! -h "$(TARGET_DIR)/usr/bin/ignition" ]; then \
    rm $(TARGET_DIR)/usr/bin/ignition ;\
    ln -s $(BR2_PACKAGE_DOUGLAS_IG_INSTALL_PATH)/bin/ignition $(TARGET_DIR)/usr/bin/ignition ;\
 fi
 
endef

define DOUGLAS_INSTALL_STAGING_CMDS
endef

DOUGLAS_POST_EXTRACT_HOOKS += DOUGLAS_CONFIGURATION
DOUGLAS_POST_PATCH_HOOKS += DOUGLAS_APPLY_CUSTOM_PATCHES

$(eval $(generic-package))

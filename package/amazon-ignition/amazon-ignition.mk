################################################################################
#
# amazon-ignition
#
################################################################################

AMAZON_IGNITION_VERSION = e72ab40d3eeb885a35170e39d2ba757d653170f3
AMAZON_IGNITION_SITE_METHOD = git
AMAZON_IGNITION_SITE = git@github.com:Metrological/amazon.git
AMAZON_IGNITION_DEPENDENCIES = jpeg libpng wpeframework amazon amazon-backend
# AMAZON_IGNITION_DEPENDENCIES = zlib jpeg libcurl libpng icu wpeframework amazon amazon-backend
AMAZON_IGNITION_SUPPORTS_IN_SOURCE_BUILD = NO
AMAZON_IGNITION_INSTALL_STAGING = YES
AMAZON_IGNITION_INSTALL_TARGET = YES

AMAZON_IGNITION_SUBDIR = ignition

AMAZON_IGNITION_DEVICE_LAYER_DIR = "$(@D)/thunder/linux-device-layer/implementation/"
AMAZON_IGNITION_RUBY_PLATFORM_ROOT = "$(@D)/thunder/amp-posix"
AMAZON_IGNITION_BUILD_DIR = "$(AMAZON_IGNITION_SRCDIR)/buildroot-build"
AMAZON_IGNITION_BINARY_INSTALL_DIR = "$(@D)/binary-install"
AMAZON_IGNITION_TEST_INSTALL_BASE_DIR = "$(AMAZON_IGNITION_BINARY_INSTALL_DIR)/test-install"

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
 AMAZON_IGNITION_DEPENDENCIES += rpi-userland
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
 AMAZON_IGNITION_DEPENDENCIES += bcm-refsw
endif

# Default CMake config
AMAZON_IGNITION_CONF_OPTS += \
   -DCMAKE_SYSTEM_NAME=Linux \
   -DCMAKE_INSTALL_PREFIX=${AMAZON_IGNITION_BINARY_INSTALL_DIR} \
   -DBUILD_SHARED_LIBS=OFF 

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION),y)

AMAZON_IGNITION_CONF_OPTS += \
   -DDEVICE_LAYER_DIR=${AMAZON_IGNITION_DEVICE_LAYER_DIR} \
   -DIGNITION_PLATFORM_LINK_LIBRARIES="-pthread" \
   -DDISABLE_SAFE_BUILD_ROOT_CHECK=OFF \
   -DUSE_MEDIA_PIPELINE_BACKEND=OFF \
   -DBUILD_AS_SHARED_LIBRARY=ON \
   -DBUILD_CURL_7_72_0=ON 

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TESTS),y)
AMAZON_IGNITION_CONF_OPTS += -DBUILD_SHARED_LIBRARY_LAUNCHER=ON
endif
   
ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_HAWKTRACER),y)
AMAZON_IGNITION_CONF_OPTS += -DENABLE_HAWKTRACER=ON
else
AMAZON_IGNITION_CONF_OPTS += -DENABLE_HAWKTRACER=OFF
endif

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_DEVELOPER_MODE),y)
AMAZON_IGNITION_CONF_OPTS += -DDEVELOPMENT_MODE=ON
else
AMAZON_IGNITION_CONF_OPTS += -DDEVELOPMENT_MODE=OFF
endif

ifeq ($(BR2_PACKAGE_EXPLORA_SDK),y)
AMAZON_IGNITION_DEVICE_LAYER_CMAKE_ARGS += -DUSE_EXPLICIT_SOFTWARE_CRYPTOGRAPHY=ON
endif
 
# This is still experimental
# Build smallest 41MB/3,2MB (DEBUG/RELEASE) results
#   -DBUILD_FREETYPE_LIB=OFF safes 2MB/0,5MB. check that its linked properly
#   -DIGNITE_DISABLE_ICU_BUILD=ON safes 13MB/11,6MB.
#   -DENABLE_WEBSOCKETS=OFF safes 2MB/0,2MB
#   -DBUILD_HARFBUZZ_LIB=OFF safes 9MB/0,5MB but minimal version should be 2.6.2, check netflix and webkit. Check that its linked properly
#ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_SMALL),y)
# AMAZON_IGNITION_CONF_OPTS += \
#   -DUSE_SYSTEM_LIBRARIES=ON \
#   -DBUILD_LIBJPEG=OFF \
#   -DBUILD_LIBPNG=OFF 
#endif

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_RUBY),y)
AMAZON_IGNITION_CONF_OPTS += \
   -DBUILD_RUBY_PLAYER=ON \
   -DRUBY_PLATFORM_ROOT=${AMAZON_IGNITION_RUBY_PLATFORM_ROOT} \
   -DUSE_FAKE_PLAYER=OFF 
else
AMAZON_IGNITION_CONF_OPTS += \
   -DBUILD_RUBY_PLAYER=OFF 
endif

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_SHARED_LIBRARY_LAUNCHER),y)
AMAZON_IGNITION_CONF_OPTS += \
   -DBUILD_SHARED_LIBRARY_LAUNCHER=ON
endif

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TYPE_RELEASE),y)
  AMAZON_IGNITION_BUILD_TYPE = Release 
else ifeq  ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TYPE_RELEASE_DEBUG),y)
  AMAZON_IGNITION_BUILD_TYPE = RelWithDebInfo
else ifeq  ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TYPE_DEBUG),y)
  AMAZON_IGNITION_BUILD_TYPE = Debug
else ifeq  ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TYPE_TESTING),y)
  AMAZON_IGNITION_BUILD_TYPE = Testing
endif

AMAZON_IGNITION_BUILD_TYPE ?= Release

AMAZON_IGNITION_CONF_OPTS += \
   -DCMAKE_BUILD_TYPE=${AMAZON_IGNITION_BUILD_TYPE} 
   
endif
# BR2_PACKAGE_AMAZON_IGNITION

define IGNITION_MAKE
    @$(call MESSAGE,"Ignition make target $(call qstrip, ${1})")
    @$(MAKE) -C $(AMAZON_IGNITION_BUILD_DIR)$(call qstrip, ${2}) $(call qstrip, ${1})
endef

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TESTS),y)
  AMAZON_IGNITION_DEVICE_LAYER_CMAKE_ARGS += -DUSE_INCLUDED_DPP_TEST_CONFIG=ON
endif

AMAZON_IGNITION_CONF_OPTS += \
    -DDEVICE_LAYER_CMAKE_ARGS="${AMAZON_IGNITION_DEVICE_LAYER_CMAKE_ARGS}"

$(eval $(cmake-package))

define AMAZON_IGNITION_INSTALL_GENERIC
    @$(call MESSAGE,"Install ignition targets")  
    @$(call IGNITION_MAKE, install)
endef

define AMAZON_IGNITION_INSTALL_IGNITION
    @$(call MESSAGE,"Installing ignition to: $(call qstrip,$(1))")  
    @$(INSTALL) -v -d -m 0755 $(call qstrip,$(1))/$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)
	
    rsync -av ${AMAZON_IGNITION_BINARY_INSTALL_DIR}/ $(call qstrip,$(1))/$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)

    ln -sf  "../../../lib/libamazon_backend_device.so" "$(call qstrip,$(1))$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)/lib/libamazon_backend_device.so"
    ln -sf "../../../lib/libamazon-backend.so" "$(call qstrip,$(1))$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)/lib/libamazon-backend.so"
    ln -sf  "../../../lib/libamazon_player_mediapipeline.so" "$(call qstrip,$(1))$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)/lib/libamazon_player_mediapipeline.so"
    ln -sf  "../../../lib/libamazon_player.so" "$(call qstrip,$(1))$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)/lib/libamazon_player.so"
    ln -sf  "../../../lib/libamazon_playready.so" "$(call qstrip,$(1))$(BR2_PACKAGE_AMAZON_IGNITION_IG_INSTALL_PATH)/lib/libamazon_playready.so"
endef

define AMAZON_IGNITION_INSTALL_IGNITION_DEV
    @$(call MESSAGE,"Installing ignition headers to: ${STAGING_DIR}/usr/include/ignition") 
    @$(call AMAZON_IGNITION_INSTALL_IGNITION, ${STAGING_DIR})

    @$(INSTALL) -v -d -m 0755 ${STAGING_DIR}/usr/include/ignition

    @$(call MESSAGE,"Installing ignition header  [ ${AMAZON_IGNITION_DEVICE_LAYER_DIR}/../interface/ ] to: ${STAGING_DIR}/usr/include/ignition")
    cd "${AMAZON_IGNITION_DEVICE_LAYER_DIR}/../interface/include" && find -name "*.h" -type f -exec cp --parents {} ${STAGING_DIR}/usr/include/ignition/ \;
endef

ifeq ($(BR2_PACKAGE_AMAZON_IGNITION_BUILD_TESTS),y)
    AMAZON_IGNITION_INSTALL_STAGING = NO
    AMAZON_IGNITION_INSTALL_TARGET = NO

    define AMAZON_IGNITION_BUILD_IGNITION_TESTS
        @$(call MESSAGE,"Building ignition tests")
        @$(call IGNITION_MAKE, test_ignition)  
    endef  

    define AMAZON_IGNITION_BUILD_INTERACTION_TESTS
        @$(call MESSAGE,"Building ignition tests")
        @$(call IGNITION_MAKE, integration-tests-package-with-mock-device-layer)
    endef
        
    define AMAZON_IGNITION_BUILD_DEVICE_LAYER_TESTS
        @$(call MESSAGE,"Building device layer test")
        @$(call IGNITION_MAKE, install-prime-video-device-layer-test)
    endef
    
    define AMAZON_IGNITION_BUILD_INTERGRATION_TESTS
        @$(call MESSAGE,"Building device layer test")
        @$(call IGNITION_MAKE, integration-tests-package)
    endef

    define AMAZON_IGNITION_BUILD_CMDS
        @$(call AMAZON_IGNITION_BUILD_INTERGRATION_TESTS)
    endef    

    define AMAZON_IGNITION_INSTALL_STAGING_CMDS
    endef

    define AMAZON_IGNITION_INSTALL_TARGET_CMDS
    endef

else #BR2_PACKAGE_AMAZON_IGNITION_BUILD_TESTS  
    define AMAZON_IGNITION_BUILD_CMDS
      @$(call IGNITION_MAKE all)
    endef

    AMAZON_IGNITION_POST_BUILD_HOOKS += AMAZON_IGNITION_INSTALL_GENERIC

    define AMAZON_IGNITION_INSTALL_STAGING_CMDS
        @$(call AMAZON_IGNITION_INSTALL_IGNITION_DEV)
    endef

    define AMAZON_IGNITION_INSTALL_TARGET_CMDS
        @$(call AMAZON_IGNITION_INSTALL_IGNITION_DEV)
        @$(call AMAZON_IGNITION_INSTALL_IGNITION, ${TARGET_DIR})
    endef

endif # BR2_PACKAGE_AMAZON_IGNITION_BUILD_TESTS



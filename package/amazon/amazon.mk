################################################################################
#
# Amazon
#
################################################################################

AMAZON_VERSION = adda6662b3aeabeab1263f80591830aab6ff1b07
AMAZON_SITE_METHOD = git
AMAZON_SITE = git@github.com:Metrological/amazon.git
AMAZON_INSTALL_STAGING = YES
AMAZON_INSTALL_TARGET = YES
AMAZON_DEPENDENCIES = host-cmake zlib jpeg libcurl libpng wpeframework gstreamer1 

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
 AMAZON_DEPENDENCIES += rpi-userland
endif

ifeq ($(BR2_PACKAGE_BCM_REFSW),y)
 AMAZON_DEPENDENCIES += bcm-refsw
endif

ifeq ($(BR2_PACKAGE_BCM_BME),y)
 AMAZON_DEPENDENCIES += bcm-bme bme-amazon-backend
endif

define AMAZON_CONFIGURATION
#   $(call AMAZON_MAKE, partner-device-code)
    $(call GENERATE_BOOST_CONFIG)
    $(call GENERATE_BUILD_CONFIG)
endef

define GENERATE_LOCAL_CONFIG
sed -e "s;%PLATFORM_FAMILY_NAME%;$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME);g" \
    -e "s;%PLATFORM_NAME%;$(BR2_PACKAGE_AMAZON_PLATFORM_NAME);g" \
    -e "s;%CC%;$(TARGET_CC);g" \
    -e "s;%CXX%;$(TARGET_CXX);g" \
    -e "s;%SDK_DIRECTORY%;$(STAGING_DIR);g" \
    -e "s;%AMAZON_TAG%;$(BR2_PACKAGE_AMAZON_TAG);g" \
    -e "s;%NUMBER_OF_CONCURRENT_JOBS%;$(BR2_PACKAGE_AMAZON_NUMBER_OF_CONCURRENT_JOBS);g" \
    $(@D)/templates/local.config.in  > $(@D)/tools/scripts/configuration/local.config
endef

define GENERATE_BUILD_CONFIG
mkdir -p $(@D)/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/common/configuration
sed -e "s;%IG_INSTALL_PATH%;$(BR2_PACKAGE_AMAZON_IG_INSTALL_PATH);g" \
    -e "s;%IG_READ_WRITE_PATH%;$(BR2_PACKAGE_AMAZON_IG_READ_WRITE_PATH);g" \
    -e "s;%IG_TEST_INSTALL_PATH%;$(BR2_PACKAGE_AMAZON_IG_TEST_INSTALL_PATH);g" \
    -e "s;%DTID%;$(BR2_PACKAGE_AMAZON_DTID);g" \
    -e "s;%CPU_BIT_WIDTH_AND_ENDIANNESS%;$(BR2_PACKAGE_AMAZON_CPU_BIT_WIDTH_AND_ENDIANNESS);g" \
    $(@D)/templates/avpk-build.config.in  > $(@D)/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/common/configuration/avpk-build-$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)-${BR2_PACKAGE_AMAZON_PLATFORM_NAME}.config
endef

define GENERATE_BOOST_CONFIG
 mkdir -p  $(@D)/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/platform/ignition/com.amazon.ignition.framework.core/internal/platform/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/boost
 sed -e "s;%TARGET_CROSS%;$(notdir $(TARGET_CROSS));g" \
    $(@D)/templates/user-config.jam.in  > $(@D)/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/platform/ignition/com.amazon.ignition.framework.core/internal/platform/$(BR2_PACKAGE_AMAZON_PLATFORM_FAMILY_NAME)/boost/user-config.jam
endef

ifeq ($(BR2_PACKAGE_AMAZON),y)
ifeq ($(BR2_PACKAGE_AMAZON_BACKEND_DRM),y)
 AMAZON_DEPENDENCIES += libgles libegl gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad playready
 AMAZON_BACKEND = mpb-drm
else ifeq  ($(BR2_PACKAGE_AMAZON_BACKEND_NO_DRM),y)
 AMAZON_DEPENDENCIES += libgles libegl gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad
 AMAZON_BACKEND = mpb-no-drm
else ifeq  ($(BR2_PACKAGE_AMAZON_BACKEND_FAKE),y)
 AMAZON_BACKEND = fake-mpb
else
 $(error No backend specified)
endif

ifeq ($(BR2_PACKAGE_AMAZON_BUILD_TYPE_RELEASE),y)
 AMAZON_BUILD_TYPE = release
else ifeq  ($(BR2_PACKAGE_AMAZON_BUILD_TYPE_RELEASE_DEBUG),y)
 AMAZON_BUILD_TYPE = relwithdebinfo
else ifeq  ($(BR2_PACKAGE_AMAZON_BUILD_TYPE_DEBUG),y)
 AMAZON_BUILD_TYPE = debug
else
 $(error No build type specified)
endif
endif

define AMAZON_APPLY_CUSTOM_PATCHES
 $(APPLY_PATCHES) $(@D) $(@D)/patches \*.patch
endef

ifeq ($(BR2_PACKAGE_AMAZON_USE_ORIGINAL_SOURCES),y)
define AMAZON_GET_SOURCES
  rm -rf $(@D)/build
  rm -rf $(@D)/common
  rm -rf $(@D)/ignition
  rm -rf $(@D)/ruby
  $(call AMAZON_MAKE, ignition-repo-code)
  $(call AMAZON_MAKE, ruby-repo-code)
  $(call AMAZON_MAKE, common-repo-code)
  $(call AMAZON_APPLY_CUSTOM_PATCHES)
endef
endif

define AMAZON_CLEAROUT_FILES
    if [ _$(BR2_PACKAGE_AMAZON_USE_ORIGINAL_SOURCES) != _y ]; then \
         echo "#Cleared by buildroot." > $(@D)/tools/scripts/task-handlers/checkout/default-checkout.cmake ;\
    fi
    echo "#Cleared by buildroot." > $(@D)/tools/scripts/task-handlers/code/partner-repo-code.cmake
    echo "#Cleared by buildroot." > $(@D)/tools/scripts/task-handlers/checkout/partner-repo-checkout.cmake
endef

define AMAZON_MAKE
  SDK_ROOT=$(STAGING_DIR) $(MAKE) -C $(@D)/tools/ $1 $2
endef

define AMAZON_CONFIGURE_CMDS
    $(call GENERATE_LOCAL_CONFIG)
    $(call GENERATE_BOOST_CONFIG)
    $(call GENERATE_BUILD_CONFIG)
    $(call AMAZON_GET_SOURCES) 
    $(call AMAZON_CLEAN_COMPONENTS)
endef

define AMAZON_CLEAN_COMPONENTS
  $(call AMAZON_MAKE, ruby-clean)
  $(call AMAZON_MAKE, dpc-clean)
  $(call AMAZON_MAKE, dpp-clean)
  $(call AMAZON_MAKE, ignition-clean)
endef

AMAZON_CXX_FLAGS = -std=c++11
HAWAII_BINDINGS_LIBS = -lcurl
SDK_INCLUDE_DIRECTORIES = ${STAGING_DIR}/usr/include

ifeq ($(BR2_PACKAGE_BCM_BME),y)
  HAWAII_BINDINGS_LIBS += -lbroadcom-backend -ldl
  SDK_INCLUDE_DIRECTORIES += ${STAGING_DIR}/usr/include/bme ${STAGING_DIR}/usr/include/refsw
endif

################################################################################
# DCP/DPP
################################################################################
define AMAZON_BUILD_DPC_DPP
  $(call AMAZON_MAKE, dpp, BUILD_TYPE=$(AMAZON_BUILD_TYPE))
  $(call AMAZON_MAKE, dpc, BUILD_TYPE=$(AMAZON_BUILD_TYPE))
endef

################################################################################
# Ruby
################################################################################
RUBY_MAKE_OPTIONS=\
  VERBOSE=OFF \
  RUBY_USING_IGNITION_CURL=OFF \
  HAWAII_BINDINGS_LIBS="${HAWAII_BINDINGS_LIBS}" \
  SDK_INCLUDE_DIRECTORIES="${SDK_INCLUDE_DIRECTORIES}" \
  SDK_FLAGS="${AMAZON_CXX_FLAGS}"

define AMAZON_BUILD_RUBY
  $(call AMAZON_BUILD_DPC_DPP)
  $(call AMAZON_MAKE, ruby, BACKEND=$(AMAZON_BACKEND) BUILD_TYPE=$(AMAZON_BUILD_TYPE) ${RUBY_MAKE_OPTIONS})
endef

define AMAZON_INSTALL_RUBY
  $(INSTALL) -v -m 750 -D $(@D)/install/$(BR2_PACKAGE_AMAZON_PLATFORM_NAME)/bin/*.so $(1)/usr/lib
endef

define AMAZON_INSTALL_RUBY_DEV
  $(call AMAZON_INSTALL_RUBY, ${STAGING_DIR})
endef

################################################################################
# Ignition
################################################################################
ifeq ($(BR2_PACKAGE_AMAZON_INCLUDE_IGNITION),y)
  define AMAZON_BUILD_IGNITION
    $(call AMAZON_MAKE, ignition, BUILD_TYPE=$(AMAZON_BUILD_TYPE))
    $(call AMAZON_MAKE, ignition-device, BUILD_TYPE=$(AMAZON_BUILD_TYPE))
  endef

  define AMAZON_INSTALL_IGNITION
    $(INSTALL) -v -d -m 0755 $(TARGET_DIR)/$(BR2_PACKAGE_AMAZON_IG_INSTALL_PATH)

    if [ ! -h "$(1)/$(BR2_PACKAGE_AMAZON_IG_INSTALL_PATH)/bin/amazon_player_mediapipeline.so" ]; then \
      ln -s /usr/lib/libamazon_player_mediapipeline.so \
          $(1)/$(BR2_PACKAGE_AMAZON_IG_INSTALL_PATH)/bin/amazon_player_mediapipeline.so ;\
    fi
    if [ -f $(@D)/build/ruby/amazon_player_mediapipeline/$(AMAZON_BACKEND)/$(AMAZON_BUILD_TYPE)/Player/test/playback-test/playback-test ] ; then \
       cp $(@D)/build/ruby/amazon_player_mediapipeline/$(AMAZON_BACKEND)/$(AMAZON_BUILD_TYPE)/Player/test/playback-test/playback-test $(1)/usr/bin ;\
    fi
    if [ ! -h "$(1)/usr/bin/ignition" ]; then \
      rm $(1)/usr/bin/ignition ;\
      ln -s $(BR2_PACKAGE_AMAZON_IG_INSTALL_PATH)/bin/ignition $(1)/usr/bin/ignition ;\
    fi
  endef

  define AMAZON_INSTALL_IGNITION_DEV
    $(call AMAZON_INSTALL_IGNITION, ${STAGING_DIR})
  endef
endif

################################################################################
# Generic buildroot
################################################################################
define AMAZON_BUILD_CMDS
  export PKG_CONFIG_SYSROOT_DIR=$(STAGING_DIR)
  $(call AMAZON_BUILD_RUBY)
  $(call AMAZON_BUILD_IGNITION)
endef

define AMAZON_INSTALL_TARGET_CMDS
  $(call AMAZON_INSTALL_RUBY, ${TARGET_DIR})
  $(call AMAZON_INSTALL_IGNITION, ${TARGET_DIR})
endef

define AMAZON_INSTALL_STAGING_CMDS
  $(call AMAZON_INSTALL_RUBY_DEV)
  $(call AMAZON_INSTALL_IGNITION_DEV)
endef

AMAZON_PRE_BUILD_HOOKS += AMAZON_CLEAROUT_FILES

$(eval $(generic-package))

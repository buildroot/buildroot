################################################################################
#
# widevine
#
################################################################################
WIDEVINE_VERSION = cc6a028f8c069160b7cd9110f034e7e27637ae1b
WIDEVINE_SITE = git@github.com:Metrological/widevine.git
WIDEVINE_SITE_METHOD = git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES = host-gyp
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
export WV_HOST_CXX_FLAGS = $(HOST_CXXFLAGS)
export WV_HOST_CC = $(HOSTCC)
export WV_HOST_CXX = $(HOSTCXX)
export WV_STAGING = $(STAGING_DIR)
export WV_STAGING_NATIVE = $(STAGING_DIR)
export WV_PROTOBUF_CONFIG = source

ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_RPI), y)
        export WV_BOARD = rpi
        WIDEVINE_ARCHITECTURE = arm
else ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_WPE), y)
        export WV_BOARD = wpe
        WIDEVINE_ARCHITECTURE = wpe
        WIDEVINE_DEPENDENCIES += wpeframework
else
        export WV_BOARD=dummy
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
        WIDEVINE_BUILD_DIR=Debug
else ifeq ($($(BR2_PACKAGE_WIDEVINE_BUILD_TYPE_DEBUG)),y)
        WIDEVINE_BUILD_DIR=Debug
else
        WIDEVINE_BUILD_TYPE_OPTION=-r
        WIDEVINE_BUILD_DIR=Release
endif

define WIDEVINE_CONFIGURE_CMDS
      (cd $(@D);rm -rf out; rm -rf Makefile;\
       find . -name \*.mk -delete;\
       find . -name \*.pyc -delete;\
       ./build.py $(WIDEVINE_BUILD_TYPE_OPTION) $(WIDEVINE_ARCHITECTURE) )
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        $(INSTALL) -D $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/lib*/lib*.so $(STAGING_DIR)/usr/lib/
        $(INSTALL) -D $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include
        $(INSTALL) -D $(@D)/core/include/*.h $(STAGING_DIR)/usr/include
endef

ifeq ($(BR2_PACKAGE_WIDEVINE_INSTALL_UT),y)
define WIDEVINE_UNIT_TEST_INSTALL
        $(INSTALL) -D $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
endef
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_PROVISIONING_OPERATOR), "metrological")
define WIDEVINE_ARTIFACTS_INSTALL
        $(INSTALL) -D $(@D)/artifacts/DeviceCertificate.bin $(TARGET_DIR)/$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_DEVICE_CERTIFICATE)
        $(INSTALL) -D $(@D)/artifacts/testkeybox.bin $(TARGET_DIR)/$(BR2_PACKAGE_WPEFRAMEWORK_CDMI_WIDEVINE_KEYBOX)
endef
endif

define WIDEVINE_INSTALL_TARGET_CMDS
        $(INSTALL) -Ds --strip-program=$(TARGET_STRIP) \
                $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/lib*/lib*.so \
                $(TARGET_DIR)/usr/lib/
        $(call WIDEVINE_UNIT_TEST_INSTALL)
        $(call WIDEVINE_ARTIFACTS_INSTALL)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

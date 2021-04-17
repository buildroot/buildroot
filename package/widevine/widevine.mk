################################################################################
#
# widevine
#
################################################################################
WIDEVINE_VERSION = e365d6f314d36794937d58e7461b50ba7f17bf8d
WIDEVINE_SITE = git@github.com:WebPlatformForEmbedded/widevine.git
WIDEVINE_SITE_METHOD = git
WIDEVINE_DEPENDENCIES = host-gyp
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE
WIDEVINE_DEPENDENCIES = protobuf wpeframework-clientlibraries host-python3

WIDEVINE_INSTALL_STAGING = YES

ifeq ($(BR2_i386), y)
        WIDEVINE_TARGET_ARCH = x86
else ifeq ($(BR2_x86_64), y)
        WIDEVINE_TARGET_ARCH = x86-64
else ifeq ($(BR2_arm), y)
        WIDEVINE_TARGET_ARCH = arm
else ifeq ($(BR2_aarch64), y)
        WIDEVINE_TARGET_ARCH = arm64
else
        WIDEVINE_TARGET_ARCH = none
endif

export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
export WV_HOST_CXX_FLAGS = $(HOST_CXXFLAGS)
export WV_HOST_CC = $(HOSTCC)
export WV_HOST_CXX = $(HOSTCXX)
export WV_STAGING = $(STAGING_DIR)
export WV_STAGING_NATIVE = $(HOST_DIR)
export WV_ASM_TARGET_ARCH = ${WIDEVINE_TARGET_ARCH}

ifeq ($(BR2_ENABLE_DEBUG),y)
        WIDEVINE_BUILD_DIR=Debug
else ifeq ($($(BR2_PACKAGE_WIDEVINE_BUILD_TYPE_DEBUG)),y)
        WIDEVINE_BUILD_DIR=Debug
else
        WIDEVINE_BUILD_TYPE_OPTION=--release
        WIDEVINE_BUILD_DIR=Release
endif

ifeq ($(BR2_ENABLE_PROVISIONING_APP),y)
	WIDEVINE_PROVISIONING_APP = --provisioning_app
	WIDEVINE_DEPENDENCIES = libcurl openssl
	
define WIDEVINE_PROVISIONING_APP_INSTALL
	$(INSTALL) -D $(@D)/out/wpe/$(WIDEVINE_BUILD_DIR)/WidevineProvisioningApplication $(TARGET_DIR)/usr/bin
endef

	WIDEVINE_POST_INSTALL_TARGET_HOOKS += WIDEVINE_PROVISIONING_APP_INSTALL
endif

define WIDEVINE_CONFIGURE_CMDS
     (cd $(@D);rm -rf out; rm -rf Makefile;\
     find . -name \*.mk -delete;\
     find . -name \*.pyc -delete;) 
endef

define WIDEVINE_BUILD_CMDS
       ${HOST_DIR}/usr/bin/python3 $(@D)/build.py --verbose $(WIDEVINE_BUILD_TYPE_OPTION) $(WIDEVINE_PROVISIONING_APP) wpe     
endef


define WIDEVINE_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/lib/widevine
        $(INSTALL) -D $(@D)/out/wpe/$(WIDEVINE_BUILD_DIR)/*.a $(STAGING_DIR)/usr/lib/widevine
        
	$(INSTALL) -d $(STAGING_DIR)/usr/include/widevine
        $(INSTALL) -D $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include/widevine
        $(INSTALL) -D $(@D)/core/include/*.h $(STAGING_DIR)/usr/include/widevine
        $(INSTALL) -D $(@D)/util/include/*.h $(STAGING_DIR)/usr/include/widevine
endef

ifeq ($(BR2_PACKAGE_WIDEVINE_INSTALL_UT),y)
define WIDEVINE_UNIT_TEST_INSTALL
        $(INSTALL) -D $(@D)/out/wpe/$(WIDEVINE_BUILD_DIR)/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
endef
WIDEVINE_POST_INSTALL_TARGET_HOOKS += WIDEVINE_UNIT_TEST_INSTALL
endif

define WIDEVINE_INSTALL_TARGET_CMDS
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

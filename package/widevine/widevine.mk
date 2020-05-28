################################################################################
#
# widevine
#
################################################################################
WIDEVINE_VERSION = dc634218bb17fd88a270d48d1b8f9524d984fd59
WIDEVINE_SITE = git@github.com:Metrological/widevine.git
WIDEVINE_SITE_METHOD = git

WIDEVINE_INSTALL_STAGING = YES
WIDEVINE_DEPENDENCIES = host-gyp
WIDEVINE_LICENSE = BSD
WIDEVINE_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_RPI), y)
export WV_BOARD = rpi
WIDEVINE_ARCHITECTURE = arm
else ifeq ($(BR2_PACKAGE_WIDEVINE_SOC_WPE), y)
export WV_BOARD = wpe
WIDEVINE_ARCHITECTURE = wpe
WIDEVINE_DEPENDENCIES += wpeframework
else
export WV_BOARD=dummy
endif #BR2_PACKAGE_WIDEVINE_SOC_RPI



export WV_CC=$(TARGET_CC)
export WV_CXX=$(TARGET_CXX)
export WV_AR=$(TARGET_AR)
export WV_HOST_CXX_FLAGS = $(HOST_CXXFLAGS)
export WV_HOST_CC = $(HOSTCC)
export WV_HOST_CXX = $(HOSTCXX)
export WV_STAGING = $(STAGING_DIR)
export WV_STAGING_NATIVE = $(STAGING_DIR)
export WV_PROTOBUF_CONFIG = source


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
       ./build.py $(WIDEVINE_ARCHITECTURE) $(WIDEVINE_BUILD_TYPE_OPTION))
endef

ifeq ($(BR2_PACKAGE_WIDEVINE_INSTALL_UT),y)
define WIDEVINE_UNIT_TEST_INSTALL
        $(INSTALL) -D $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/widevine_ce_cdm_unittest $(TARGET_DIR)/usr/bin
endef
endif

define WIDEVINE_INSTALL_TARGET_CMDS
        $(call WIDEVINE_UNIT_TEST_INSTALL)
        $(INSTALL) -Ds --strip-program=$(TARGET_STRIP) \
                $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/lib*/lib*.so \
                $(TARGET_DIR)/usr/lib/
endef

define WIDEVINE_INSTALL_STAGING_CMDS
        $(INSTALL) -D $(@D)/out/$(WIDEVINE_ARCHITECTURE)/$(WIDEVINE_BUILD_DIR)/lib*/lib*.so $(STAGING_DIR)/usr/lib/
        $(INSTALL) -D $(@D)/cdm/include/*.h $(STAGING_DIR)/usr/include
        $(INSTALL) -D $(@D)/core/include/*.h $(STAGING_DIR)/usr/include
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

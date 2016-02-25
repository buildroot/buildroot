################################################################################
#
# Intelce sdk target
#
################################################################################
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SDK_VERSION = eef93375337a2aa2252d2b828d4b2cfa6db6b658
    INTELCE_SDK_SITE = git@github.com:Metrological/intel-sdk.git
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_SDK_VERSION = 5ddebcce75d3b32ed3f0832825859fe856df2402
    INTELCE_SDK_SITE = git@github.com:Metrological/IntelCE-SDK.git
endif

INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_DEPENDENCIES = host-doxygen host-dos2unix

$(eval $(generic-package))

################################################################################
#
# Intelce sdk target
#
################################################################################
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SDK_VERSION = 03f586927ceb4989d570aed081c146b9f0581939 
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_SDK_VERSION = 154bf6aad747fa8782dda9a86ad7c9fd5a4a8a1c
endif

INTELCE_SDK_SITE = git@github.com:Metrological/IntelCE-SDK.git
INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_DEPENDENCIES = host-doxygen host-dos2unix

$(eval $(generic-package))

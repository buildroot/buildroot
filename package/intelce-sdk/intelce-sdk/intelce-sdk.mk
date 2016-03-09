################################################################################
#
# Intelce sdk target
#
################################################################################
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SDK_VERSION = 39a8bbb5c888b22290b03b0d911779581a2cb308
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_SDK_VERSION = 154bf6aad747fa8782dda9a86ad7c9fd5a4a8a1c
endif

INTELCE_SDK_SITE = git@github.com:Metrological/IntelCE-SDK.git
INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_DEPENDENCIES = host-doxygen host-dos2unix

$(eval $(generic-package))

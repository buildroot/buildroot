ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
INTELCE_SDK_RELEASE="21.1.11182.271361"
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
INTELCE_SDK_RELEASE="36.0.14495.347773"
endif

include package/intelce-sdk/common.include

include package/intelce-sdk/intelce-sdk/intelce-sdk.mk
include package/intelce-sdk/package/*/*.mk




################################################################################
#
# azure-iot-sdk-c
#
################################################################################

AZURE_IOT_SDK_C_VERSION = LTS_08_2023
AZURE_IOT_SDK_C_SITE = https://github.com/Azure/azure-iot-sdk-c
AZURE_IOT_SDK_C_SITE_METHOD = git
AZURE_IOT_SDK_C_GIT_SUBMODULES = YES
AZURE_IOT_SDK_C_LICENSE = MIT
AZURE_IOT_SDK_C_LICENSE_FILES = LICENSE
AZURE_IOT_SDK_C_INSTALL_STAGING = YES
AZURE_IOT_SDK_C_DEPENDENCIES = libxml2 openssl libcurl util-linux
AZURE_IOT_SDK_C_CONF_OPTS = -Dskip_samples=ON

ifeq ($(BR2_STATIC_LIBS),y)
AZURE_IOT_SDK_C_CONF_OPTS += -Duse_prov_client=OFF
else
AZURE_IOT_SDK_C_CONF_OPTS += -Duse_prov_client=ON
endif

$(eval $(cmake-package))

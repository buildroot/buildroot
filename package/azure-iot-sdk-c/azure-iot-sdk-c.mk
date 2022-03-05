################################################################################
#
# azure-iot-sdk-c
#
################################################################################

AZURE_IOT_SDK_C_VERSION = LTS_01_2021_Ref01
AZURE_IOT_SDK_C_SITE = https://github.com/Azure/azure-iot-sdk-c
AZURE_IOT_SDK_C_SITE_METHOD = git
AZURE_IOT_SDK_C_GIT_SUBMODULES = YES
AZURE_IOT_SDK_C_LICENSE = MIT
AZURE_IOT_SDK_C_LICENSE_FILES = LICENSE
AZURE_IOT_SDK_C_INSTALL_STAGING = YES
AZURE_IOT_SDK_C_DEPENDENCIES = libxml2 openssl libcurl util-linux
AZURE_IOT_SDK_C_CONF_OPTS = -Dskip_samples=ON

$(eval $(cmake-package))

################################################################################
#
# vulkan-sdk
#
################################################################################

VULKAN_SDK_VERSION = 1.4.313.0
VULKAN_SDK_SITE = https://github.com/zeux/volk/archive/refs/tags
VULKAN_SDK_LICENSE = MIT
VULKAN_SDK_LICENSE_FILES = LICENSE.md
VULKAN_SDK_INSTALL_STAGING = YES

VULKAN_SDK_DEPENDENCIES = vulkan-headers

VULKAN_SDK_CONF_OPTS += -DVOLK_INSTALL=ON

$(eval $(cmake-package))

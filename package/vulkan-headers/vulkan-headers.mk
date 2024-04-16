################################################################################
#
# vulkan-headers
#
################################################################################

# Note: changing this version will also affect vulkan-loader and
# vulkan-tools, so please update those packages as well.
VULKAN_HEADERS_VERSION = 1.3.262
VULKAN_HEADERS_SITE = $(call github,KhronosGroup,Vulkan-Headers,v$(VULKAN_HEADERS_VERSION))
VULKAN_HEADERS_LICENSE = Apache-2.0, MIT
VULKAN_HEADERS_LICENSE_FILES = LICENSE.md
VULKAN_HEADERS_INSTALL_STAGING = YES

$(eval $(cmake-package))

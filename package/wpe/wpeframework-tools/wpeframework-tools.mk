################################################################################
#
# wpeframework-tools
#
################################################################################

WPEFRAMEWORK_TOOLS_VERSION = 6cf39ada500c61f373acc40643aa33d6cfd7a6df

HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,WebPlatformForEmbedded,WPEFramework,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO

HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python-jsonref

HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

$(eval $(host-cmake-package))

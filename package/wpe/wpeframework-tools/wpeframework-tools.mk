################################################################################
#
# wpeframework-tools
#
################################################################################

WPEFRAMEWORK_TOOLS_VERSION = bee4e8b0ca66c0feb8eed22587934f0c3e74c0c8

HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,Thunder,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref
HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

$(eval $(host-cmake-package))

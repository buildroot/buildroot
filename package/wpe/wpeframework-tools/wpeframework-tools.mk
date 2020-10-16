################################################################################
#
# wpeframework-tools
#
################################################################################

WPEFRAMEWORK_TOOLS_VERSION = 20e2fcc8062f5f806a8d8f185d455f3ab7f2f80a

HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,Thunder,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref
HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

$(eval $(host-cmake-package))

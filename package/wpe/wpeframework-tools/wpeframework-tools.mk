################################################################################
#
# wpeframework-tools
#
################################################################################
WPEFRAMEWORK_TOOLS_VERSION = dc3e567e29fa77fd1b4eb5a395f5b8dd67e499a6
HOST_WPEFRAMEWORK_TOOLS_SITE = $(call github,rdkcentral,Thunder,$(WPEFRAMEWORK_TOOLS_VERSION))
HOST_WPEFRAMEWORK_TOOLS_INSTALL_STAGING = YES
HOST_WPEFRAMEWORK_TOOLS_INSTALL_TARGET = NO
HOST_WPEFRAMEWORK_TOOLS_DEPENDENCIES = host-cmake host-python3 host-python3-jsonref
HOST_WPEFRAMEWORK_TOOLS_SUBDIR = Tools

ifeq ($(BR2_CMAKE_HOST_DEPENDENCY),)
HOST_WPEFRAMEWORK_TOOLS_CONF_OPTS += \
	-DGENERIC_CMAKE_MODULE_PATH=$(HOST_DIR)/share/cmake/Modules
endif

$(eval $(host-cmake-package))

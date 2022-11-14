################################################################################
#
# opencl-clhpp
#
################################################################################

OPENCL_CLHPP_VERSION = 2.0.16
OPENCL_CLHPP_SITE = $(call github,KhronosGroup,OpenCL-CLHPP,v$(OPENCL_CLHPP_VERSION))
OPENCL_CLHPP_LICENSE = Apache-2.0
OPENCL_CLHPP_LICENSE_FILES = LICENSE.txt
OPENCL_CLHPP_DEPENDENCIES = libopencl
OPENCL_CLHPP_INSTALL_STAGING = YES

# OpenCL_CLHPP is a header-only library
OPENCL_CLHPP_INSTALL_TARGET = NO

# This package has a CMake build system, and it checks for C++11
# compliant compiler, but all we need to do is install two headers, so
# let's do it manually.
OPENCL_CLHPP_HEADERS = cl2.hpp opencl.hpp

define OPENCL_CLHPP_INSTALL_STAGING_CMDS
	$(foreach header,$(OPENCL_CLHPP_HEADERS), \
		$(INSTALL) -D -m 0644 $(@D)/include/CL/$(header) \
			$(STAGING_DIR)/usr/include/CL/$(header)
	)
endef

$(eval $(generic-package))

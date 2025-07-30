################################################################################
#
# opencl-headers
#
################################################################################

# The opencl-headers, opencl-icd-loader, and opencl-clhpp packages
# must always be updated together to compatible versions.
# Version desynchronization may result in build or runtime errors.
# When updating one of them, make sure to check and update the others.

OPENCL_HEADERS_VERSION = 2025.07.22
OPENCL_HEADERS_SOURCE = OpenCL-Headers-$(OPENCL_HEADERS_VERSION).tar.gz
OPENCL_HEADERS_SITE = $(call github,KhronosGroup,OpenCL-Headers,v$(OPENCL_HEADERS_VERSION))
OPENCL_HEADERS_LICENSE = Apache-2.0
OPENCL_HEADERS_LICENSE_FILES = LICENSE
OPENCL_HEADERS_INSTALL_STAGING = YES
OPENCL_HEADERS_INSTALL_TARGET = NO

define OPENCL_HEADERS_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/CL
	$(INSTALL) -D -m 0644 $(@D)/CL/* \
		$(STAGING_DIR)/usr/include/CL
endef

$(eval $(generic-package))

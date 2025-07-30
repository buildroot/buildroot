################################################################################
#
# opencl-icd-loader
#
################################################################################

# The opencl-headers, opencl-icd-loader, and opencl-clhpp packages
# must always be updated together to compatible versions.
# Version desynchronization may result in build or runtime errors.
# When updating one of them, make sure to check and update the others.
OPENCL_ICD_LOADER_VERSION = 2025.07.22
OPENCL_ICD_LOADER_SOURCE = OpenCL-ICD-Loader-$(OPENCL_ICD_LOADER_VERSION).tar.gz
OPENCL_ICD_LOADER_SITE = $(call github,KhronosGroup,OpenCL-ICD-Loader,v$(OPENCL_ICD_LOADER_VERSION))
OPENCL_ICD_LOADER_LICENSE = Apache-2.0
OPENCL_ICD_LOADER_LICENSE_FILES = LICENSE
OPENCL_ICD_LOADER_INSTALL_STAGING = YES

OPENCL_ICD_LOADER_DEPENDENCIES = opencl-headers

OPENCL_ICD_LOADER_CONF_OPTS += -DOPENCL_ICD_LOADER_HEADERS_DIR=$(STAGING_DIR)/usr/include

$(eval $(cmake-package))

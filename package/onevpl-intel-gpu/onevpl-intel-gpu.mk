################################################################################
#
# onevpl-intel-gpu
#
################################################################################

ONEVPL_INTEL_GPU_VERSION = 24.1.5
ONEVPL_INTEL_GPU_SITE = $(call github,oneapi-src,oneVPL-intel-gpu,intel-onevpl-$(ONEVPL_INTEL_GPU_VERSION))
ONEVPL_INTEL_GPU_LICENSE = MIT
ONEVPL_INTEL_GPU_LICENSE_FILES = LICENSE
ONEVPL_INTEL_GPU_CPE_ID_VENDOR = intel
ONEVPL_INTEL_GPU_CPE_ID_PRODUCT = onevpl_gpu_runtime
ONEVPL_INTEL_GPU_DEPENDENCIES = libva libvpl

$(eval $(cmake-package))

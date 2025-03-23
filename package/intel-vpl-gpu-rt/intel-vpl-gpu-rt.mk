################################################################################
#
# intel-vpl-gpu-rt
#
################################################################################

INTEL_VPL_GPU_RT_VERSION = 25.1.4
INTEL_VPL_GPU_RT_SITE = $(call github,intel,vpl-gpu-rt,intel-onevpl-$(INTEL_VPL_GPU_RT_VERSION))
INTEL_VPL_GPU_RT_LICENSE = MIT
INTEL_VPL_GPU_RT_LICENSE_FILES = LICENSE
INTEL_VPL_GPU_RT_CPE_ID_VENDOR = intel
INTEL_VPL_GPU_RT_CPE_ID_PRODUCT = onevpl_gpu_runtime
INTEL_VPL_GPU_RT_DEPENDENCIES = libva libvpl

$(eval $(cmake-package))

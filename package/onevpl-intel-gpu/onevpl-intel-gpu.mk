################################################################################
#
# onevpl-intel-gpu
#
################################################################################

ONEVPL_INTEL_GPU_VERSION = 23.4.0
ONEVPL_INTEL_GPU_SITE = $(call github,oneapi-src,oneVPL-intel-gpu,intel-onevpl-$(ONEVPL_INTEL_GPU_VERSION))
ONEVPL_INTEL_GPU_LICENSE = MIT
ONEVPL_INTEL_GPU_LICENSE_FILES = LICENSE
ONEVPL_INTEL_GPU_DEPENDENCIES = libva onevpl

$(eval $(cmake-package))

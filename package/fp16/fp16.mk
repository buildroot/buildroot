################################################################################
#
# fp16
#
################################################################################

FP16_VERSION = 98b0a46bce017382a6351a19577ec43a715b6835
FP16_SITE = $(call github,Maratyszcza,FP16,$(FP16_VERSION))
FP16_LICENSE = MIT
FP16_LICENSE_FILES = LICENSE
FP16_INSTALL_STAGING = YES
# Only installs a header
FP16_INSTALL_TARGET = NO
FP16_DEPENDENCIES = psimd
FP16_CONF_OPTS = \
	-DFP16_BUILD_TESTS=OFF \
	-DFP16_BUILD_BENCHMARKS=OFF \
	-DPSIMD_SOURCE_DIR="$(PSIMD_DIR)"

$(eval $(cmake-package))

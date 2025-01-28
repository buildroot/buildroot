################################################################################
#
# xnnpack
#
################################################################################

XNNPACK_VERSION = d7f398ee5e135ef4f7045802eea973cc6cb26c6c
XNNPACK_SITE = $(call github,google,XNNPACK,$(XNNPACK_VERSION))
XNNPACK_LICENSE = BSD-3-Clause
XNNPACK_LICENSE_FILES = LICENSE
XNNPACK_INSTALL_STAGING = YES
XNNPACK_DEPENDENCIES = cpuinfo fp16 fxdiv pthreadpool
XNNPACK_CONF_OPTS = \
	-DCPUINFO_SOURCE_DIR=$(STAGING_DIR)/usr \
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	-DXNNPACK_BUILD_TESTS=OFF \
	-DXNNPACK_BUILD_BENCHMARKS=OFF \
	-DXNNPACK_ENABLE_KLEIDIAI=OFF \
	-DXNNPACK_USE_SYSTEM_LIBS=ON

$(eval $(cmake-package))

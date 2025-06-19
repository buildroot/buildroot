################################################################################
#
# python-glslang
#
################################################################################

PYTHON_GLSLANG_VERSION = 15.3.0
PYTHON_GLSLANG_SITE = $(call github,KhronosGroup,glslang,$(PYTHON_GLSLANG_VERSION))
PYTHON_GLSLANG_LICENSE = BSD-3-Clause
PYTHON_GLSLANG_LICENSE_FILES = LICENSE.txt
HOST_PYTHON_GLSLANG_DEPENDENCIES = host-python3 host-spirv-tools

HOST_PYTHON_GLSLANG_CONF_OPTS += \
	-DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
	-DGLSLANG_TESTS=OFF

$(eval $(host-cmake-package))

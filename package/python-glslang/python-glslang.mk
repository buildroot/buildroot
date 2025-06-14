################################################################################
#
# python-glslang
#
################################################################################

PYTHON_GLSLANG_VERSION = 11.13.0
PYTHON_GLSLANG_SITE = $(call github,KhronosGroup,glslang,$(PYTHON_GLSLANG_VERSION))
PYTHON_GLSLANG_LICENSE = BSD-3-Clause
PYTHON_GLSLANG_LICENSE_FILES = LICENSE.txt
HOST_PYTHON_GLSLANG_DEPENDENCIES = host-python3

$(eval $(host-cmake-package))

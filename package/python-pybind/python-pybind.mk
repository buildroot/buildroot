################################################################################
#
# python-pybind
#
################################################################################

PYTHON_PYBIND_VERSION = 2.10.1
PYTHON_PYBIND_SITE = $(call github,pybind,pybind11,v$(PYTHON_PYBIND_VERSION))
PYTHON_PYBIND_LICENSE = BSD-3-Clause
PYTHON_PYBIND_LICENSE_FILES = LICENSE
PYTHON_PYBIND_INSTALL_STAGING = YES
PYTHON_PYBIND_INSTALL_TARGET = NO # Header-only library
PYTHON_PYBIND_DEPENDENCIES = python3

PYTHON_PYBIND_CONF_OPTS = \
	-DPYBIND11_INSTALL=ON \
	-DPYBIND11_TEST=OFF \
	-DPYBIND11_NOPYTHON=ON

PYTHON_PYBIND_INSTALL_PATH = $(HOST_DIR)/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pybind11

define PYTHON_PYBIND_INSTALL_MODULE
	mkdir -p $(PYTHON_PYBIND_INSTALL_PATH)
	cp -dpf $(@D)/pybind11/*.py $(PYTHON_PYBIND_INSTALL_PATH)
endef
PYTHON_PYBIND_POST_INSTALL_STAGING_HOOKS += PYTHON_PYBIND_INSTALL_MODULE

$(eval $(cmake-package))

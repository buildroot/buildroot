################################################################################
#
# python-pybind
#
################################################################################

PYTHON_PYBIND_VERSION = 3.0.1
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

# Overwrite 'pybind11/_version.py' with a hard-coded version to replace
# 'pybind11/_version.py' installed by default that require
# pybind11/detail/common.h header in HOST_DIR.
# https://github.com/pybind/pybind11/blob/f5fbe867d2d26e4a0a9177a51f6e568868ad3dc8/pyproject.toml#L93
define PYTHON_PYBIND_INSTALL_MODULE
	mkdir -p $(PYTHON_PYBIND_INSTALL_PATH)
	cp -dpf $(@D)/pybind11/*.py $(PYTHON_PYBIND_INSTALL_PATH)
	sed -e 's#@@PYBIND_VERSION@@#$(PYTHON_PYBIND_VERSION)#' \
		$(PYTHON_PYBIND_PKGDIR)/python-pybind_version.py.in \
		> $(PYTHON_PYBIND_INSTALL_PATH)/_version.py
endef
PYTHON_PYBIND_POST_INSTALL_STAGING_HOOKS += PYTHON_PYBIND_INSTALL_MODULE

$(eval $(cmake-package))

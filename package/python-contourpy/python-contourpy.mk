################################################################################
#
# python-contourpy
#
################################################################################

PYTHON_CONTOURPY_VERSION = 1.3.1
PYTHON_CONTOURPY_SOURCE = contourpy-$(PYTHON_CONTOURPY_VERSION).tar.gz
PYTHON_CONTOURPY_SITE = https://files.pythonhosted.org/packages/25/c2/fc7193cc5383637ff390a712e88e4ded0452c9fbcf84abe3de5ea3df1866
PYTHON_CONTOURPY_LICENSE = BSD-3-Clause
PYTHON_CONTOURPY_LICENSE_FILES = LICENSE
PYTHON_CONTOURPY_DEPENDENCIES = python-pybind host-python-meson-python

$(eval $(meson-package))

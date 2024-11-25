################################################################################
#
# python-contourpy
#
################################################################################

PYTHON_CONTOURPY_VERSION = 1.3.0
PYTHON_CONTOURPY_SOURCE = contourpy-$(PYTHON_CONTOURPY_VERSION).tar.gz
PYTHON_CONTOURPY_SITE = https://files.pythonhosted.org/packages/f5/f6/31a8f28b4a2a4fa0e01085e542f3081ab0588eff8e589d39d775172c9792
PYTHON_CONTOURPY_LICENSE = BSD-3-Clause
PYTHON_CONTOURPY_LICENSE_FILES = LICENSE
PYTHON_CONTOURPY_DEPENDENCIES = python-pybind host-python-meson-python

$(eval $(meson-package))

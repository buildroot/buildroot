################################################################################
#
# python-contourpy
#
################################################################################

PYTHON_CONTOURPY_VERSION = 1.4.0
PYTHON_CONTOURPY_SOURCE = contourpy-$(PYTHON_CONTOURPY_VERSION).tar.gz
PYTHON_CONTOURPY_SITE = https://files.pythonhosted.org/packages/83/5a/a55177dd22553a277388e8a1b3220e92de91bacb28356cdc73caa240121d
PYTHON_CONTOURPY_LICENSE = BSD-3-Clause
PYTHON_CONTOURPY_LICENSE_FILES = LICENSE
PYTHON_CONTOURPY_DEPENDENCIES = python-pybind host-python-meson-python

$(eval $(meson-package))

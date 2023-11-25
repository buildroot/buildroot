################################################################################
#
# python-contourpy
#
################################################################################

PYTHON_CONTOURPY_VERSION = 1.1.0
PYTHON_CONTOURPY_SOURCE = contourpy-$(PYTHON_CONTOURPY_VERSION).tar.gz
PYTHON_CONTOURPY_SITE = https://files.pythonhosted.org/packages/a7/3b/632c003e1dfbc82d32c0466762f2d2cf139d26032626dc65944e38d0e5b9
PYTHON_CONTOURPY_LICENSE = BSD-3-Clause
PYTHON_CONTOURPY_LICENSE_FILES = LICENSE
PYTHON_CONTOURPY_DEPENDENCIES = python-pybind host-python-meson-python

$(eval $(meson-package))

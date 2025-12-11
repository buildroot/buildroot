################################################################################
#
# python-contourpy
#
################################################################################

PYTHON_CONTOURPY_VERSION = 1.3.3
PYTHON_CONTOURPY_SOURCE = contourpy-$(PYTHON_CONTOURPY_VERSION).tar.gz
PYTHON_CONTOURPY_SITE = https://files.pythonhosted.org/packages/58/01/1253e6698a07380cd31a736d248a3f2a50a7c88779a1813da27503cadc2a
PYTHON_CONTOURPY_LICENSE = BSD-3-Clause
PYTHON_CONTOURPY_LICENSE_FILES = LICENSE
PYTHON_CONTOURPY_DEPENDENCIES = python-pybind host-python-meson-python

$(eval $(meson-package))

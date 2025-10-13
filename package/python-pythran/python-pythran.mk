################################################################################
#
# python-pythran
#
################################################################################

PYTHON_PYTHRAN_VERSION = 0.18.0
PYTHON_PYTHRAN_SOURCE = pythran-$(PYTHON_PYTHRAN_VERSION).tar.gz
PYTHON_PYTHRAN_SITE = https://files.pythonhosted.org/packages/94/0a/95a72f09f25dae48f41e367959075ed4c7a0ff02dd3f54eec111501d648a
PYTHON_PYTHRAN_SETUP_TYPE = setuptools
PYTHON_PYTHRAN_LICENSE = BSD-3-Clause
PYTHON_PYTHRAN_LICENSE_FILES = LICENSE docs/LICENSE.rst
HOST_PYTHON_PYTHRAN_DEPENDENCIES = \
	host-python-beniget \
	host-python-gast \
	host-python-numpy \
	host-python-ply

$(eval $(host-python-package))

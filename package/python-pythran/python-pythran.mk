################################################################################
#
# python-pythran
#
################################################################################

PYTHON_PYTHRAN_VERSION = 0.13.1
PYTHON_PYTHRAN_SOURCE = pythran-$(PYTHON_PYTHRAN_VERSION).tar.gz
PYTHON_PYTHRAN_SITE = https://files.pythonhosted.org/packages/8d/d8/b27e8dc3f3a03dcd317d40d9df0ae07ebbd85444585973ceba07716934d0
PYTHON_PYTHRAN_SETUP_TYPE = setuptools
PYTHON_PYTHRAN_LICENSE = BSD-3-Clause
PYTHON_PYTHRAN_LICENSE_FILES = LICENSE docs/LICENSE.rst
HOST_PYTHON_PYTHRAN_DEPENDENCIES = \
	host-python-beniget \
	host-python-gast \
	host-python-numpy \
	host-python-ply

$(eval $(host-python-package))

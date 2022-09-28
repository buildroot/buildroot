################################################################################
#
# python-pythran
#
################################################################################

PYTHON_PYTHRAN_VERSION = 0.12.0
PYTHON_PYTHRAN_SOURCE = pythran-$(PYTHON_PYTHRAN_VERSION).tar.gz
PYTHON_PYTHRAN_SITE = https://files.pythonhosted.org/packages/99/e0/ed0e81de05cfa4ecbcbceec6603d175387d8bc7a6332cbfd155d09958ccf
PYTHON_PYTHRAN_SETUP_TYPE = setuptools
PYTHON_PYTHRAN_LICENSE = BSD-3-Clause
PYTHON_PYTHRAN_LICENSE_FILES = LICENSE docs/LICENSE.rst
HOST_PYTHON_PYTHRAN_DEPENDENCIES = \
	host-python-beniget \
	host-python-gast \
	host-python-numpy \
	host-python-ply

$(eval $(host-python-package))

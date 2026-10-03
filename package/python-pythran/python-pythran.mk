################################################################################
#
# python-pythran
#
################################################################################

PYTHON_PYTHRAN_VERSION = 0.19.0
PYTHON_PYTHRAN_SOURCE = pythran-$(PYTHON_PYTHRAN_VERSION).tar.gz
PYTHON_PYTHRAN_SITE = https://files.pythonhosted.org/packages/bb/a3/03098a8a5d2c9f801c227cf941d85976934f5f47307ef3d819734370acdc
PYTHON_PYTHRAN_SETUP_TYPE = setuptools
PYTHON_PYTHRAN_LICENSE = BSD-3-Clause
PYTHON_PYTHRAN_LICENSE_FILES = LICENSE docs/LICENSE.rst
HOST_PYTHON_PYTHRAN_DEPENDENCIES = \
	host-python-beniget \
	host-python-gast \
	host-python-numpy \
	host-python-ply

$(eval $(host-python-package))

################################################################################
#
# python-pythran
#
################################################################################

PYTHON_PYTHRAN_VERSION = 0.15.0
PYTHON_PYTHRAN_SOURCE = pythran-$(PYTHON_PYTHRAN_VERSION).tar.gz
PYTHON_PYTHRAN_SITE = https://files.pythonhosted.org/packages/82/31/cc6fd7a2b91efc6cdb03e7c42df895b4a65a8f049b074579d45d1def746f
PYTHON_PYTHRAN_SETUP_TYPE = setuptools
PYTHON_PYTHRAN_LICENSE = BSD-3-Clause
PYTHON_PYTHRAN_LICENSE_FILES = LICENSE docs/LICENSE.rst
HOST_PYTHON_PYTHRAN_DEPENDENCIES = \
	host-python-beniget \
	host-python-gast \
	host-python-numpy \
	host-python-ply

$(eval $(host-python-package))

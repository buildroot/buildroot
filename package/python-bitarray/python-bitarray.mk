################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 2.9.2
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/c7/bf/25cf92a83e1fe4948d7935ae3c02f4c9ff9cb9c13e977fba8af11a5f642c
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

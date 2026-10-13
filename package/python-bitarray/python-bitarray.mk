################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 3.12.1
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/e7/af/9f136a8191822bc9277fa6af9241619ad6a21e0638b694bcea1b0f8d0d88
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 2.9.3
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/0d/c7/a85f206e6b2fddb93964efe53685ad8da7d856e6975b005ed6a88f25b010
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

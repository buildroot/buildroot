################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 3.7.2
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/e8/c1/644ea86b6f1a0864f656a3b3ee5bf8c29daa895cb3233942315fe065ea3a
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

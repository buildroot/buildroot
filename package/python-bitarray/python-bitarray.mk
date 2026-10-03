################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 3.11.0
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/04/f7/6765577df59e2345036e435f7e983e1c291d67b7d76a51918eff04ad1494
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

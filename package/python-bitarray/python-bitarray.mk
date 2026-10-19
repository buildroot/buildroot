################################################################################
#
# python-bitarray
#
################################################################################

PYTHON_BITARRAY_VERSION = 3.12.3
PYTHON_BITARRAY_SOURCE = bitarray-$(PYTHON_BITARRAY_VERSION).tar.gz
PYTHON_BITARRAY_SITE = https://files.pythonhosted.org/packages/a9/cc/aa09a20048dd650d9a36bd70c26b2688413066d65acc9f484f94b9929108
PYTHON_BITARRAY_SETUP_TYPE = setuptools
PYTHON_BITARRAY_LICENSE = Python-2.0
PYTHON_BITARRAY_LICENSE_FILES = LICENSE

$(eval $(python-package))

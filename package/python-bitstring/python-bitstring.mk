################################################################################
#
# python-bitstring
#
################################################################################

PYTHON_BITSTRING_VERSION = 4.3.0
PYTHON_BITSTRING_SOURCE = bitstring-$(PYTHON_BITSTRING_VERSION).tar.gz
PYTHON_BITSTRING_SITE = https://files.pythonhosted.org/packages/0d/43/52859178f337661e2d496262f9061799d99644012b7b02ab5d7c491c21fd
PYTHON_BITSTRING_SETUP_TYPE = setuptools
PYTHON_BITSTRING_LICENSE = MIT
PYTHON_BITSTRING_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-bitstring
#
################################################################################

PYTHON_BITSTRING_VERSION = 4.0.1
PYTHON_BITSTRING_SOURCE = bitstring-$(PYTHON_BITSTRING_VERSION).tar.gz
PYTHON_BITSTRING_SITE = https://files.pythonhosted.org/packages/d2/64/e733b18349be383a4b7859c865d6c9e5ccc5845e9b4258504055607ec1cb
PYTHON_BITSTRING_SETUP_TYPE = setuptools
PYTHON_BITSTRING_LICENSE = MIT
PYTHON_BITSTRING_LICENSE_FILES = LICENSE

$(eval $(python-package))

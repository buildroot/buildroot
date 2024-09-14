################################################################################
#
# python-bitstring
#
################################################################################

PYTHON_BITSTRING_VERSION = 4.2.3
PYTHON_BITSTRING_SOURCE = bitstring-$(PYTHON_BITSTRING_VERSION).tar.gz
PYTHON_BITSTRING_SITE = https://files.pythonhosted.org/packages/d8/d0/d6f57409bb50f54fe2894ec5a50b5c04cb41aa814c3bdb8a7eeb4a0f7697
PYTHON_BITSTRING_SETUP_TYPE = setuptools
PYTHON_BITSTRING_LICENSE = MIT
PYTHON_BITSTRING_LICENSE_FILES = LICENSE

$(eval $(python-package))

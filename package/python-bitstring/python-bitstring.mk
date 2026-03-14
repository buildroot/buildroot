################################################################################
#
# python-bitstring
#
################################################################################

PYTHON_BITSTRING_VERSION = 4.4.0
PYTHON_BITSTRING_SOURCE = bitstring-$(PYTHON_BITSTRING_VERSION).tar.gz
PYTHON_BITSTRING_SITE = https://files.pythonhosted.org/packages/36/d3/de6fe4e7065df8c2f1ac1766f5fdccbe75bc18af2cf2dbeecd34d68e1518
PYTHON_BITSTRING_SETUP_TYPE = setuptools
PYTHON_BITSTRING_LICENSE = MIT
PYTHON_BITSTRING_LICENSE_FILES = LICENSE

$(eval $(python-package))

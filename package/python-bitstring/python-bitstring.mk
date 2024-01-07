################################################################################
#
# python-bitstring
#
################################################################################

PYTHON_BITSTRING_VERSION = 4.1.4
PYTHON_BITSTRING_SOURCE = bitstring-$(PYTHON_BITSTRING_VERSION).tar.gz
PYTHON_BITSTRING_SITE = https://files.pythonhosted.org/packages/7f/07/0fd502a29127b968bada3d1824a8af997546d2b9ff73f00e800b3d9888cb
PYTHON_BITSTRING_SETUP_TYPE = setuptools
PYTHON_BITSTRING_LICENSE = MIT
PYTHON_BITSTRING_LICENSE_FILES = LICENSE

$(eval $(python-package))

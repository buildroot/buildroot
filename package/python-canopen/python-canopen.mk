################################################################################
#
# python-canopen
#
################################################################################

PYTHON_CANOPEN_VERSION = 2.0.0
PYTHON_CANOPEN_SOURCE = canopen-$(PYTHON_CANOPEN_VERSION).tar.gz
PYTHON_CANOPEN_SITE = https://files.pythonhosted.org/packages/9e/d6/6ced4b410b904aeee5f7d0227187eae95a5ad769f01014a74fc0e016845e
PYTHON_CANOPEN_SETUP_TYPE = setuptools
PYTHON_CANOPEN_LICENSE = MIT
PYTHON_CANOPEN_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

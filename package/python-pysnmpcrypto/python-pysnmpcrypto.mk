################################################################################
#
# python-pysnmpcrypto
#
################################################################################

PYTHON_PYSNMPCRYPTO_VERSION = 0.1.0
PYTHON_PYSNMPCRYPTO_SOURCE = pysnmpcrypto-$(PYTHON_PYSNMPCRYPTO_VERSION).tar.gz
PYTHON_PYSNMPCRYPTO_SITE = https://files.pythonhosted.org/packages/e6/70/b71f5f1321ea548a7152fc23926258caaec353c8c3edce1aaafbb030ba76
PYTHON_PYSNMPCRYPTO_SETUP_TYPE = poetry
PYTHON_PYSNMPCRYPTO_LICENSE = BSD-2-Clause
PYTHON_PYSNMPCRYPTO_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

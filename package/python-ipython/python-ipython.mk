################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 9.18.1
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/38/04/0d945c72d5b77527273ecb4c66aa2436de7a3b3bbe3da345bf053232b886
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))

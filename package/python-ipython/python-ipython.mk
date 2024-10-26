################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 8.29.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/85/e0/a3f36dde97e12121106807d80485423ae4c5b27ce60d40d4ab0bab18a9db
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))

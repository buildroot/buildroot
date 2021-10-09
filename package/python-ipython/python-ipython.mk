################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 7.28.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/e2/c8/7046d0409a90e31263d5bbaa708347d522ac584a1140c01a951d9deb1792
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = distutils

$(eval $(python-package))

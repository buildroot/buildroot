################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 8.6.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/7f/59/05e94e067afb61460f0d5229a1edb800e2f65b8436085fad9cd262d80d45
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))

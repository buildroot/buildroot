################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 9.17.1
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/b9/32/99451b1283ec5d92ad77073f12e1c667dc10775384d8f15c2914207149dd
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))

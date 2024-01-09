################################################################################
#
# python-ipython
#
################################################################################

PYTHON_IPYTHON_VERSION = 8.20.0
PYTHON_IPYTHON_SOURCE = ipython-$(PYTHON_IPYTHON_VERSION).tar.gz
PYTHON_IPYTHON_SITE = https://files.pythonhosted.org/packages/c5/d1/187474d64bdefcb6804c1a3a1597d9e94f287e71c06f50f7784d56833fb7
PYTHON_IPYTHON_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_LICENSE_FILES = COPYING.rst LICENSE
PYTHON_IPYTHON_CPE_ID_VENDOR = ipython
PYTHON_IPYTHON_CPE_ID_PRODUCT = ipython
PYTHON_IPYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))

################################################################################
#
# python-cython
#
################################################################################

PYTHON_CYTHON_VERSION = 3.1.2
PYTHON_CYTHON_SOURCE = cython-$(PYTHON_CYTHON_VERSION).tar.gz
PYTHON_CYTHON_SITE = https://files.pythonhosted.org/packages/18/40/7b17cd866158238db704965da1b5849af261dbad393ea3ac966f934b2d39
PYTHON_CYTHON_SETUP_TYPE = setuptools
PYTHON_CYTHON_LICENSE = Apache-2.0
PYTHON_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt

$(eval $(host-python-package))

################################################################################
#
# python-cython
#
################################################################################

PYTHON_CYTHON_VERSION = 0.29.30
PYTHON_CYTHON_SOURCE = Cython-$(PYTHON_CYTHON_VERSION).tar.gz
PYTHON_CYTHON_SITE = https://files.pythonhosted.org/packages/d4/ad/7ce0cccd68824ac9623daf4e973c587aa7e2d23418cd028f8860c80651f5
PYTHON_CYTHON_SETUP_TYPE = setuptools
PYTHON_CYTHON_LICENSE = Apache-2.0
PYTHON_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt

$(eval $(host-python-package))

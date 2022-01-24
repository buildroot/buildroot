################################################################################
#
# python3-cython
#
################################################################################

# Please keep in sync with package/python-cython/python-cython.mk
PYTHON3_CYTHON_VERSION = 0.29.26
PYTHON3_CYTHON_SOURCE = Cython-$(PYTHON3_CYTHON_VERSION).tar.gz
PYTHON3_CYTHON_SITE = https://files.pythonhosted.org/packages/bc/fa/8604d92ef753e0036d807f1b3179813ab2fa283e3b19c926e11673c8205b
PYTHON3_CYTHON_SETUP_TYPE = setuptools
PYTHON3_CYTHON_LICENSE = Apache-2.0
PYTHON3_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt
HOST_PYTHON3_CYTHON_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

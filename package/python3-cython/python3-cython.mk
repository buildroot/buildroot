################################################################################
#
# python3-cython
#
################################################################################

# Please keep in sync with package/python-cython/python-cython.mk
PYTHON3_CYTHON_VERSION = 0.29.24
PYTHON3_CYTHON_SOURCE = Cython-$(PYTHON3_CYTHON_VERSION).tar.gz
PYTHON3_CYTHON_SITE = https://files.pythonhosted.org/packages/59/e3/78c921adf4423fff68da327cc91b73a16c63f29752efe7beb6b88b6dd79d
PYTHON3_CYTHON_SETUP_TYPE = setuptools
PYTHON3_CYTHON_LICENSE = Apache-2.0
PYTHON3_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt
HOST_PYTHON3_CYTHON_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

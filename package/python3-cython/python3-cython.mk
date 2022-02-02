################################################################################
#
# python3-cython
#
################################################################################

# Please keep in sync with package/python-cython/python-cython.mk
PYTHON3_CYTHON_VERSION = 0.29.27
PYTHON3_CYTHON_SOURCE = Cython-$(PYTHON3_CYTHON_VERSION).tar.gz
PYTHON3_CYTHON_SITE = https://files.pythonhosted.org/packages/eb/46/80dd9e5ad67ebc766ff3229901bde4a7bc82907efe93cd7007c4df458dd5
PYTHON3_CYTHON_SETUP_TYPE = setuptools
PYTHON3_CYTHON_LICENSE = Apache-2.0
PYTHON3_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt
HOST_PYTHON3_CYTHON_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

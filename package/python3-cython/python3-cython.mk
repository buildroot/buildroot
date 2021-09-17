################################################################################
#
# python3-cython
#
################################################################################

# Please keep in sync with package/python-cython/python-cython.mk
PYTHON3_CYTHON_VERSION = 0.29.23
PYTHON3_CYTHON_SOURCE = Cython-$(PYTHON3_CYTHON_VERSION).tar.gz
PYTHON3_CYTHON_SITE = https://files.pythonhosted.org/packages/d9/cd/0d2d90b27219c07f68f1c25bcc7b02dd27639d2180add9d4b73e70945869
PYTHON3_CYTHON_SETUP_TYPE = setuptools
PYTHON3_CYTHON_LICENSE = Apache-2.0
PYTHON3_CYTHON_LICENSE_FILES = COPYING.txt LICENSE.txt
HOST_PYTHON3_CYTHON_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
